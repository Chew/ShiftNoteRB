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

  # @return [Time] the start date of the schedule.
  attr_reader :start_date

  # @return [Time] the end date of the schedule.
  attr_reader :end_date

  # @return [Float] the total hours this employee is working this schedule
  attr_reader :hours

  # The cost is simply hours * rate.
  # @return [Float] the amount of pay the employee will receive
  attr_reader :cost

  # @return [Float] the amount of shifts this person has this week.
  attr_reader :shifts

  # @return [ShiftNote::DaysOfWeekShifts] the schedule for this week
  attr_reader :schedule

  # @return [JSON] the raw data returned by ShiftNote.
  attr_reader :raw
end
