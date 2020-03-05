#!/usr/bin/env ink

` generate zoomed-out images of text files `

std := load('vendor/std')
gen := load('src/generate').generate

log := std.log
f := std.format
readFile := std.readFile
writeFile := std.writeFile

file := args().2 :: {
	() -> (
		log('File to convert unspecified.')
		log('Usage: codeliner input.txt output.bmp')
	)
	_ -> (
		log(f('Converting "{{ path }}"...', {path: file}))
		readFile(file, data => data :: {
			() -> log(f('Could not read contents of "{{ path }}"', {path: file}))
			_ -> (
				result := gen(data)
				log('Generated!')

				outpath := (args().3 :: {
					() -> 'out.bmp'
					_ -> string(args().3)
				})

				writeFile(outpath, result, result => result :: {
					true -> log(f('Generated! Saved to "{{ path }}"', {path: outpath}))
					_ -> log('Output write failed')
				})
			)
		})
	)
}
