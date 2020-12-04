require_relative '../input'
lines = get_lines $PROGRAM_NAME

class Passport
    attr_accessor :byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid, :cid

    def initialize(byr, iyr, eyr, hgt, hcl, ecl, pid, cid)
        @byr = byr
        @iyr = iyr
        @eyr = eyr
        @hgt = hgt
        @hcl = hcl
        @ecl = ecl
        @pid = pid
        @cid = cid
    end

    def is_valid?
        if @byr.nil? or @iyr.nil? or @eyr.nil? or @hgt.nil? or @hcl.nil? or @ecl.nil? or @pid.nil?
            return false
        end
        return true
    end
end

passports = []
running = true
counter = 0

byr, iyr, eyr, hgt, hcl, ecl, pid, cid = nil, nil, nil, nil, nil, nil, nil, nil

lines.each do |line|
    if line == "\n"
        p = Passport.new(byr, iyr, eyr, hgt, hcl, ecl, pid, cid)
        passports << p
        counter += 1 if p.is_valid?
        byr, iyr, eyr, hgt, hcl, ecl, pid, cid = nil, nil, nil, nil, nil, nil, nil, nil
    end
    line.split(" ").each do |entry|
        key, value = entry.split(":")
            case key
            when "byr"
                byr = value

            when "iyr"
                iyr = value

            when "eyr"
                eyr = value

            when "hgt"
                hgt = value

            when "hcl"
                hcl = value

            when "ecl"
                ecl = value

            when "pid"
                pid = value

            when "cid"
                cid = value

            end
    end
end

puts counter
