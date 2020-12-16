require_relative '../input'
require_relative 'handheld/Instruction'
require_relative 'handheld/Computer'
lines = get_lines $PROGRAM_NAME

restrictions_string, rest = lines.join().split("\n\nyour ticket:\n")

my_ticket_string, other_tickets_string = rest.split("\n\nnearby tickets:\n")

p restrictions = restrictions_string.split("\n").map{|r| r.split(": ").last.split(" or ").map{|r| min, max = r.split("-"); {min: min.to_i, max: max.to_i}}}
p my_ticket = my_ticket_string.split(",").map(&:to_i)
p other_tickets = other_tickets_string.split("\n").map{ |ticket| ticket.split(",").map(&:to_i)}

valid_values = {}

restrictions.each do |two_restrictions|
  two_restrictions.each do |restriction|
    (restriction[:min]..restriction[:max]).each do |number|
      valid_values[number] = true
    end
  end
end

p valid_values

scanning_error_rate = 0

other_tickets.each do |ticket|
  ticket.each do |number|
    if valid_values[number].nil?
      scanning_error_rate += number
    end
  end
end

p scanning_error_rate