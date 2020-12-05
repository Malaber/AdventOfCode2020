require_relative '../input'
lines = get_lines $PROGRAM_NAME

counter = 0

lines.each do |line|
  rule, password = line.split(":")
  password.strip!

  amount, char = rule.split(" ")

  min, max = amount.split("-").map(&:to_i)

  actual = password.count(char)

  if actual <= max and actual >= min
    counter += 1
  end
end

puts counter
