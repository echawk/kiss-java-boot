This is a repo that aims to bootstrap Java on KISS Linux, without using precompiled
binaries.

My current plan is to stick as close to GNU Guix's [java.scm](https://git.savannah.gnu.org/cgit/guix.git/tree/gnu/packages/java.scm)
boostrap chain as close as possible. [Diagram](https://bootstrappable.org/images/jdk-bootstrap.png)

The following are currently packaged:
* jikes (1.22)
* gnuclasspath (0.93)
* fastjar (0.98)
* jamvm (1.5.1)
* ant (1.8.4)
* ecj (3.2.2)
* ecj-javac-wrapper
* gnuclasspath (0.99)

The following are WIP:
* classpath-jamvm-wrappers
* gnuclasspath (git)
* jamvm (2.0.0)
* ecj (4.2.1)

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

## JDK 0.5

JDK 0.5 is effectively a transition JDK, from 0 to 1 (the final bootstrap JDK).

These are the components:

software          | version | desc
--------:         |--------:|-----:
fastjar           | 0.98    | Java's `jar` written in C
ant-bootstrap     | 1.8.4   | Java build tool
ecj               | 3.2.2   | Incremental Java Compiler
ecj-javac-wrapper | git     | Wrapper for ECJ to behave like `javac`
gnuclasspath      | 0.99    | Java Standard Library

To build & Install:
```shell
cd jdk0.5
export KISS_PATH="$PWD:$KISS_PATH"
kiss build fastjar ant-bootstrap
sh /etc/profile.d/apache-ant-bootstrap.sh
kiss build ecj ecj-javac-wrapper
kiss build gnuclasspath
```

