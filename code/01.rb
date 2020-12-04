require_relative '../input'
lines = get_lines $PROGRAM_NAME

def is_valid_birthday?(i)
    return true if i.to_i >= 1920 and i.to_i <= 2002
    return false
end

def is_valid_issue_year?(i)
    return true if i.to_i >= 2010 and i.to_i <= 2020
    return false
end

def is_expiration_year?(i)
    return true if i.to_i >= 2020 and i.to_i <= 2030
    return false
end

puts is_expiration_year?("1967")

def is_valid_height?(i)
    return false if not /in|cm/.match(i)
    cm = false
    cm = true if /cm/.match(i)
    i = i.gsub /in|cm/, ''
    if cm
        return true if i.to_i >= 150 and i.to_i <= 193
    else
        return true if i.to_i >= 59 and i.to_i <= 76
    end
    return false
end

def is_valid_hair_color?(i)
    return true if /^#[a-f,0-9]{6}$/.match(i)
    return false
end

def is_valid_eye_color?(i)
    return true if /^amb|blu|brn|gry|grn|hzl|oth$/.match(i)
    return false
end

def is_valid_passport_id?(i)
    return true if /^\d{9}$/.match(i)
    return false
end

puts is_valid_eye_color?("brn")
puts is_valid_eye_color?("wat")

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

    def is_strictly_valid?
        if @byr.nil? or
            @iyr.nil? or
            @eyr.nil? or
            @hgt.nil? or
            @hcl.nil? or
            @ecl.nil? or
            @pid.nil?
            return false
        end
        if is_valid_birthday?(@byr) and
            is_valid_issue_year?(@iyr) and
            is_expiration_year?(@eyr) and
            is_valid_height?(@hgt) and
            is_valid_hair_color?(@hcl) and
            is_valid_eye_color?(@ecl) and
            is_valid_passport_id?(@pid)
            return true
        end
        return false
    end
end

passports = []
running = true
counter = 0
strict_counter = 0

byr, iyr, eyr, hgt, hcl, ecl, pid, cid = nil, nil, nil, nil, nil, nil, nil, nil

lines.each do |line|
    if line == "\n"
        p = Passport.new(byr, iyr, eyr, hgt, hcl, ecl, pid, cid)
        passports << p
        counter += 1 if p.is_valid?
        strict_counter += 1 if p.is_strictly_valid?
        p p if p.is_strictly_valid?

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
puts strict_counter
