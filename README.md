# Access California statutes from your text editor.
Use Sublime Text 3 snippets to insert the full text of current statutes via California's official FTP repository.

![Screen capture of snippets in action.](http://www.gregkochansky.com/images/screen.gif "Screen capture of snippets in action.")

The script generates `*.sublime-snippet` files, each of which inserts the full text of a given California Code provision (<ftp://www.leginfo.ca.gov/pub/code/>).
To use:
- Download a repository (Civil Code, Corporate Code) via FTP. (The files are tiny, but there can be thousands of them.)
- Put `cal-code-parser.rb` in the same directory as the Code directory: `/dir/cal-code-parser.rb` and `/dir/code/`.
- Run something like `ruby cal-code-parser.rb cacp Cal.Civ.` where `cacp` is the directory that contains the Code and `Cal.Civ.` is whatever citation style you want to use. For instance, omit `Cal.` for California Style. Rename the `cacp` directory to whatever makes sense. The official directory name for the Code of Civil Procedure is `ccp`, but using `cacp` denotes the jurisdiction if you want to use the script with multiple bodies of law (`nycp`, `macp`, `frcp`).
- In Sublime Text 3 (and maybe in version 2 . . . .), the scope for all snippets is set to `text.lwd`, but it could be anything (`text.txt`).
- To trigger the snippet for Code of Civil Procedure section 2023.020, as in the example above, type `cacp2023.020` + <kbd>tab</kbd> to expand to a full citation, skip a line below the cursor, and insert the citation and full text.

The benefit is instant access to the text of statutes, while writing, without switching focus back and forth between applications. I use this as part of an "integrated legal writing environment" that includes syntax highlighting, other snippets for case law, and a Ruby script that handles citations and other formatting and then injects XML into a `*.docx` template.
