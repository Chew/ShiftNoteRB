# An employee.
class ShiftNote::Employee
  def initialize(data)
    @raw = data
    @id = data['EmployeeId']
    @name = data['EmployeeName']
    @phones = {
      'home' => data['HomePhone'],
      'mobile' => data['MobilePhone']
    }
    @email = data['Email']
    @birthday = Time.parse(data['BirthDate'])
    @schedule_this_week = ShiftNote::ScheduleThisWeek.new(data['ScheduleThisWeekViewModel'])
    @trade_shifts = data['TradeShifts']
    @trade_shifts_current_day = data['TradeShiftsCurrentDay']
    @positions = data['ThisEmployeePositions']
    @last_day = data['LastDay'] ? Time.parse(data['LastDay']) : nil
    @hire_day = data['HireDate'] ? Time.parse(data['HireDate']) : nil
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
  # @return [ScheduleThisWeek]
  attr_reader :schedule_this_week

  # Trading (or swapping) means the employee can trade shifts with other employees.
  # @return [true, false] if this employee can trade (or swap) shifts at all.
  def trade_shifts?
    @trade_shifts
  end

  alias_method :can_swap?, :trade_shifts?

  # Assuming trade_shifts? is true, this method returns if the user can trade shifts
  # for the given day. Where I work, this is false. Should've thought of that first, Billy.
  # @return [true, false] if this employee can trade shifts for today's shifts.
  def trade_shifts_current_day?
    @trade_shifts_current_day
  end

  # @return [Array<String>] the positions this employee is working.
  attr_reader :positions

  # @return [Time, nil] the employee's last day, nil if they don't have one (good)
  attr_reader :last_day

  # @return [Time, nil] the employee's hire date, nil if they don't have one set
  attr_reader :hire_day

  # @return [JSON] the raw data returned by ShiftNote
  attr_reader :raw
end
