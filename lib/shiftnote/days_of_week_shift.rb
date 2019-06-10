class ShiftNote::DaysOfWeekShift
  def initialize(data)
    @raw = data
    @date = Time.parse(data['ShiftDate'])
    @raw_shifts = data['Shifts']
  end

  attr_reader :date

  def shifts
    shifts = []
    @raw_shifts.each do |e|
      shifts.push ShiftNote::ShiftViewModel.new(e)
    end
    shifts
  end

  def amount_of_shifts
    @raw_shifts.length
  end

  def first_shift
    ShiftNote::ShiftViewModel.new(@raw_shifts.first)
  end

  attr_reader :raw
end
