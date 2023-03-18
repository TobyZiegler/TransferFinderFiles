#
# TransferFinderFiles
#
# AppleScript to move files from one folder to another
#
# Created by Toby Ziegler, February 22 2023
# Last updated by Toby on March 18, 2023
#
# This works, even though it throws an error 0 and a -10004 still
# Now it does not work and throws error number -1708 at the createPrefs handler
#
# Designating this script as version 0.4, check for preferences, create if missing
#

# initialize variables -- no global variables yet, delete if never
## need error handling for canceling selections

########## BEGIN MAIN ##########


# select the source and target folders

readPrefs() --sourceFolder,targetFolder,numberFiles,notifyToggle
--prefDecision() --use prefs or set new prefs

set sourceFolder to setFolder("source")
set targetFolder to setFolder("target")
moveFiles(sourceFolder, targetFolder)

--savePrefs()????


########### END MAIN ###########

(* move the files, the all at once way *)

on moveFiles(theFolder, theTarget)
	
	tell application "Finder"
		
		try
			set theFiles to every file in theFolder
			try
				move (theFiles) to (theTarget as alias)
			on error errMess number errNum
				log errMess
				error "move error:  " & errMess & " (" & errNum & ")" -- pass it on
			end try
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
		#		set theFolder to choose folder with prompt "Please choose the " & theKind & " folder:" default location ((path to home folder) as alias)
		set theFolder to choose folder with prompt "Please choose the " & theKind & " folder:"
		log theFolder
		return theFolder
	end try
	
end setFolder

on readPrefs()
	--read the plist
	
	set thePListPath to "~/Library/Preferences/com.TobyZiegler.TransferFinderFiles.plist"
	
	checkExists(thePListPath)
	
	tell application "System Events"
		tell property list file thePListPath
			return value of property list item "stringKey"
		end tell
	end tell
	--> Result: "string value"
	
	
end readPrefs

on writePrefs()
	--overwrite the plist
end writePrefs

on checkExists(theFile)
	
	--verify there's a something
	tell application "System Events"
		if exists file theFile then
			return true
		end if
	end tell
	--next handler cannot be in the System Events tell
	createPrefs(theFile)
	
end checkExists

on createPrefs(theNewFile)
	
	--create a preferences file from scratch
	tell application "System Events"
		-- Create an empty property list dictionary item
		set theParentDictionary to make new property list item with properties {kind:record}
		
		set thePListFile to make new property list file with properties {contents:theParentDictionary, name:theNewFile}
		
		-- Add a Boolean key
		tell property list items of thePListFile
			make new property list item at end with properties {kind:boolean, name:"booleanKey", value:true}
			
			-- Add a date key
			make new property list item at end with properties {kind:date, name:"dateKey", value:current date}
			
			-- Add a list key
			make new property list item at end with properties {kind:list, name:"listKey"}
			
			-- Add a number key
			make new property list item at end with properties {kind:number, name:"numberKey", value:5}
			
			-- Add a record/dictionary key
			make new property list item at end with properties {kind:record, name:"recordKey"}
			
			-- Add a string key
			make new property list item at end with properties {kind:string, name:"stringKey", value:"string value"}
		end tell
	end tell
	
	
end createPrefs