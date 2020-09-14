# MrRacket

A script to easily run Racket files created with DrRacket using the command-line Racket REPL.


## What's MrRacket for?

DrRacket is the editor of choice to teach Racket following the approach of [How to design programs](https://htdp.org/).
Unfortunately, it is also [inaccessible with screenreaders](https://github.com/racket/drracket/issues/219);
I created this simple script `mrracket` as a workaround.


## Prerequisites

MrRacket is a Bash script, and hence it requires Bash. It has only
been tested on Ubuntu Linux, since its first users will use that
particular flavor of GNU/Linux.

MrRacket relies on a standard installation of Racket, which you can
[download here](https://download.racket-lang.org/).


## Installation

Download [`mrracket`](https://raw.githubusercontent.com/bugcounting/mrracket/master/mrracket) and put it in a directory in the path.

Alternatively, you can download and use the `install.sh` script, which
will install DrRacket, add its executables directory to the path, 
put MrRacket into the same directory, and add a desktop launcher for DrRacket.

```
wget -O - http://tiny.cc/mrracket | bash -l
```


## Usage

To evaluate a Racket file `example.rkt` created with DrRacket in one of the HtDP languages (BSL, BSL+, ISL, ISL+, and ASL):

```
mrracket example.rkt
```

This achieves something similar to clicking *Run* in DrRacket:
it loads the definitions in `example.rkt` and runs any tests defined there.
Afterwards, it also opens Racket's REPL prompt, which is like DrRacket's interactions area.
However, the definitions in `example.rkt` are only available after you type:

```
,enter example.rkt
```

at the prompt.

Whenever you edit the content of `example.rkt` with your favorite text
editor, you have to repeat the process:

   - Exit the Racket environment with `Ctrl+D`
   - Rerun `mrracket example.rkt`
   - Type `,enter example.rkt` at the prompt

Finally, you can also initialize a new Racket file `new.rkt` in a way that it is compatible
with DrRacket's files:

```
mrracket -L LANGUAGE new.rkt
```

where `LANGUAGE` is one of the HtDP languages: `BSL`, `BSL+`, `ISL`, `ISL+`, `ASL`.
This command creates a new file `new.rkt`, which you can edit and run with DrRacket
or with MrRacket.
