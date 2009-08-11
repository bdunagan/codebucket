#!/usr/bin/ruby
# MIT license

# generate_xib_strings.rb
# This script creates/clobbers a *.strings file for every XIB file in path argument.
require 'FileUtils'

# Check for arguments.
if ARGV.length != 1
  puts "Usage: ruby generate_xib_strings.rb path_to_lproj"
  exit
end

# Get path argument and 'cd' to that path.
PATH = ARGV[0]
FileUtils.cd(PATH)

# Iterate through the current directory.
Dir.entries(".").each do |file|
  filename = file.slice(0,file.length-4)
  extension = file.slice(file.length-4,file.length)
  # Only deal with XIBs.
  if (extension == ".xib")
    command = "ibtool --generate-strings-file \"#{filename}.strings\" \"#{filename}.xib\""
    results = %x[#{command}]
    if results.length > 0
      puts "FAILURE: #{command}:\n#{results}"
    else
      puts "SUCCESS: #{filename}.strings"
    end
  end
end
