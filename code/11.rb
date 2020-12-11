require_relative '../input'
require_relative 'handheld/Instruction'
require_relative 'handheld/Computer'
lines = get_lines $PROGRAM_NAME

rows = []
lines.each do |line|
  rows << line.strip.split("")
end

def get_adjacent_occupied_seats_amount(rows, row_index, seat_index)
  adjacent_seats = 0
  (row_index - 1..row_index + 1).each do |row_i|
    (seat_index - 1..seat_index + 1).each do |seat_i|
      next if row_i == row_index and seat_i == seat_index
      row = rows[row_i]
      next if row_i.negative? or row.nil?
      seat = row[seat_i]
      next if seat_i.negative? or seat.nil?
      adjacent_seats += 1 if seat == "#"
    end
  end
  adjacent_seats
end

def get_new_seat_occupancy(rows, row_index, seat_index)
  seat = rows[row_index][seat_index]
  adjacent_occupied_seats_amount = get_adjacent_occupied_seats_amount(rows, row_index, seat_index)
  case seat
  when "."
    #Floor (.) never changes; seats don't move, and nobody sits on the floor.
  when "#"
    return "L" if adjacent_occupied_seats_amount >= @tolerance_level #If a seat is occupied (#) and four or more seats adjacent to it are also occupied, the seat becomes empty.
  when "L"
    return "#" if adjacent_occupied_seats_amount.zero? #If a seat is empty (L) and there are no occupied seats adjacent to it, the seat becomes occupied.
  else
    raise "Unknown Seat type (#{seat})"
  end
  seat
end

def apply_floor_rules(rows)
  something_changed = false
  new_rows = rows.dup.map(&:dup)
  rows.each_with_index do |row, row_index|
    row.each_with_index do |seat, seat_index|
      new_seat = get_new_seat_occupancy(rows, row_index, seat_index)
      new_rows[row_index][seat_index] = new_seat
      something_changed = true unless new_seat == seat
    end
  end
  return new_rows, something_changed
end

def get_occupied_seats_after_nothing_changes(rows)
  running = true
  while running
    rows, something_changed = apply_floor_rules(rows)
    # rows.each do |row|
    #   row.each do |seat|
    #     print seat
    #   end
    #   puts
    # end
    # p "-----------------------------"
    running = false unless something_changed
  end
  rows.flatten.count("#")
end

@tolerance_level = 4
puts get_occupied_seats_after_nothing_changes(rows)
