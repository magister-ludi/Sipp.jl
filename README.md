# Simple Image Processing Pipeline

Causticity's [Simple Image Processing Pipeline](https://github.com/Causticity/sipp)
is written in Go. This port to Julia provides most of the same capabilities, but
takes advantage of Julia's array interfaces and multiple dispatch.

At present, the code is structured in a very similar way to Causticity's version.
Design differences are described in
[a separate document](./differences.md).

## Installation and usage

This assumes that you have installed Julia. The easiest way to
do this is to install Juliaup. Instructions are available
[here](https://github.com/JuliaLang/juliaup).

Clone this repository to a convenient location
```
git clone https://github.com/magister-ludi/Sipp.jl.git
```
The top-level directory contains a bash script, `sipp`, and a
Windows batch file, `sipp.bat`. These scripts can be run from any
location. For *nix (including Cygwin) or a Windows command prompt, type

```
/path/to/Sipp.jl/sipp
```

For Windows (command prompt, PowerShell or Cygwin), type

```
\path\to\Sipp.jl\sipp.bat
```

The first time the script/batch file runs there may be some preliminary
output while packages used by Sipp.jl are installed.

If the script executes correctly, it will cause the package to diplay
information about valid arguments:

    usage: <PROGRAM> [-t] [-g] [--ht] [--hs] [--hde] [--de] [-e] [-f]
                     [--fls] [-a] [-v] [--csv] [--pre PRE] [-h] inp

    positional arguments:
      inp         input image

    optional arguments:
      -t          save thumbnail image
      -g          save gradient real and imaginary images
      --ht        save histogram image
      --hs        save histogram image with the center spike suppressed
      --hde       save histogram Delentropy image
      --de        save Delentropy image
      -e          save conventional entropy image
      -f          save fft real and imaginary images
      --fls       save fft log spectrum image
      -a          save all images
      -v          verbose mode
      --csv       save the name of the image, a comma, and the
                  Delentropy,on a single line.
      --pre PRE   output prefix (default: "sipp")
      -h, --help  show this help message and exit

## Does it work?

My experiments show that the results are (almost) indentical to the
results of the Go implementation. Variations are described in
[differences](./differences.md).

Benchmarking shows that this implementaion is as fast as, or faster than,
the Go version in its "compile and run" mode.
For runs of a few milliseconds, or a few seconds, this is fast enough.

## Where to from here?

[sipp](https://github.com/Causticity/sipp) and Sipp.jl have been
constructed to demonstrate some of the theory provided in
*[Reflections on Shannon Information: In search of a natural 
information-entropy for images](https://arxiv.org/abs/1609.01117)*
by Kieran G. Larkin. Readers of that article may find one or the
other version useful for investigating its content.

Changes are planned for the next versions of Sipp.jl. These are outlined
[here](./TODO.md).
