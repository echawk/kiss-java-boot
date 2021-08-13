This is a repo that aims to bootstrap Java on KISS Linux, without using precompiled
binaries.

My current plan is to stick as close to GNU Guix's [java.scm](https://git.savannah.gnu.org/cgit/guix.git/tree/gnu/packages/java.scm)
boostrap chain as close as possible. [Diagram](https://bootstrappable.org/images/jdk-bootstrap.png)

The following are currently packaged:
* jikes (1.22)
* gnuclasspath (0.93)
* fastjar (0.98)

The following are WIP:
* jamvm (1.5.1)

Once jamvm 1.5.1 is packaged, the initial bootstap jdk will be complete.
This should allow us to continue following the same chain that guix uses.

I am still working on how this repo will be packaged; right now each program has
it's own separate packge directory, however this is possible to change in the future
if it makes maintenance easier. For example, having a 'jdk-stage-0' for the jdk
that consists of jikes@1.22, gnuclasspath@0.93, and jamvm@1.5.1.

