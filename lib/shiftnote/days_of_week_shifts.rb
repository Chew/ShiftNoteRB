class ShiftNote::DaysOfWeekShifts
  def initialize(data)
    @data = data
  end

  def days
    dayz = []
    @data.each do |e|
      dayz.push ShiftNote::DaysOfWeekShift.new(e)
    end
    dayz
  end

  def working_days
    dayz = []
    @data.each do |e|
      dayz.push ShiftNote::DaysOfWeekShift.new(e) unless e['Shifts'].empty?
    end
    dayz
  end

  def raw
    @data
  end
end
