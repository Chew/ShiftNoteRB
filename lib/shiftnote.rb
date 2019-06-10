# Gems needed to do a good job
require 'rest-client'
require 'nokogiri'
require 'json'
require 'rails'

# All ShiftNote functionality, whether extended or just here.
class ShiftNote
  # Initialize a new ShiftNote variable, via a cookie.
  # @param cookie [String] Cookie of an authenticated user.
  def initialize(cookie)
    @cookie = cookie
  end

  # Initialize the Employee
  # @return ShiftNote::EmployeeOverviewViewModel the employee
  def employee
    shiftnote = RestClient.get('https://ww1.shiftnote.com/BulletinBoard/', Cookie: @cookie)

    doc = Nokogiri::HTML.parse(shiftnote.body)

    data = doc.search('div#MyScheduleDiv').at('script').text

    data = data.gsub("<script>", '').delete(';').gsub("</script>", '').gsub("window.scheduleMinebindings = ShiftNote.Bind(window.scheduleMinemodel)", "").gsub("window.scheduleMinemodel = ", '')

    @employee = EmployeeOverviewViewModel.new(JSON.parse(data))
  end

end

# Require files.
require_relative 'shiftnote/days_of_week_shift'
require_relative 'shiftnote/days_of_week_shifts'
require_relative 'shiftnote/employee_overview_view_model'
require_relative 'shiftnote/schedule_this_week_view_model'
require_relative 'shiftnote/shift_view_model'
