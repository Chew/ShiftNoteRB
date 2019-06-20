# An employee.
class ShiftNote::Employee 
  def initialize(id: nil)
    @id = id
  end

  # @return [Integer] the ID of the employee
  attr_reader :id

  end
end
