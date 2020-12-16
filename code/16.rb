require_relative '../input'
require_relative 'handheld/Instruction'
require_relative 'handheld/Computer'
lines = get_lines $PROGRAM_NAME

restrictions_string, rest = lines.join().split("\n\nyour ticket:\n")

my_ticket_string, other_tickets_string = rest.split("\n\nnearby tickets:\n")

restrictions = restrictions_string.split("\n").map{|r| name, restrictions = r.split(": "); { name: name, restrictions: restrictions.split(" or ").map{|r| min, max = r.split("-"); {min: min.to_i, max: max.to_i}}}}
my_ticket = my_ticket_string.split(",").map(&:to_i)
other_tickets = other_tickets_string.split("\n").map{ |ticket| ticket.split(",").map(&:to_i)}

valid_values_by_name = {}

restrictions.each do |full_restriction|
  valid_values_by_name[full_restriction[:name]] = {}
  full_restriction[:restrictions].each do |restriction|
    (restriction[:min]..restriction[:max]).each do |number|
      valid_values_by_name[full_restriction[:name]][number] = true
    end
  end
end

valid_values_by_name.values
valid_values = valid_values_by_name.values.reduce({}, :merge)

scanning_error_rate = 0
valid_tickets = []

other_tickets.each do |ticket|
  ticket_is_valid = true
  ticket.each do |number|
    if valid_values[number].nil?
      scanning_error_rate += number
      ticket_is_valid = false
    end
  end
  valid_tickets << ticket if ticket_is_valid
end

p scanning_error_rate

 valid_tickets