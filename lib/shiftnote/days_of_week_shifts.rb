# The days of the week, their shifts.
class ShiftNote::DaysOfWeekShifts
  def initialize(data)
    @data = data
  end

  # The days in this week, whether working or not.
  # @return [Array<DaysOfWeekShift>] the days in this schedule.
  def days
    dayz = []
    @data.each do |e|
      dayz.push ShiftNote::DaysOfWeekShift.new(e)
    end
    dayz
  end

  # @return [Array<DaysOfWeekShift>] only the days this employee is working.
  def working_days
    dayz = []
    @data.each do |e|
      dayz.push ShiftNote::DaysOfWeekShift.new(e) unless e['Shifts'].empty?
    end
    dayz
  end

  # @return [JSON] the raw data returned by ShiftNote
  def raw
    @data
  end
end
