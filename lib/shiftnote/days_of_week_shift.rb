# A specific day of a schedule.
class ShiftNote::DaysOfWeekShift
  def initialize(data)
    @raw = data
    @date = Time.parse(data['ShiftDate'])
    @raw_shifts = data['Shifts']
  end

  # @return [Time] the day
  attr_reader :date

  # @return [Array<Shift>] the shifts this employee is working on this day.
  def shifts
    shifts = []
    @raw_shifts.each do |e|
      shifts.push ShiftNote::Shift.new(e)
    end
    shifts
  end

  # @return [Integer] the amount shifts this employee is working on this day.
  def amount_of_shifts
    @raw_shifts.length
  end

  # @return [Shift] the first shift this employee is working on this day.
  def first_shift
    ShiftNote::Shift.new(@raw_shifts.first)
  end

  # @return [JSON] the raw data returned by ShiftNote.
  attr_reader :raw
end
