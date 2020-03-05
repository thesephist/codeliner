# Codeliner 💻

Codeliner is a command-line utility to generate _codelines_, a bird's eye view image of your source code files. Like an **outline**, but for your **code**, hence the name. A codeline looks like a [minimap](https://code.visualstudio.com/docs/getstarted/userinterface#_minimap), and is a rough picture of the shape of your source code, once the literal characters are abstracted into lines and shapes. I've also chosen to mark delimiters (`() {} []`) with colored blocks, for some extra fun.

As an example, here's the codeline image of [`src/generate.ink`](src/generate.ink), the main file of the Codeliner program itself. You can see some patterns in indentation, scoping, and line spacing in this rough view of the source code.

![Codeline of src/generate.ink](assets/ex.bmp)

Codeliner is written in [Ink](https://github.com/thesephist/ink), a minimal toy functional programming language I made, and outputs `*.bmp` bitmap image files, which can be converted into more efficient formats like PNG with other utilities.

## Usage

Codeliner is intended to be used as a command line tool, and has one syntax.

```sh
# syntax
./codeliner.ink <input file> [<output file>]

# for example
./codeliner.ink input-file.txt output-path.bmp
```

This will create a codeline image of `input-file.txt` and place it at `output-path.bmp` as an image file. The output path is optional -- if you omit it, the output defaults to `out.bmp` in the current directory, and overwrites any existing file with that name.

## Examples

Outlines of code revealed by Codeliner can show interesting patterns and differences between languages. To that end, we've compiled a few examples here to complement the Ink program codeline above.

### Go

source: [etcd source snippet](https://github.com/etcd-io/etcd/blob/master/raft/status.go)

![Codeline of status.go](assets/go.bmp)

### JavaScript

source: [Preact source snippet](https://github.com/preactjs/preact/blob/master/src/diff/props.js)

![Codeline of props.js](assets/js.bmp)

### CSS

source: [Blocks.css source](https://github.com/thesephist/blocks.css/blob/master/src/blocks.css)

![Codeline of blocks.css](assets/css.bmp)

### Lisp ([Xin](https://github.com/thesephist/xin))

source: [Xin standard library snippet](https://github.com/thesephist/xin/blob/master/lib/std.xin)

![Codeline of std.xin](assets/xin.bmp)

### Haskell

source: [Rosetta Code - 99 Bottles solution](https://rosettacode.org/wiki/99_Bottles_of_Beer#Haskell)

![Codeline of Haskell code](assets/haskell.bmp)
