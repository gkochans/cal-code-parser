# Access California statutes from your text editor.
Use Sublime Text 3 snippets to insert the full text of current statutes via California's official FTP repository.

![Screen capture of snippets in action.](http://www.gregkochansky.com/images/screen.gif "Screen capture of snippets in action.")

The script generates `*.sublime-snippet` files, each of which inserts the full text of a given California Code provision (<ftp://www.leginfo.ca.gov/pub/code/>).
To use:
1. Download a repository (Civil Code, Corporate Code) via FTP. (The files are tiny, but there can be thousands of them.)
2. Put `cal-code-parser.rb` in the same directory as the Code directory: `/dir/cal-code-parser.rb` and `/dir/code/`.
3. Run something like `ruby cal-code-parser.rb cacp Civ.Proc.` where `cacp` is the directory that contains the Code and `Cal.Proc.` is the abbreviation for the full citation, _sans_ spaces. Rename the `cacp` directory to whatever makes sense. The official directory name for the Code of Civil Procedure is `ccp`, but using `cacp` denotes the jurisdiction if you want to adapt the script for other bodies of law (`nycp`, `macp`, `frcp`).
4. In Sublime Text 3 (and maybe in version 2 . . .), the scope for all snippets is set to `text.lwd`, but it can be changed to anything (`text.txt`).
5. To trigger the snippet for Code of Civil Procedure section 2023.020, as in the example above, type `cacp2023.020` + <kbd>tab</kbd> to expand to a full citation, skip a line below the cursor, and insert the text of the statute.

The benefit is instant access to the text of statutes, while writing, without switching focus back and forth between applications. I use this as part of an "integrated legal writing environment" that includes syntax highlighting, other snippets for case law, and a Ruby script that handles citations and other formatting and then injects XML into a `*.docx` template.
