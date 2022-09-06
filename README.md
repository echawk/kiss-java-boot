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
* ecj (4.2.1)
* gcj (6.4.0)
* java-gcj-compat (6.4.0)
* ecj (4.4.2)
* ant (1.8.4)

The following are WIP:
* openjdk7 (6.2.28)
* openjdk8 (3.22.0)

If you have any experience or are able to get a package to compile, please submit a PR or issue!
Any and all help is appreciated!

# Requirements

You'll need all of the software packaged under `extra/`, the unofficial
community repo, as well as access to kiss-xorg.

# Current Issue

My current issue when building openjdk8 is a CRC error
(full build log [here](https://0x0.st/oSgD.KDGklH)).

What's odd is that when building openjdk7 with itself (not using the
icedtea-boot target), a CRC error also occurs. That leads me to think that there
is some issue with openjdk7's zip implementation.

UPDATE: this issue seems to have been *slightly* fixed, by instead using
fastjar as the jar implementation during build, however now there are bigger
build issues.

When trying to compile openjdk7 with itself, the build fails spectacularly: [log](https://0x0.st/oSEF.ddgpJC)

When trying to build openjdk8 with openjdk7, the build also fails: [log](https://0x0.st/oSEC.GKgGHb)

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
cd ..
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
cd ..
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
cd ..
```

## JDK 2

JDK 2 contains the final bootstrap JDK, that being GCJ. We are able to build
it now because we have all of the requisite software built. We also build
the latest release of ECJ that we can, and replace ant-bootstrap with ant.

software        | version | desc
--------:       |--------:|-----:
gcj6            | 6.4.0   | GNU Java Compiler
java-gcj-compat | 6.4.0   | Alpine's wrapper to have GCJ behave like OpenJDK.
ant             | 1.8.4   | Java build tool (without environment script)
ecj             | 4.4.2   | Incremental Java Compiler

To build & Install:
```shell
cd jdk2
export KISS_PATH="$PWD:$KISS_PATH"
kiss build ecj
kiss build gcj6
kiss build java-gcj-compat
kiss remove ant-bootstrap
kiss build ant
cd ..
```

## OpenJDK7 (Java 7)

OpenJDK7 is the first OpenJDK that we are able to build and is able to build
OpenJDK8 (Java 8).

To build & Install:
```shell
export KISS_PATH="$PWD:$KISS_PATH"
kiss build openjdk7

# openjdk7's jar implementation is totally busted.
# So we rebuild fastjar, and switch to it for jar.
kiss b fastjar
kiss a fastjar /usr/lib/jvm/java-1.7-openjdk/bin/jar
```

## OpenJDK8 (Java 8)

WIP. See above.

Useful links:
* Alpine's buildscript [here](https://git.alpinelinux.org/aports/tree/community/openjdk8/APKBUILD).
* Void's buildscript [here](https://github.com/void-linux/void-packages/blob/master/srcpkgs/openjdk8/template).

Help is very much appreciated!
