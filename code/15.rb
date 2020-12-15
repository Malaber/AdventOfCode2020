require_relative '../input'
require_relative 'handheld/Instruction'
require_relative 'handheld/Computer'
lines = get_lines $PROGRAM_NAME

numbers = lines.first.split(",").map(&:to_i)

@mem = {}

def say!(number, turn)
  puts "#{turn + 1}: #{number}" if turn + 1 == 2020
  @mem[turn] = number
end

def get_next_number_to_say(mem)
  last_spoken_number_index, last_spoken_number = mem.max_by{|k,v| k}
  previous_index_of_last_spoken_number, unused_number = mem.filter{|k,v| v==last_spoken_number and k != last_spoken_number_index}.max_by{|k,v| k}
  return 0 if previous_index_of_last_spoken_number.nil?

  return last_spoken_number_index - previous_index_of_last_spoken_number
end

i = 0

numbers.each_with_index do |number, index|
  say!(number, index)
  i = index
end

while i < 2019 do
  i += 1
  number = get_next_number_to_say(@mem)
  say!(number, i)
end
