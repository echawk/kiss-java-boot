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
* classpath-jamvm-wrappers
* gnuclasspath (git)
* jamvm (2.0.0)

The following are WIP:
* ecj (4.2.1)

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

## JDK 1

JDK 1 is the second to last bootstrap JDK and is used to compile GCJ
(GNU Java Compiler).

software                 | version | desc
--------:                |--------:|-----:
classpath-jamvm-wrappers | git     | Wrapper for GNUclasspath Java tools
jamvm                    | 2.0.0   | Java Virtual Machine
ecj                      | 4.2.1   | Incremental Java Compiler
gnuclasspath             | git     | Java Standard Library

To build & Install:
```shell
cd jdk1
export KISS_PATH="$PWD:$KISS_PATH"
kiss build classpath-jamvm-wrappers
kiss build gnuclasspath
kiss build jamvm
kiss build ecj
```

## JDK 2

JDK 2 contains the final bootstrap JDK, that being GCJ. We are able to build
it now because we have all of the requisite software built.

software        | version | desc
--------:       |--------:|-----:
gcj6            | 6.4.0   | GNU Java Compiler
java-gcj-compat | 6.4.0   | Alpine's wrapper to have GCJ behave like OpenJDK.

To build & Install:
```shell
cd jdk2
export KISS_PATH="$PWD:$KISS_PATH"
kiss build gcj6
kiss build java-gcj-compat
```

## IcedTea2 (Java 7)

IcedTea2 is the first OpenJDK that we are able to build and is able to build
OpenJDK 8 (Java 8).

NOTE: Currently this is a work in progress, as the build script is not working.

Current [issue](https://github.com/ehawkvu/kiss-java-boot/blob/master/icedtea2/build#L87).

Useful links:
* Alpine's buildscript [here](https://git.alpinelinux.org/aports/tree/community/openjdk7/APKBUILD).
* Void's buildscript [here](https://github.com/void-linux/void-packages/blob/master/srcpkgs/openjdk7-bootstrap/template).
* Guix's buildscript [here](https://git.savannah.gnu.org/cgit/guix.git/tree/gnu/packages/java.scm#n770).

Alternatively, we could build IcedTea2 with GCC's java compiler, gcj.
* Alpine's buildscript [here](https://git.alpinelinux.org/aports/tree/community/gcc6/APKBUILD).
* Void's buildscript [here](https://github.com/void-linux/void-packages/blob/master/srcpkgs/gcc6/template).
* AUR's buildscript [here](https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=gcc6).

Help is very much appreciated!
