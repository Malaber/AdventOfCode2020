require_relative '../input'
require_relative 'handheld/Instruction'
require_relative 'handheld/Computer'
lines = get_lines $PROGRAM_NAME

numbers = lines.first.split(",").map(&:to_i)

@mem = {}
@mem_last = {}

def say!(number, turn)
  puts "#{turn + 1}: #{number}" if turn + 1 == 2020 or turn + 1 == 30000000 or turn % 10000 == 0
  if @mem[number].nil?
    @mem[number] = turn
  else
    @mem_last[number] = @mem[number]
    @mem[number] = turn
  end
end

def get_next_number_to_say(mem, mem_last)
  last_spoken_number, last_spoken_number_index = mem.max_by{|k,v| v}
  unused_number, previous_index_of_last_spoken_number = mem_last.filter{|k,v| k==last_spoken_number and v != last_spoken_number_index}.max_by{|k,v| v}
  return 0 if previous_index_of_last_spoken_number.nil?

  return last_spoken_number_index - previous_index_of_last_spoken_number
end

i = 0

numbers.each_with_index do |number, index|
  say!(number, index)
  i = index
end

while i < 50000 do
  i += 1
  number = get_next_number_to_say(@mem, @mem_last)
  say!(number, i)
end
