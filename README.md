# tsc-terser
tsc-terser, script to combine typescript and terser

A quick and hacky-ish solution for this issue https://github.com/Microsoft/TypeScript/issues/8

## Basic usage

```
tsc-terser tsc [all tsc arguments] terser [all terser arguments]
```
*After "tsc" is provided as an argument, all arguments after that up until it hits "terser" argument will be added to tsc*

---

## Examples

```bash
tsc-terser tsc --lib "DOM" "ES2021" --rootDir "./src" --outFile "./main.js" terser "./main.js" -o "./main-min.js"
# The reverse doesn't make a lot of sense, but it's possible if you so wish
tsc-terser terser "./main.js" -o "./main-min.js" tsc --lib "DOM" "ES2021" --rootDir "./src" --outFile "./main.js"
# Skip terser completely
tsc-terser tsc --lib "DOM" "ES2021" --rootDir "./src" --outFile "./main.js"
```

### TODO
* Would like to support multiple programs than tsc and terser

---

*Feel free to contribute*