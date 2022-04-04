This is a repo that aims to bootstrap Java on KISS Linux, without using precompiled
binaries.

My current plan is to stick as close to GNU Guix's [java.scm](https://git.savannah.gnu.org/cgit/guix.git/tree/gnu/packages/java.scm)
boostrap chain as close as possible. [Diagram](https://bootstrappable.org/images/jdk-bootstrap.png)

The following are currently packaged:
* jikes (1.22)
* gnuclasspath (0.93)
* fastjar (0.98)
* jamvm (1.5.1) - however it has not been rigorously tested.

The following are WIP:
* ant (1.8.4)

~~Once jamvm 1.5.1 is packaged, the initial bootstap jdk will be complete. This should allow us to continue following the same chain that guix uses.~~

jamvm is now packged, so work will be on ant (1.8.4). Once this is working, we will be able to move onto bootstrapping ecj (3.2.2).

I am still working on how this repo will be packaged; right now each program has
it's own separate packge directory, however this is possible to change in the future
if it makes maintenance easier. For example, having a 'jdk-stage-0' for the jdk
that consists of jikes@1.22, gnuclasspath@0.93, and jamvm@1.5.1.


If you have any experience or are able to get a package to compile, please submit a PR or issue!
Any and all help is appreciated!

# Installation

The process for installation is almost entirely manual, and I do *not* recommend
you place any of these repos in your `KISS_PATH`, since this repo is strictly
intended to be a testing ground and serve as a way to get java binaries starting
from only source code.

## JDK 0

These are the three components:

software     | version | desc
--------:    |--------:|-----:
jikes        | 1.22    | Java Compiler
gnuclasspath | 0.93    | Java Standard Library
jamvm        | 1.5.1   | Java Virtual Machine

To build & Install:
```shell
cd jdk0
export KISS_PATH="$PWD:$KISS_PATH"
kiss build jikes gnuclasspath jamvm
```

