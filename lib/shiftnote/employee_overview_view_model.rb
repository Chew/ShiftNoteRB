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
  end

  attr_reader :id
  attr_reader :name
  attr_reader :phones
  attr_reader :email
  attr_reader :birthday
  attr_reader :schedule_this_week
  attr_reader :raw
end
