class ComputerError < StandardError
  def initialize(msg="Standart Computer Error")
    super
  end
end

class ShipMoveInitializationError < StandardError
  def initialize(msg = "Unprocessable Move")
    super
  end
end
