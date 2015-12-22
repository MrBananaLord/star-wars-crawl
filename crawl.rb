#!/usr/bin/env ruby
# require 'pry'
# binding.pry

# input = ARGV[0] || ARGF.read
# lines = File.open('lines.txt')
# lines = [input, lines.first, lines.first].map(&:to_s)
# File.open('lines.txt', 'w+').write(lines.join("\n"))

ultra_small_line, small_line, medium_line, big_line = '', '', '', ''

def command(font, string)
  %x( tput setaf 3; figlet -c -w $(tput cols) -f #{font} '#{string}' )
end

def center
  lines = `tput lines`.to_i
  center = lines <= 30 ? 0 : ((lines / 2) - 15)
  "#{center} 0"
end

puts `printf "\e[?25l"`

ARGF.read.each_line do |current_line|
  ultra_small_line, small_line, medium_line, big_line = small_line, medium_line, big_line, current_line

  puts `clear`
  puts `tput cup #{center}`
  puts command('cybersmall', ultra_small_line)
  puts "\n"
  puts "\n"
  puts command('cybermedium', small_line)
  puts "\n"
  puts "\n"
  puts command('cyberlarge', medium_line)
  puts "\n"
  puts "\n"
  puts command('doom', big_line)
  sleep(1)
end

puts `printf "\e[?25h"`
