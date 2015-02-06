 ######     ###    ##           ######   #######  ########  ######## 
##    ##   ## ##   ##          ##    ## ##     ## ##     ## ##       
##        ##   ##  ##          ##       ##     ## ##     ## ##       
##       ##     ## ##          ##       ##     ## ##     ## ######   
##       ######### ##          ##       ##     ## ##     ## ##       
##    ## ##     ## ##          ##    ## ##     ## ##     ## ##       
 ######  ##     ## ########     ######   #######  ########  ######## 

########     ###    ########   ######  ######## ########  
##     ##   ## ##   ##     ## ##    ## ##       ##     ## 
##     ##  ##   ##  ##     ## ##       ##       ##     ## 
########  ##     ## ########   ######  ######   ########  
##        ######### ##   ##         ## ##       ##   ##   
##        ##     ## ##    ##  ##    ## ##       ##    ##  
##        ##     ## ##     ##  ######  ######## ##     ## 

# Generate Sublime Text 3 snippets that insert statutory text below
# the cursor based on the current text in the California Legislature's
# FTP code repository:
#
# (1) Download any code folder from ftp://www.leginfo.ca.gov/pub/code/
# to a directory that also contains calcodeparser.rb (this file).
#
# (2) Run calcodeparser.rb [target folder name]
#
# (3) In Sublime Text 3, type [target folder][section number][TAB]
# For example: "ccp273" + [tab] will insert the full text of Cal. C.
# Civ. Proc. Section 273 on the line below the cursor.
#
# The official code repository often groups multiple provisions in the
# same file. This script generates individual snippet files for each
# code provision.
#
#
# TO DOS and CAVEATS:
#
#
# 1. Some or all code directories on the FTP server contain subdirectories.
# The basic FTP module for Ruby does not appear to do recursive downloads.
# Adding that functionality would obviate the need to manually download
# each directory.
#
# 2. Instead of downloading the entire title every time, it would be nice
# to have a diff/update function that would only pull sections that have
# changed since the last time the script ran.
#
# 3. The script has not been tested on every code title. There may be other
# quirks that the regexs below do not catch and Sublime takes exception to.
#
# 4. The script adds thousands of new snippets to the Sublime Text "User"
# directory. I have not noticed a performance penalty yet, but there might
# be one. An alternative might be to use the Wget package for Sublime Text
# and call the statutory provisions from local TXT files instead.
#
# 5. The script assumes the stock Ubuntu file structure. The paths need
# to be changed to get this working in Windows and possibly other OSes.
#
# 6. The scope for the Sublime snippet file is "text.lwr" LWR is the tag
# I use for all legal writing work, with its own special syntax highlighting,
# other snippets, etc. You can change line 149 to set the scope to "text.txt"
# for example, and then the snippet would work on all TXT files instead. 
#
# CREDITS:
#
#
# Author: Greg Kochansky
# E-mail: greg@greg-k.com
# Website: www.greg-k.com
# 
# ASCII art font from http://www.network-science.de/ascii/ with
# these options:
# 
# Font: banner3
# Reflection: no
# Adjustment: left
# Stretch: no
# Width: 86
# 
# For minimap navigation in Sublime Text 3 - http://www.sublimetext.com/3

##     ##  #######  ########  ##     ## ##       ########  ######  
###   ### ##     ## ##     ## ##     ## ##       ##       ##    ## 
#### #### ##     ## ##     ## ##     ## ##       ##       ##       
## ### ## ##     ## ##     ## ##     ## ##       ######    ######  
##     ## ##     ## ##     ## ##     ## ##       ##             ## 
##     ## ##     ## ##     ## ##     ## ##       ##       ##    ## 
##     ##  #######  ########   #######  ######## ########  ######  

# encoding: utf-8
require 'fileutils'

 ######  ##             ###    ########   ######    ######  
##    ## ##            ## ##   ##     ## ##    ##  ##    ## 
##       ##           ##   ##  ##     ## ##        ##       
##       ##          ##     ## ########  ##   ####  ######  
##       ##          ######### ##   ##   ##    ##        ## 
##    ## ##          ##     ## ##    ##  ##    ##  ##    ## 
 ######  ########    ##     ## ##     ##  ######    ######  

unless ARGV.length == 2
  puts "Please include the name of the folder to be parsed\n"
  puts "and the citation format."
  puts "Usage: ruby calcodeparser.rb foldername Civ.Proc.\n"
  exit
end
 
$act = ARGV[0]
$cite = ARGV[1].dup
$cite.gsub!(/\./,'. ')

$snippetpath = ENV['HOME'] + "/.config/sublime-text-3/Packages/User/"

 ######  ##       ########    ###    ##    ##         ##     ## ########  
##    ## ##       ##         ## ##   ###   ##         ##     ## ##     ## 
##       ##       ##        ##   ##  ####  ##         ##     ## ##     ## 
##       ##       ######   ##     ## ## ## ## ####### ##     ## ########  
##       ##       ##       ######### ##  ####         ##     ## ##        
##    ## ##       ##       ##     ## ##   ###         ##     ## ##        
 ######  ######## ######## ##     ## ##    ##          #######  ##        

# Some provisions are repeated in the database (e.g. C.C.P. 273) to
# signal a new version of the provision will be coming into effect
# at some point in the future. The parser adds an "alt" string to the
# second such provision. If you are updating snippets, it will just
# append "alt" to every file name instead of updating the old files.
# Deleting all the old snippets for the given title first adressess
# that issue.

FileUtils.rm_r Dir.glob("#{$snippetpath}#{$act}*.sublime-snippet")

 ######  ########  ########    ###    ######## ########    ########  #### ########  
##    ## ##     ## ##         ## ##      ##    ##          ##     ##  ##  ##     ## 
##       ##     ## ##        ##   ##     ##    ##          ##     ##  ##  ##     ## 
##       ########  ######   ##     ##    ##    ######      ##     ##  ##  ########  
##       ##   ##   ##       #########    ##    ##          ##     ##  ##  ##   ##   
##    ## ##    ##  ##       ##     ##    ##    ##          ##     ##  ##  ##    ##  
 ######  ##     ## ######## ##     ##    ##    ########    ########  #### ##     ## 

# Temp directory for snippets
Dir.mkdir 'snippets'

######## ######## ##     ## ########  ##          ###    ######## ######## 
   ##    ##       ###   ### ##     ## ##         ## ##      ##    ##       
   ##    ##       #### #### ##     ## ##        ##   ##     ##    ##       
   ##    ######   ## ### ## ########  ##       ##     ##    ##    ######   
   ##    ##       ##     ## ##        ##       #########    ##    ##       
   ##    ##       ##     ## ##        ##       ##     ##    ##    ##       
   ##    ######## ##     ## ##        ######## ##     ##    ##    ######## 

# Template for Sublime Text 3 tab-triggered snippet
$snippetbase = "<snippet>\n<content><![CDATA[\n$1"
$snippettabtrigger = "]]></content>\n<tabTrigger>"
$snippetclose = "</tabTrigger>\n<scope>text.lwr</scope>\n</snippet>"
# Alternative line 149 with TXT files as the scope instead of LWR files:
# $snippetclose = "</tabTrigger>\n<scope>text.txt</scope>\n</snippet>"

########     ###    ########   ######  ######## ########  
##     ##   ## ##   ##     ## ##    ## ##       ##     ## 
##     ##  ##   ##  ##     ## ##       ##       ##     ## 
########  ##     ## ########   ######  ######   ########  
##        ######### ##   ##         ## ##       ##   ##   
##        ##     ## ##    ##  ##    ## ##       ##    ##  
##        ##     ## ##     ##  ######  ######## ##     ## 

Dir.glob("#{$act}/**/*").each do |filename|
	filetextarray = []
	# Recursively crawl the subdirectory structure.
	next if File.directory? filename
	filetext = File.read(filename)
	# UTF double-encoding resolves any exceptions due to non-UTF characters.
	filetext.encode!('UTF-16', 'UTF-8', :invalid => :replace, :replace => '')
  filetext.encode!('UTF-8', 'UTF-16')
  # There are fewer newlines after the last section than there are between
  # sections.
	filetext << "\n\n\n"
	# Each numbered provision and any subsections are joined on one line.
	filetext.gsub!(/\n{3,5}/, "ZZZZZZ")
	filetext.gsub!(/\n/, " ")
	filetext.gsub!(/ZZZZZZ/, "\n")
	# Remove introductory material.
	filetext.gsub!(/^CALIFORNIA\sCODES.*?ZZZZZZ\s/, "")
	# Remove any spaces at beginning of lines.
	filetext.gsub!(/^\s{1,2}/, "")
	# Each line becomes element in array
	filetextarray << filetext.scan(/\s?\d.*\n/)
	filetextarray.each do |sections|
		sections.each do |section|
			sectiontext = section.to_s
			# Cleans up white space before subsections. Optional.
			sectiontext.gsub!(/\s{4}/, " ")
			# Scan for code number. Most complex strings (1111.111a) are matched first.
			codenumber = sectiontext.scan(/^\d{1,5}\.\d{1,5}[a-z]{0,1}|^\d{1,5}[a-z]|^\d{1,5}/)
			snippetfilename = "snippets/#{$act}" + codenumber.join + '.sublime-snippet'
			# Where includes current and future sections with the same number, append "alt"
			# to the latter.
			if File.file?(snippetfilename)
				snippetfilename = "snippets/#{$act}" + codenumber.join + 'alt.sublime-snippet'
			end 
			# Insert statutory text into the snippet template.
			snippetfile = File.open("#{snippetfilename}", "w")
			snippetfile.truncate(0)
			snippetfile.print $snippetbase
			snippetfile.print "Cal. Code #{$cite}\u{00A7} #{codenumber.join}. \n\n" + sectiontext
			snippetfile.print $snippettabtrigger + "#{$act}#{codenumber.join}" + $snippetclose
		end
	end
end

 ######  ##       ########    ###    ##    ##         ##     ## ########  
##    ## ##       ##         ## ##   ###   ##         ##     ## ##     ## 
##       ##       ##        ##   ##  ####  ##         ##     ## ##     ## 
##       ##       ######   ##     ## ## ## ## ####### ##     ## ########  
##       ##       ##       ######### ##  ####         ##     ## ##        
##    ## ##       ##       ##     ## ##   ###         ##     ## ##        
 ######  ######## ######## ##     ## ##    ##          #######  ##        

# Move snippets from temp folder to Sublime "User" folder.
# Change or remove if just generating text files.
FileUtils.cp_r 'snippets/.', "#{$snippetpath}"
# Delete temporary folder.
FileUtils.rm_rf('snippets')