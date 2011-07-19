#!/usr/bin/ruby
 
# dedupe.files.rb
 
require 'rubygems'
require 'sqlite3' # Look at 'http://github.com/luislavena/sqlite3-ruby' then do 'sudo gem install sqlite3-ruby'
require 'digest/sha1'
require 'pathname'
 
# Pass in the directory or assume the current one.
arg = ARGV[0] || "."
root_path = Pathname.new(arg).realpath.to_s
puts "Examining #{root_path}"
 
# Create a SQLite3 database in the current directory.
db = SQLite3::Database.new("dedupe.files.db")
db.execute("create table files(digest varchar(40),path varchar(1024))")
 
# Recursively generate hash digests of all files.
Dir.chdir("#{root_path}")
current_file = 0
Dir['**/*.*'].each do |file|
  path = "#{root_path}/#{file}"
  # Ignore non-existent files (symbolic links) and directories.
  next if !File.exists?("#{path}") || File.directory?("#{path}")
  # Create a hash digest for the current file.
  digest = Digest::SHA1.new
  File.open(file, 'r') do |handle|
    while buffer = handle.read(1024)
      digest << buffer
    end
  end
  # Store the hash digest and full path in the database.
  db.execute("insert into files values(\"#{digest}\",\"#{path}\")")
  # Print out every Nth file.
  puts "[#{digest}] #{path} (#{current_file})" if current_file % 100 == 0
  current_file = current_file + 1
end
 
# Loop through digests.
db.execute("select digest,path,count(1) as count from files group by digest order by count desc").each do |row|
  # puts "row: #{row}"
  if row[2].to_i > 1 # Skip unique files.
    puts "Duplicates found:"
    digest = row[0]
    # List the duplicate files.
    db.execute("select digest,path from files where digest='#{digest}'").each do |dup_row|
      puts "[#{digest}] #{dup_row[1]}"
    end
  end
end