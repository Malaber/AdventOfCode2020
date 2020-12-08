class Instruction
  attr_accessor :cmd, :value, :already_ran

  def initialize(cmd, value, already_ran)
    @cmd = cmd
    @value = value
    @already_ran = already_ran
  end

  def run!(pointer, acc)

    raise("I ran, pointer: #{pointer}, acc: #{acc}") if @already_ran

    case @cmd
    when "nop"

    when "acc"
      acc += @value
    when "jmp"
      pointer += @value
      return pointer, acc
    else
      raise(Exception.new("Unknown Command"))
    end

    pointer += 1
    @already_ran = true

    return pointer, acc
  end
end
