class ShiftNote::ShiftViewModel
  def initialize(data)
    @raw = data
    @schedule_id = data['ScheduleId']
    @schedule_name = data['ScheduleName']
    @schedule_status_id = data['ScheduleStatusId']
    @shift_id = data['ShiftId']
    @employee_id = data['EmployeeId']
    @employee = data['Employee']
    @shift_date = Time.parse(data['ShiftDate'])
    @time_in = Time.parse(data['TimeIn'])
    @time_out = Time.parse(data['TimeOut'])
    @position = data['Position']
    @position_color = data['PositionColor']
    @internal_location = data['InternalLocation']
    @open = data['Open']
    @close = data['Close']
    @on_call = data['OnCall']
    @volume = data['Volume']
    @note = data['Note']
    @hours = data['Hours']
    @cost = data['Cost']
    @is_pending_pickup = data['IsPendingPickUp']
    @is_pending_manager_approval = data['IsPendingManagerApproval']
    @is_pending_swap = data['IsPendingSwap']
    @is_pending_swap_manager_approval = data['IsPendingSwapManagerApproval']
    @hide_end_times = data['HideEndTimes']
  end

  # @return [Integer] the shift's schedule's ID.
  attr_reader :schedule_id

  # @return [String] the shift's schedule's name
  attr_reader :schedule_name

  # I have absolutely no idea what the IDs mean.
  # @return [Integer] the shift's schedule's status ID.
  attr_reader :schedule_status_id

  # @return [Integer] the shift's ID.
  attr_reader :shift_id

  # @return [Integer] the employee working this shift's ID.
  attr_reader :employee_id

  # @return [String] the name of the employee working this Shift.
  attr_reader :employee

  # @return [Time] the date of this shift.
  attr_reader :shift_date

  # @return [Time] the time this employee should clock in.
  attr_reader :time_in

  # @return [Time] the time this employee should clock out.
  attr_reader :time_out

  # @return [String] the position this employee is working.
  attr_reader :position

  # Probably used on the website.
  # @return [String] the color of this position this employee is working.
  attr_reader :position_color

  # @return [String] the internal location of this shift.
  attr_reader :internal_location

  # I don't know what this means. Do they open? Is the shift open? What!
  # It's true or false though.
  # @return [true, false]
  attr_reader :open

  # I don't know what this means.
  # @return [true, false]
  attr_reader :close

  # I don't know what this means.
  # @return [true, false]
  attr_reader :on_call

  # I don't know what this means.
  # @return [true, false]
  attr_reader :volume

  # I don't know what this means.
  # @return [String]
  attr_reader :note

  # @return [Float] the duration of this shift in hours.
  attr_reader :hours

  # @return [Float] the cost of this shift for the company
  attr_reader :cost

  # This is true if this shift is dropped.
  # This is false if it's been picked up or never was dropped.
  # @return [true, false] whether this shift is pending pickup
  def pending_pickup?
    @is_pending_pickup
  end

  # If the shift is waiting for the manager to approve it.
  # @return [true, false] whether this shift is pending manager approval
  def pending_manager_approval?
    @is_pending_manager_approval
  end

  # When a shift is swapped with someone, it waits for them to accept or deny.
  # Until that happens, this is true.
  # @return [true, false] is the shift is pending swap.
  def pending_swap?
    @is_pending_swap
  end

  # When the shift swap is approved, the manager needs to approve it.
  # Until this happens, this is true.
  # @return [true, false] is the shift is pending swap manager approval.
  def pending_swap_manager_approval
    @is_pending_swap_manager_approval
  end

  # I wonder what happens when this is true. Hopefully it doesn't break.
  # @return [true, false] to hide the end time of the shift.
  def hide_end_times?
    @hide_end_times
  end

  # @return [JSON] the raw data returned by ShiftNote
  attr_reader :raw
end
