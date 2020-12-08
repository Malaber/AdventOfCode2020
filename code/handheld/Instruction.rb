require_relative 'Exceptions'

class Instruction
  attr_accessor :cmd, :value, :run_times

  def initialize(cmd, value)
    @cmd = cmd
    @value = value
    @run_times = 0
  end

  def run!(pointer, acc)

    raise(ComputerError.new("Instruction ran twice, pointer: #{pointer}, acc: #{acc}")) unless @run_times.zero?

    case @cmd
    when "nop"

    when "acc"
      acc += @value
    when "jmp"
      pointer += @value
      return pointer, acc
    else
      raise(ComputerError.new("Unknown Command"))
    end

    pointer += 1
    @run_times +=1

    return pointer, acc
  end
end
