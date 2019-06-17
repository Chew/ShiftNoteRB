class ShiftNote::EmployeeOverviewViewModel
  def initialize(data)
    @raw = data
    @id = data['EmployeeId']
    @name = data['EmployeeName']
    @phones = {
      'home' => data['HomePhone'],
      'mobile' => data['MobilePhone']
    }
    @email = data['email']
    @birthday = Time.parse(data['BirthDate'])
    @schedule_this_week = ShiftNote::ScheduleThisWeekViewModel.new(data['ScheduleThisWeekViewModel'])
    @trade_shifts = data['TradeShifts']
    @trade_shifts_current_day = data['TradeShiftsCurrentDay']
    @positions = data['ThisEmployeePositions']
    @last_day = Time.parse(data['LastDay'])
    @hire_day = Time.parse(data['HireDate'])
  end

  # This is the employee's ID. Really has no use outside of Shiftnote internal data
  # @return [Integer] the employee's internal ID
  attr_reader :id

  # The employee's (legal) name.
  # @return [String] the employee's name
  attr_reader :name

  # An array containing the user's home and mobile phone numbers
  # @return [Array<String>] the user's phone numbers.
  attr_reader :phones

  # @return [String] the user's email.
  attr_reader :email

  # @return [Time] the user's birthday
  attr_reader :birthday

  # The user's "Schedule This Week," consider the return type for info
  # @return [ShiftNote::ScheduleThisWeekViewModel]
  attr_reader :schedule_this_week
  attr_reader :raw
  attr_reader :trade_shifts
  attr_reader :trade_shifts_current_day
  attr_reader :positions
  attr_reader :last_day
  attr_reader :hire_day
end
