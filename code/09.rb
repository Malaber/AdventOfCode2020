require_relative '../input'
require_relative 'handheld/Instruction'
require_relative 'handheld/Computer'
all_numbers = get_lines $PROGRAM_NAME

preamble_size = 25
all_numbers.map!(&:to_i)
invalid_number = 0

all_numbers.each_with_index do |number, index|
  next unless index >= preamble_size

  previous_numbers = all_numbers[index-preamble_size, index]

  any_match = false
  previous_numbers.each_with_index do |number_a, index_a|
    previous_numbers.each_with_index do |number_b, index_b|
      next if index_a == index_b
      any_match = true if number_a + number_b == number
    end
  end
  unless any_match
    puts "No valid match for #{number} at #{index}"
  end
end
