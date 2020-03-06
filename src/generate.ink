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
reverse := std.reverse

replace := str.replace
split := str.split

Scale := 3

Tab := char(9)
Newline := char(10)

Black := [0, 0, 0]
White := [255, 255, 255]
Blue := [255, 20, 20]
Red := [20, 20, 255]
Yellow := [20, 225, 255]

` repeat strings and lists N times `
repeat := (s, count) => (sub := (acc, n) => n :: {
	0 -> acc
	_ -> sub(acc.len(acc) := s, n - 1)
})(type(s) :: {
	'string' -> ''
	'composite' -> []
}, count)

` given a character byte, determine which color to use to display it `
byteToRGB := b => b :: {
	' ' -> White

	'(' -> Blue
	')' -> Blue

	'[' -> Red
	']' -> Red
	'{' -> Yellow
	'}' -> Yellow

	_ -> Black
}

generate := txt => (
	linesWithTabs := split(txt, Newline)
	lines := map(linesWithTabs, s => replace(s, Tab, repeat(' ', 8)))
	maxLineLength := max(map(lines, s => len(s)))
	equalizedLines := map(lines, s => len(s) < maxLineLength :: {
		false -> s
		true -> s + repeat(' ', maxLineLength - len(s))
	})

	width := maxLineLength * Scale
	height := len(equalizedLines) * Scale * 2

	linesOfPixels := map(equalizedLines, line => (
		bytes := split(line, '')
		singleRow := flatten(map(bytes, b => repeat(byteToRGB(b), Scale)))
		flatten(repeat(singleRow, Scale * 2))
	))

	` our bmp library starts writing from bottom left corner,
		so we need to reverse the list to show in correct line order `
	pixels := flatten(reverse(linesOfPixels))

	width * height :: {
		len(pixels) -> bmp(width, height, pixels)
		_ -> 'error: generated invalid image dimensions'
	}
)
