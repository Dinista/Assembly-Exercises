# Assembly-Exercises
This is a collection of assembly exercises.

## How to use

<b> It's necessary a Unix system</b>. If you're using windows, you can emulate linux using <a href="https://docs.microsoft.com/en-us/windows/wsl/install">WSL</a>.

If you're using a <b>64 bit</b> environment, you can type the following command to build the object file:

```console
as -32 code.s -o output.o
```
and use this command to build the executable: 

```console
ld -m elf_i386 output.o -lc -lm -dynamic-linker /lib/ld-linux.so.2 -o output
```
Otherwise if you're using a <b>32 bit</b> enviroment, you can use:
```console
as code.s -o output.o
```
and for building the executable:

```console
ld output.o -lc -lm -dynamic-linker /lib/ld-linux.so.2 -o output
```

to <b>run</b> the executable simply type:
```console
./output
```


