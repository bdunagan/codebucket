#!/usr/bin/ruby
# MIT license

# localize_xibs.rb
# This script takes a set of localized strings and creates/clobbers existing localized XIBs
# using the current English.lproj XIBs.
require 'FileUtils'

# Check for arguments.
if ARGV.length != 2
  puts "Usage: ruby localize_xibs.rb path_to_project path_to_strings"
  exit
end

# Get path arguments and 'cd' to that project path.
SOURCE_XIB_FOLDER = "English.lproj"
PROJECT_PATH = ARGV[0]
STRINGS_PATH = ARGV[1]
FileUtils.cd(PROJECT_PATH)
FILES_TO_IGNORE = [".svn", "." ,"..", ".DS_Store"]

# Iterate through the current directory.
Dir.entries(STRINGS_PATH).each do |localized_folder|
  if (!FILES_TO_IGNORE.include?(localized_folder))
    puts "Generating localizations for #{localized_folder}"
    # Iterate over the .strings language folders.
    Dir.entries(STRINGS_PATH + "/" + localized_folder).each do |strings_file|
      if (!FILES_TO_IGNORE.include?(strings_file))
        filename = strings_file.slice(0,strings_file.length-8)
        source_xib = SOURCE_XIB_FOLDER + "/" + filename
        strings_path = STRINGS_PATH + "/" + localized_folder + "/" + strings_file

        # Each .strings file needs to create/clobber a localized XIB in that .lproj folder.
        command = "ibtool --strings-file \"#{strings_path}\" --write \"#{localized_folder}.lproj/#{filename}.xib\" \"#{source_xib}.xib\""
        results = %x[#{command}]
        if results.length > 0
          puts "FAILURE: #{command}:\n#{results}"
        else
          puts "SUCCESS: #{localized_folder}.lproj/#{filename}.xib"
        end
      end
    end
  end
end
