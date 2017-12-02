# Compiler for the C-- language

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
