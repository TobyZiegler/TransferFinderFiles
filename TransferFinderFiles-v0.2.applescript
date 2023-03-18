#
# MoveContents
#
# AppleScript to move files from one folder to another
#
# Created by Toby Ziegler, February 22 2023
# Last updated by Toby on February 24, 2023
#
# This works, even though it throws an error 0 and a -10004 still
#
# Designating this script as version 0.2, adding functions
#

# initialize variables


########## BEGIN MAIN ##########


# select the source and target folders

set sourceFolder to setFolder("source")
set targetFolder to setFolder("target")
moveFiles(sourceFolder, targetFolder)


########### END MAIN ###########

(* move the files, the all at once way *)

on moveFiles(theFolder, theTarget)
	
	tell application "Finder"
		
		try
			set theFiles to every file in theFolder
			move (theFiles) to (theTarget as alias)
			set endNotify to (((count of theFiles) as text) & " files moved.")
		on error
			set endNotify to "Error moving files."
		end try
		
		#notify completion	
		say endNotify
		-- display dialog the name of sourceFiles
		
	end tell
	
end moveFiles


on setFolder(theKind)
	
	try
		set theFolder to choose folder with prompt "Please choose the " & theKind & " folder:" default location ((path to home folder) as alias)
		log theFolder
		return theFolder
	end try
	
end setFolder