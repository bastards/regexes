WORKING_DIR = './hamlet-processed'
FILE_NAME = './hamlet-gutenberg.txt'
FN_FINAL_OUTPUT = File.join(WORKING_DIR, 'hamlet.csv')

Dir.mkdir WORKING_DIR unless Dir.exists? WORKING_DIR

=begin
regexes = [

	["a. Remove all flush lines", /^[^\s].+$\n?/, ''],
	["b. Remove stage directions", /^\s{5,}[^'].+?\. *$\n/, ''],
	["c. Remove all stage exits in dialogue", /^(.{10,}) {5,}.+/, '\1'],
	["d. Remove all bracketed notes", /\[.+?\]/, ''],
	["e. Delimit dialogue", /`^ {2}(\w{1,4}\.(?: \w{1,4}\.)?) +((?:.|\n)+?)(?=\n^ {2}\w)`/, '"\1","\2"'],
	["f. Remove newlines within speech", /\n(?!")/, ' '],
	["g. Collapse consecutive whitespace", /\s{2,}/, ' ']
]
=end


regexes = [

	["a. Remove all flush lines", /^[^\s].+$\n?/, ''],
  ["b. Remove exactly two spaces", /^ {2}/, '' ],
  ["c. Remove newlines", /\n(?!\w)/, '##'],
fk:  ["d. Remove ## within quotes", /## *'((?:[^#]+ ##)+?(?=' *##))/ , '''],
  ["d. Remove all stage directions", /## {4,}[^']+##/, '##'],
  ["e. Remove all bracketed notes", /\[.+?\]/, '']
]

play_text = open(FILE_NAME, 'r'){|f| f.read}

# omit play introduction
working_text = play_text.split("\n")[54..-1].join("\n")


regexes.each do |r|
  
  desc, rx, replacement = r
  
  # TK: Apply regex to original text to get line numbers
  #
  
  # Write matches to a state file
  state_fn = File.join(WORKING_DIR, (desc.gsub(/[^\w]/, '-').downcase + ".txt") )
  puts "Writing to #{state_fn}"
  open(state_fn, 'w'){ |sf|
      working_text.scan(rx).each do |mtch|
          sf.puts Array(mtch).join
      end
  }
  
  # Transform working_text
  
  working_text.gsub! rx, replacement
  
  result_txt_fn = state_fn.sub(/\/([^\/]+?)(?=\.txt)/, '/result-\1')
  open(result_txt_fn, 'w'){|f| f.write working_text}
  
end

## write to final file

open(FN_FINAL_OUTPUT, 'w') do |f|
  f.puts working_text
end
