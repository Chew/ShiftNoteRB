# frozen_string_literal: true

# Gems needed to do a good job
require 'rest-client'
require 'nokogiri'
require 'json'
require 'rails'

# All ShiftNote functionality, whether extended or just here.
class ShiftNote
  # Initialize a new ShiftNote variable, via a cookie.
  # @param cookie [String] Cookie of an authenticated user.
  def initialize(credentials = {})
    generate_cookie(credentials[:username], credentials[:password])
  end

  def generate_cookie(username, password)
    uri = URI.parse('https://ww1.shiftnote.com/login')
    request = Net::HTTP::Post.new(uri)
    request.content_type = 'application/x-www-form-urlencoded'
    request.set_form_data(
      'FullSite' => 'False',
      'ReturnUrl' => '',
      'username' => username,
      'Password' => password,
      'Submit' => 'Submit',
      'remember' => 'true'
    )

    req_options = {
      use_ssl: uri.scheme == 'https'
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
    # response.code

    @cookie = response.header['Set-Cookie']
  end

  # Initialize the Employee
  # @return [ShiftNote::EmployeeOverviewViewModel] the employee
  def employee
    shiftnote = RestClient.get('https://ww1.shiftnote.com/BulletinBoard/', Cookie: @cookie)

    doc = Nokogiri::HTML.parse(shiftnote.body)

    data = doc.search('div#MyScheduleDiv').at('script').text

    data = data.gsub('<script>', '').delete(';').gsub('</script>', '').gsub('window.scheduleMinebindings = ShiftNote.Bind(window.scheduleMinemodel)', '').gsub('window.scheduleMinemodel = ', '')

    @employee = EmployeeOverviewViewModel.new(JSON.parse(data))
  end

end

# Require files.
require_relative 'shiftnote/days_of_week_shift'
require_relative 'shiftnote/days_of_week_shifts'
require_relative 'shiftnote/employee_overview_view_model'
require_relative 'shiftnote/schedule_this_week_view_model'
require_relative 'shiftnote/shift_view_model'
