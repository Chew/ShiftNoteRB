# frozen_string_literal: true

# Gems needed to do a good job
require 'rest-client'
require 'nokogiri'
require 'json'
require 'rails'

# All ShiftNote functionality, whether extended or just here.
class ShiftNote
  # Initialize a new ShiftNote variable, via login credentials.
  # @param username [String] the username of the user.
  # @param password [String] the password of the user.
  def initialize(username: nil, password: nil)
    @credentials = { username: username, password: password }
    generate_cookie(username, password)
  end

  # Generate a cookie, based on login credentials.
  # @param username [String] the username of the user.
  # @param password [String] the password of the user.
  # @return [String] the cookie!
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
    raise Errors::InvalidCredentials, 'The provided credentials are invalid, please try again.' if response.body.include?("There was no match for the username and password provided, please try again!")

    @cookie = response.header['Set-Cookie']
  end

  # Useful method (for the gem that is) that gets rid of stuff we don't need.
  # @!visibility private
  # @param string [String] a string to scrape the junk off
  def scrapejunk(string)
    string.gsub('<script>', '').delete(';').gsub('</script>', '').gsub('window.scheduleMinebindings = ShiftNote.Bind(window.scheduleMinemodel)', '').gsub('window.scheduleMinemodel = ', '')
  end

  # Method to find the next instance of the given date.
  # @!visibility private
  # @param day [String] what day to find
  def date_of_next(day)
    date  = Date.parse(day)
    delta = date > Date.today ? 0 : 7
    date + delta
  end

  # This is basically an API token.
  # @return [String] the cookie of the authenticated user
  def cookie
    shiftnote = RestClient.get('https://ww1.shiftnote.com/BulletinBoard/', Cookie: @cookie)

    doc = Nokogiri::HTML.parse(shiftnote.body)

    begin
      doc.search('div#MyScheduleDiv').at('script').text
    rescue NoMethodError
      generate_cookie(@credentials[:username], @credentials[:password])
    end
    @cookie
  end

  # Get the information of the currently logged in user.
  # @return [User] the user
  def user
    shiftnote = RestClient.get('https://ww1.shiftnote.com/BulletinBoard/', Cookie: @cookie)

    doc = Nokogiri::HTML.parse(shiftnote.body)

    begin
      data = doc.search('div#MyScheduleDiv').at('script').text
    rescue NoMethodError
      generate_cookie(@credentials[:username], @credentials[:password])
      retry
    end

    data = data.gsub('<script>', '').delete(';').gsub('</script>', '').gsub('window.scheduleMinebindings = ShiftNote.Bind(window.scheduleMinemodel)', '').gsub('window.scheduleMinemodel = ', '')

    User.new(JSON.parse(data))
  end

  # Get an employee (by id)
  # @param id [Integer] the id of the employee
  def employee(id)
    Employee.new(id: id)
  end

  # @param day [String] what day the week starts on.
  # @return [ScheduleThisWeek] the schedule for next week.
  def get_next_week_shifts(day = "Monday")
    nextmonday = date_of_next(day)

    week2 = RestClient.get("https://ww1.shiftnote.com/Schedules/ScheduleMine/?startDate=#{nextmonday.month}%2F#{nextmonday.day}%2F#{nextmonday.year}&noContainer=true&_=#{Time.now.to_i * 1000}", Cookie: cookie)

    week2doc = Nokogiri::HTML.parse(week2.body)
    dataweek2 = JSON.parse(scrapejunk(week2doc.at('script').text))
    User.new(dataweek2).schedule_this_week
  end
end

# Require files.
require_relative 'shiftnote/days_of_week_shift'
require_relative 'shiftnote/days_of_week_shifts'
require_relative 'shiftnote/employee'
require_relative 'shiftnote/errors'
require_relative 'shiftnote/schedule_this_week'
require_relative 'shiftnote/shift'
require_relative 'shiftnote/user'
