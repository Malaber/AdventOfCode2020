require_relative '../input'
lines = get_lines $PROGRAM_NAME

counter = 0
second_counter = 0

lines.each do |line|
  rule, password = line.split(":")
  password.strip!

  amount, char = rule.split(" ")

  min, max = amount.split("-").map(&:to_i)

  actual = password.count(char)

  if actual <= max and actual >= min
    counter += 1
  end

  first_letter = password[min-1]
  second_letter = password[max-1]

  second_counter += 1 if (first_letter+second_letter).count(char) == 1
end

puts counter
puts second_counter
