` generate image from text content `

std := load('../vendor/std')
str := load('../vendor/str')
bmp := load('../vendor/bmp').bmp

log := std.log
map := std.map
reduce := std.reduce
max := std.max
join := std.join
flatten := std.flatten

replace := str.replace
split := str.split

Scale := 2

Tab := char(9)
Newline := char(10)

Black := [0, 0, 0]
White := [255, 255, 255]

repeat := (s, count) => (sub := (acc, n) => n :: {
	0 -> acc
	_ -> sub(acc.len(acc) := s, n - 1)
})('', count)
repeatList := (list, count) => (sub := (acc, n) => n :: {
	0 -> acc
	_ -> sub(acc.len(acc) := list, n - 1)
})([], count)

byteToRGB := b => b :: {
	' ' -> repeatList(White, Scale)
	_ -> repeatList(Black, Scale)
}

generate := txt => (
	linesWithTabs := split(txt, Newline)
	lines := map(linesWithTabs, s => replace(s, Tab, repeat(' ', 8)))
	maxLineLength := max(map(lines, s => len(s)))
	equalizedLines := map(lines, s => len(s) < maxLineLength :: {
		false -> s
		true -> s + repeat(' ', maxLineLength - len(s))
	})

	(std.cat)(equalizedLines, Newline)

	width := maxLineLength * Scale
	height := len(equalizedLines) * Scale * 2

	linesOfPixels := map(equalizedLines, line => (
		bytes := split(line, '')
		singleRow := flatten(map(bytes, byteToRGB))
		flatten(repeatList(singleRow, Scale * 2))
	))
	pixels := flatten(linesOfPixels)

	log(width * height)
	log(len(pixels))

	bmp(width, height, pixels)
)
