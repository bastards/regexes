require 'csv'
require 'cgi'
DIR = File.expand_path(File.dirname __FILE__)
INPUT_FILE_NAME = File.join(DIR, 'cheats.csv')
OUTPUT_FILE_NAME = File.join(DIR, 'cheats.html')

ofile = open(OUTPUT_FILE_NAME, 'w')

ofile.puts "<html><body>"


ofile.puts %q{
<style>
	table{
		width: 100%
	}

	tr:nth-child(2n) td{
		background: #e7eae7;
	}

	th{
		font-size: 90%;
		font-family: "Helvetica Neue";
	}

	td{
		border-top: thin solid #aaa;
		vertical-align: top;
		padding: 1px 3px;
		border-left: thin solid #bbb;
	}

	.desc{
		font-size: 75%;
		font-family: "Helvetica Neue";
		padding-left: 6px;
	}

	td.exp{
		width: 250px;
		padding-right: 5px;
	}
	span.exp{
		font-size: 115%;
		font-family: Courier;
	}
</style>

}


ofile.puts %Q{
	<table>
		<thead>
     <tr>
			<th>Syntax</th>
			<th>Find</th>
			<th>Replace</th>
			<th>Original text</th>
			<th>Replace first</th>
			<th>Replace all</th>
     </tr>

		</thead>

}


dat = open(INPUT_FILE_NAME,'r'){|f| f.read}

CSV.parse(dat,  {:headers=>true}) do |row|
	ofile.puts "<tr>"

	ofile.puts %Q{
		<td class="exp">
			<span class="exp">#{CGI.escapeHTML row['Expression']}</span>
			<span class="desc">#{CGI.escapeHTML row['Description']}</span>
		</td>
	}
	ofile.puts "<td><code>#{CGI.escapeHTML row['Find']}</code></td>"
	ofile.puts "<td><code>#{CGI.escapeHTML row['Replace']}</code></td>"
	ofile.puts "<td><pre>#{CGI.escapeHTML row['Text'].to_s}</pre></td>"
	ofile.puts "<td><pre>#{CGI.escapeHTML row['Replace first']}</pre></td>"
	ofile.puts "<td><pre>#{CGI.escapeHTML row['Replace all']}</pre></td>"


	ofile.puts "</tr>"

end

ofile.close
