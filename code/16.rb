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

ticket_fields = Array.new(my_ticket.size)
possible_ticket_fields = valid_values_by_name.keys

def get_possible_ticket_field_for_values(values, valid_values_by_name)
  possible_ticket_fields = []
  valid_values_by_name.keys.each do |key|
    key_is_possible = true
    valid_values = valid_values_by_name[key]
    values.each do |value|
      if valid_values[value].nil?
        key_is_possible = false
      end
    end
    possible_ticket_fields << key if key_is_possible
  end
  possible_ticket_fields
end

def get_all_ticket_values_for(id, valid_tickets)
  valid_tickets.map{|t|t[id]}
end

def get_ticket_field(id, valid_tickets, valid_values_by_name)
  values = get_all_ticket_values_for(id, valid_tickets)
  field = get_possible_ticket_field_for_values(values, valid_values_by_name)
  field
end

ticket_fields.each_with_index do |field, id|
  ticket_fields[id] = get_ticket_field(id, valid_tickets, valid_values_by_name)
end

p ticket_fields

while ticket_fields.flatten != ticket_fields.flatten.uniq
  ticket_fields.each_with_index do |field, id|
    if field.size == 1
      only_possible_field = field.first
      ticket_fields.each_with_index do |field2, id2|
        field2.delete(only_possible_field) unless id == id2
      end
    end
  end
end

p ticket_fields
