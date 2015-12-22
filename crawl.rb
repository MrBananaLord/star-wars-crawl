#!/usr/bin/env ruby
# require 'pry'
# binding.pry

# input = ARGV[0] || ARGF.read
# lines = File.open('lines.txt')
# lines = [input, lines.first, lines.first].map(&:to_s)
# File.open('lines.txt', 'w+').write(lines.join("\n"))

ultra_small_line, small_line, medium_line, big_line = '', '', '', ''

def command(font, string)
  %x( tput setaf 3; figlet -c -w $(tput cols) -f fonts/#{font}.flf '#{string}' )
end

def centered_position(string)
  lines = `tput lines`.to_i
  center_y = lines <= 20 ? 0 : ((lines / 2) - 10)
  center_x = (`tput cols`.to_i / 2) - (string.length / 2)
  center_x = center_x > 0 ? center_x : 0
  "#{center_y} #{center_x}"
end

puts `printf "\e[?25l"`

ARGF.read.each_line do |current_line|
  ultra_small_line, small_line, medium_line, big_line = small_line, medium_line, big_line, current_line

  puts `clear`
  puts %x( tput setaf 3; tput cup #{centered_position(ultra_small_line)}; echo '#{ultra_small_line}' )
  puts command('cybersmall', small_line)
  puts command('small', medium_line)
  puts command('big', big_line)
  sleep(0.5)
end

puts `printf "\e[?25h"`
