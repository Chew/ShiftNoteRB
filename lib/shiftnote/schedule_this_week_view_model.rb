class ShiftNote::ScheduleThisWeekViewModel
  def initialize(data)
    @raw = data
    @start_date = Time.parse(data['StartDate'])
    @end_date = Time.parse(data['EndDate'])
    @hours = data['Hours']
    @cost = data['Cost']
    @shifts = data['Shifts']
    @schedule = ShiftNote::DaysOfWeekShifts.new(data['DaysOfWeekShifts'])
  end

  attr_reader :start_date
  attr_reader :end_date
  attr_reader :hours
  attr_reader :cost
  attr_reader :shifts
  attr_reader :schedule
  attr_reader :raw
end
