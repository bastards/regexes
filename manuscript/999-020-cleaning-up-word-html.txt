# Cleaning up Microsoft Word HTML (TODO)

Even though HTML is a pretty easy language to master, most people have been trained in word processors and feel more comfortable composing documents in them.

When those documents have to reside on the Web, there's usually a conversion tool from *.doc to *.html. But the conversion isn't perfect. In fact, the word processor will often add a lot of meta-junk.

With a few regular expressions though, we can get minimalist, clean HTML.

TODO


### Eliminate everything except the main post

Find
: `(?:.|\n)+?<div class=WordSection1>`
	
Replace
: *(with nothing)*

### Eliminate after the main post

Find
: `</div>\s*</body>\s*</html>`

Replace
: *(with nothing)*

### clean up line breaks within elements

Find
: `(?<=<)([^>]*)\n+`

Replace
: `\1` *and a space character*


### Delete all element attributes except for href

Find
: `<(\w+).*?(?!href="[^"]+?")[^>]*?>`

### Delete spans, op and `<!>`


