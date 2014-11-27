# Cleaning up OCR Text (TODO)

Image scanners and [optical-character-recognition software](http://en.wikipedia.org/wiki/Optical_character_recognition) ease the process of turning paper into digital text. And as we learned in previous chapters, data is just text with a certain structure.

But the challenge of scanned text is that the conversion is messy.

Todo: Example image

## Scenario

When using Tesseract (or an OCR program of your choice) on a scanned image, you'll almost always have imperfect translations. A common problem might involve numbers and letters that look-alike, such as the lower-case-"L" and the number `1`.

We'll use regexes to quickly identify problematic character-groupings, such as numbers in the middle of words (e.g. `he1l0`).

**Note:** This is only a proof of concept. If you're digitizing large batches of documents, you'll be writing automated scripts with a variety of regex and parsing techniques. This chapter is not meant to imply that you can deal with this problem with your trusty text-editor alone.

#### Prerequisites 

Todo:

Finding misplaced symbols inside letters.

- Scan a text
- Tesseract it
- highlight all words that fit:

`(\b[A-Za-z]+[^ A-Za-z'\-]+[A-Za-z]+)`

- find all numbers that have a letter in the middle of them


