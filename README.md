# Compiler for the C-- language

A small step-through debug interpreter for a subset of C. Check out the [specification](#specification) for more information.

While it's functional, the plan is to rewrite it to use the pattern layed out in the proof-of-concept [STM-Fun](https://github.com/Tehnix/STM-Fun), which showcases how to split the repl and eval apart.

You can test the program out with the C programs found in `test/data/*.c`, it will go something like below,

<img width="793" alt="screenshot 2017-12-02 14 04 47" src="https://user-images.githubusercontent.com/1189998/33778691-2c1122b6-dc8d-11e7-996d-97aa3e6a4447.png">

## Building the interpreter

To build the interpreter it is recommended that you use the `stack` tool from https://docs.haskellstack.org. In the source code,

```bash
$ stack setup
$ stack build
```

You can now run the repl on a file via,

```bash
$ stack exec -- c-repl "path/to/program.c"
```

## Specification
This specification is taken from the [C-- Language Specification](https://www2.cs.arizona.edu/~debray/Teaching/CSc453/DOCS/cminusminusspec.html), and then extended a bit with some additional C features.
