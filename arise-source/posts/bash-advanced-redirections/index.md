<!-- BEGIN ARISE ------------------------------
Title:: "Bash, very complicated redirections"

Author:: "Charles Benca"
Description:: "Complicated bash redirections that people usually don't talk about because they just talk about the basic stuff because they just copy paste each other's websites."
Language:: "en"
Thumbnail:: ""
Published Date:: "2025-01-10"

---- END ARISE \\ DO NOT MODIFY THIS LINE ---->

Bash, very complicated redirections

# Introduction

(I'm only talking about bash for the whole article.  I'm assuming you
know the basics of the shell.)

Did you ever need to pipe only the stderr of a process to another
process (and keeping stdout to your terminal/stdout)?  Usually we pipe
stdout of `proc1` to stdin of `proc2` via the simple `proc1 |
proc2`.  We can easily pipe **both** stdout *and* stderr by doing
`proc1 2>&1 | proc2` or by using bash's shortcut `proc1 |& proc2`, but
what about only "sending" stderr to another process?

In almost all situations, **process substitution** will do the job
`proc1 2> >(proc2)`, but awhile ago I was dealing with an old
container technology (not docker) that is kernel-patch based and I
couldn't use process substitution inside because it was showing
errors.  We can also accomplish that with redirections, in a manner
that may seem non-obvious, if we get more complicated:

`proc1 3>&1 1>&2 2>&3 3>&- | proc2`.

Now, what about sending stdout of proc1 to stdin of proc2, and stderr
of proc1 to stdin of proc3?  Again, using process substitution it's a
no brainer:

`proc1 > >(proc2) 2> >(proc3)`,

but how can we do that with redirections? I'm glad you asked:


```bash
(
	(
		./mybin | sed 's/^/out:/' 2>&1
	) 2>&1 1>&5 5>&- | sed 's/^/err:/' 5>&-
) 5>&1
```

, or

```bash
(
	(
		./mybin 3>&1 1>&2 2>&3 3>&- 5>&- | sed 's/^/err:/' 2>&1 1>&5 5>&-
	) 2>&1 | sed 's/^/out:/' 5>&-
) 5>&1
```

, or a variant of this one

```bash
(
	(
		./mybin 2>&1 1>&6 5>&- 6>&- | sed 's/^/err:/' 1>&5 5>&- 6>&-
	) 6>&1 | sed 's/^/out:/' 5>&-
) 5>&1
```

, and many other ways of doing it (in these 3 examples, replace
`./mybin` with `(seq 10 15; seq 20 25 >&2;)` and try it in your
terminal).

# A solid understanding of redirections

Redirections serve to manipulate the **file descriptors** (aka fd) of
programs.  `stdin`, `stdout`, and `stderr` are the names we give to
the fds 0, 1, and 2 respectively.  All programs have fds 0, 1, and 2,
but we can always open and close more fds, including 0, 1, and 2.
File descriptors are like variables in a pogramming language: they
hold something, and that something can be manipulated or exchanged
between variables/file descriptors.

**Important:** Since fds behave like variables, the syntax of the
shell for manipulating them (`dest>&src`) **works exactly like
assigning variables in a programming language (`var1 = var0`)**: The
"value" contained in the fd in **copied** inside the other fd.  When
you start a program from your terminal, usually the 0 will hold your
keyboard, and 1 and 2 will both hold your terminal.  You can think of
programs as being hard-coded to use their "variables" (fd) called "0",
"1", and "2", therefore by changing their values we can change where
the data goes.  We can also delete a "variable" (fd) by using "-" as
the source, like in `5>&-`.  There is more possiblities, like *named
pipes*, but we don't need that.

Processes on *nix are created with the fork() syscall.  The way fork
works is that **the current process, with all its internal memory,
current state, and opened files, is duplicated in RAM** (but it's
optimized so that RAM consumption is negligeable (copy on write)), and
this includes the duplication of the file descriptors.  For this
reason, when we create subshells (the `(` `)` pairs in the commands
above) and manipulate their fds, or when we manipulate our shell's fds
with the `exec` command, all inner or futur **processes will inherit
the same fds** (in the commands above you can replace the `()` with
`{}` (you might need to add a few `;`).  This will run the commands in
the current shell environment instead of creating subshells, but in
that case bash will apply the redirections to each commands anyway, so
the result of the redirections will be the same).

**Important:** Redirections (`3>&1`) can be placed anywhere in one
command (beginning, middle, or end. try this command: `echo > echo.txt
"this is the echo text"`).  It doesn't matter where they are, it only
matters in which order they are relative to each other, **because the
shell executes the redirections from left to right**, with one
exception: when there is a pipe, **bash first sets the pipe, then it
runs the redirections**.  It's for this "exception" that I said
earlier that something was non-obvious.

# How piping only stderr to another process works

Piping only stderr to another process is done like that:

`proc1 3>&1 1>&2 2>&3 3>&- | proc2`

, or you can also do it like that:

`proc1 3>&2 2>&1 1>&3 3>&- | proc2`.

A basic programming excercice is to exchange the values of 2 variables
between them as follow:

```C
// First we declare the variables.
int var1 = 21;
int var2 = 47;

// The easy way to exchange the values is to create a temporary variable.
int temp;

// Now we do the "rotation".
temp = var1;
var1 = var2;
var2 = temp;

// We can also do this "rotation" is the other direction.
temp = var2;
var2 = var1;
var1 = temp;

```

If we go back to `proc1 3>&1 1>&2 2>&3 3>&- | proc2`, the same thing
is happening, because file descriptors behave like variables and we
are doing a "rotation".  **First,** bash sets the pipe on fd 1 of
proc1.  Before running the redirections, the fds of proc1 look like
this:

```text
proc1:
 0< keyboard
 1> pipe to proc2
 2> terminal output
```

Since we want to pipe *only* stderr (2), we need to exchange the
values in the fds 1 and 2.  We create a temporary fd 3 to hold a copy
of the pipe.

```text
# After running 3>&1 (read like "var3 = var1" in a programming language)
proc1:
 0< keyboard
 1> pipe to proc2
 2> terminal output
 3> pipe to proc2
```

Then we begin the rotation.

```text
# After running 1>&2
proc1:
 0< keyboard
 1> terminal output
 2> terminal output
 3> pipe to proc2
```

```text
# After running 2>&3
proc1:
 0< keyboard
 1> terminal output
 2> pipe to proc2
 3> pipe to proc2
```

Now we could stop here, but since we can delete our temporary file
descriptor, we should.

```text
# After running 3>&-
proc1:
 0< keyboard
 1> terminal output
 2> pipe to proc2
```

Now that we are done, we write this in the proc1 section of the
command:

`proc1 3>&1 1>&2 2>&3 3>&- | proc2`.

`proc2` was like this all along:

```text
proc2:
 0< [something]
 1> terminal output
 2> terminal output
```

This "rotation" can be done in the other "direction", therefore this
has the same end result:

`proc1 3>&2 2>&1 1>&3 3>&- | proc2`.

# More complicated situation

Now let's examine how we can accomplish the following thing using only
pipes and redirections:

`proc1 1> >(proc2) 2> >(proc3)`,

which is piping stdout of proc1 to proc2, and piping stderr of proc1
to proc3.

Let's start with a basic "skeleton" command that doesn't work and
we'll fix it step by step until we are done.

```bash
proc1 | proc2 | proc3
```

It will make our lifes easier if we have the first part in a sub list
or subshell.

```bash
( proc1 | proc2 ) | proc3
```

The first things that I want to fix is for proc1 to send its
**stderr** to proc3.  To do that we can manipulate the fds of the
subshell.  I'll copy the pipe to fd 2 of the subshell.

```bash
( proc1 | proc2 ) 2>&1 | proc3
```

Now I want proc2 to send its outputs to my terminal instead of into
proc3.  I'll make a backup of my terminal in a temporary fd (there are
other way to make this command work, some are simpler that what I'm
about to do, and I leave this as an excercice for you).

```bash
( ( proc1 | proc2 ) 2>&1 | proc3 ) 5>&1
```

I can connect stdout of the subshell to my terminal, but **after** the
pipe has been copied to stderr of the subshell.

```bash
( ( proc1 | proc2 ) 2>&1 1>&5 | proc3 ) 5>&1
```

It may not be obvious, but proc2 could print error messages into its
own stderr.  If we do nothing, these messages will go into proc3.  I
will copy fd 1 of proc2 into its own fd 2 so that everything proc2
prints will go to the terminal.

```bash
(  ( proc1 | proc2 2>&1 )  2>&1 1>&5 | proc3 )  5>&1
```

**We are already done**.  We can optionnaly close the temporary fd we
created.  We have to close it in each "branches" of the subshell, so
first we close it on proc3.

```bash
(  ( proc1 | proc2 2>&1 )  2>&1 1>&5 | proc3 5>&- )  5>&1
```

Finally, we can close fd 5 on the subshell after it was copied into fd
1.

```bash
(  ( proc1 | proc2 2>&1 )  2>&1 1>&5 5>&- | proc3 5>&- )  5>&1
```

We can expand it to see more clearly.

```bash
(
	(
		proc1 | proc2 2>&1
	) 2>&1 1>&5 5>&- | proc3 5>&-
) 5>&1
```

For **testing**, we can replace `proc1` with `(seq 10 15; seq 20 25
>&2;)` which will produce, in a subshell, outputs to both stdout and
stderr.  Also we replace proc2 and proc3 with sed commands to append
text at the beginning of lines, so that we know through which sed
command the text goes.

```bash
(
	(
		(seq 10 15; seq 20 25 >&2;) | sed 's/^/out:/' 2>&1
	) 2>&1 1>&5 5>&- | sed 's/^/err:/' 5>&-
) 5>&1
```

Here it is on one line so that you can copy paste to test in your
terminal:

```bash
( ( (seq 10 15; seq 20 25 >&2;) | sed 's/^/out:/' 2>&1 ) 2>&1 1>&5 5>&- | sed 's/^/err:/' 5>&- ) 5>&1
```

# Conclusion

Note that the bash manual states that we must not use fds from 10 and
above because they are used internaly by bash.  We should restrict
ourselves to numbers from 0 to 9.

I wondered whether we can make a sort of "loop" of redirections that
eventually comes back to the first program.  The answer seems to be no
unless we use something called `coproc`, but even I (a bash
enthusiast) didn't look into coprocs.  For more advanced cases like
loops, there are commands whose purpose is to do more advanced
redirections, because this is essentially a "problem" with the syntax
of the shell, it's not a technical constraint.

On Linux, pipe goes in only one direction, but on some BSDs pipes are
bidirectionnal.











