#!/usr/bin/ruby
# MIT license

# localize_xibs_incremental.rb
# This script takes a set of localized strings, a set of old and new English XIBs, and a set of current 
# localized XIBs and incrementally localizes the localized XIBs with the localized strings and the diff between 
# the old English XIBs and the new English XIBs.

# ibtool
#   --previous-file path_to_project/English.lproj/MainWindow.old.xib
#   --incremental-file path_to_project/fr.lproj/MainWindow.old.xib
#   --strings-file path_to_strings/fr/MainWindow.strings
#   --localize-incremental
#   --write path_to_project/fr.lproj/MainWindow.xib
#   path_to_project/English.lproj/MainWindow.new.xib

# More info: http://developer.apple.com/documentation/developertools/conceptual/IB_UserGuide/LocalizingNibFiles/LocalizingNibFiles.html#//apple_ref/doc/uid/TP40005344-CH13-SW8

require 'FileUtils'

# Check for arguments.
if ARGV.length != 2
  puts "Usage: ruby localize_xibs_incremental.rb path_to_project path_to_strings"
  exit
end

# Get path arguments and 'cd' to that project path.
SOURCE_XIB_FOLDER = "English.lproj"
PROJECT_PATH = ARGV[0]
STRINGS_PATH = ARGV[1]
FileUtils.cd(PROJECT_PATH)
FILES_TO_IGNORE = [".svn", "." ,"..", ".DS_Store"]
NON_XIB_LOCALIZED_FILES = ["InfoPlist.strings","Localizable.strings"]

# Iterate through the current directory.
Dir.entries(STRINGS_PATH).each do |localized_folder|
  if (!FILES_TO_IGNORE.include?(localized_folder))
    puts "Generating localizations for #{localized_folder}"
    # Iterate over the .strings language folders.
    Dir.entries(STRINGS_PATH + "/" + localized_folder).each do |strings_file|
      strings_path = STRINGS_PATH + "/" + localized_folder + "/" + strings_file
      if (NON_XIB_LOCALIZED_FILES.include?(strings_file))
        %x[cp \"#{strings_path}\" \"#{localized_folder}.lproj/#{strings_file}\"]
        puts "COPIED #{strings_file} to #{localized_folder}"
      elsif (!FILES_TO_IGNORE.include?(strings_file))
        filename = strings_file.slice(0,strings_file.length-8)
        source_xib = SOURCE_XIB_FOLDER + "/" + filename

        # Create a new localized XIB based on older localized version and two English versions.
        command = "ibtool --previous-file \"#{source_xib}.old.xib\" " + 
                         "--incremental-file \"#{localized_folder}.lproj/#{filename}.old.xib\" " + 
                         "--strings-file \"#{strings_path}\" " + 
                         "--localize-incremental " + 
                         "--write \"#{localized_folder}.lproj/#{filename}.xib\" " + 
                         "\"#{source_xib}.new.xib\""
        results = %x[#{command}]
        if results.length > 0
          puts "FAILURE: #{command}:\n#{results}"
        else
          puts "SUCCESS: #{localized_folder}.lproj/#{filename}.xib"
        end

        # Generate .strings files for both localized versions to easily compare. Erase after.
        command = "ibtool --generate-strings-file \"#{localized_folder}.lproj/#{filename}.old.strings\" \"#{localized_folder}.lproj/#{filename}.old.xib\""
        results = %x[#{command}]
        command = "ibtool --generate-strings-file \"#{localized_folder}.lproj/#{filename}.new.strings\" \"#{localized_folder}.lproj/#{filename}.xib\""
        results = %x[#{command}]
      end
    end
  end
end
