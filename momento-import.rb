#!/usr/bin/ruby

if ARGV.nil? || ARGV.empty?
  puts "Pass the Momento files as parameters to import into the diary.\n\n"
  exit
end

ARGV.each do |filename|
  if File.exists?(filename)
    filename =~ /\A(.+?)\.(.+?)\.(.+?) /
    
    date   = $1 + $2 + $3
    diary  = '/home/jgwong/docs/diary/' + date + '.txt'
    
    content = File.readlines(filename).join.gsub(/\r/, '').gsub(/﻿\n/, '')
    
    print diary + " "
    
    if File.exists?(diary)
      puts "[ APPENDING ]"
      
      f = File.open(diary, "a")
      f.puts "\n" + content
      f.close
    else
      puts "[ NEW FILE  ]"
      
      f = File.open(diary, "w")
      f.puts date + "\n\n" + content
      f.close
    end
  end
end

