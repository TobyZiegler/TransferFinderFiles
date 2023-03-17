#
# TransferFinderFiles
#
# AppleScript to move files from one folder to another
#
# Created by Toby Ziegler, February 22 2023
# Last updated by Toby on March 17, 2023
#
# Starting with just the basic moving of folder contents
#
# This works, even though it throws an error 0 and a -10004
#
# Designating this script as version 0.1, the most basic of functional
#

# select the source and target folders
tell application "Finder"
	activate
	
	set sourceFolder to choose folder with prompt "Please choose the source folder:" default location ((path to home folder) as alias)
	log sourceFolder
	
	set sourceFiles to every file in sourceFolder
	log sourceFiles
	
	set targetFolder to choose folder with prompt "Please choose the source folder:" default location ((path to home folder) as alias)
	log targetFolder
	
	(* move the files, the one at a time way -- this works well, but slowly
	repeat with theFile in sourceFiles
		move theFile to (targetFolder)
	end repeat
	*)
	
	(* move the files, the all at once way *)
	try
		move (sourceFiles) to (targetFolder as alias)
		set endNotify to (((count of sourceFiles) as text) & " files moved.")
		onerror
		set endNotify to "Error moving files."
	end try
	
	#notify completion	
	say endNotify
	-- display dialog the name of sourceFiles
	
end tell
