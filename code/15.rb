require_relative '../input'
require_relative 'handheld/Instruction'
require_relative 'handheld/Computer'
lines = get_lines $PROGRAM_NAME

numbers = lines.first.split(",").map(&:to_i)

@mem = {}
@mem_last = {}

def say!(number, turn)
  puts "#{turn + 1}: #{number}" if turn + 1 == 2020 or turn + 1 == 30000000
  if @mem[number].nil?
    @mem[number] = turn
  else
    @mem_last[number] = @mem[number]
    @mem[number] = turn
  end
end

def get_next_number_to_say(mem, mem_last, last_number, last_index)
  last_spoken_number = last_number
  last_spoken_number_index = last_index
  previous_index_of_last_spoken_number = mem_last[last_spoken_number]
  return 0 if previous_index_of_last_spoken_number.nil?

  return last_spoken_number_index - previous_index_of_last_spoken_number
end

i = 0
last_number = nil

numbers.each_with_index do |number, index|
  say!(number, index)
  last_number = number
  i = index
end

while i < 30000000 do
  i += 1
  number = get_next_number_to_say(@mem, @mem_last, last_number, i - 1)
  say!(number, i)
  last_number = number
end
