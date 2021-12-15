# Assembly-Exercises
This is a collection of assembly exercises.

<ul>
<li><b>Exercise 1 - Additions and subtraction.</b></li>
<li><b>Exercise 2 - Registers.</b></li>
<li><b>Exercise 3 - Geometric figures area calculator.</b></li>
<li><b>Exercise 4 - Geometric figures area calculator.</b></li>
</ul>

## How to use

<b> It's necessary a Unix system</b>. If you're using windows, you can emulate linux using <a href="https://docs.microsoft.com/en-us/windows/wsl/install">WSL</a>.

First you have to install <b> gcc-multilib</b>:
```console
sudo apt-get install gcc-multilib
```
----------------------------------------------------
If you're using a <b>64 bit</b> environment, you can type the following command to build the object file:

```console
as -32 code.s -o output.o
```
and use this command to build the executable: 

```console
ld -m elf_i386 output.o -lc -lm -dynamic-linker /lib/ld-linux.so.2 -o output
```
---------------------------------------
Otherwise if you're using a <b>32 bit</b> enviroment, you can use:
```console
as code.s -o output.o
```
and for building the executable:

```console
ld output.o -lc -lm -dynamic-linker /lib/ld-linux.so.2 -o output
```
----------------------------------
to <b>run</b> the executable simply type:
```console
./output
```


