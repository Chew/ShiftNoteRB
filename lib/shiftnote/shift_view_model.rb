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

  attr_reader :schedule_id
  attr_reader :schedule_name
  attr_reader :schedule_status_id
  attr_reader :shift_id
  attr_reader :employee_id
  attr_reader :employee
  attr_reader :shift_date
  attr_reader :time_in
  attr_reader :time_out
  attr_reader :position
  attr_reader :position_color
  attr_reader :internal_location
  attr_reader :open
  attr_reader :close
  attr_reader :on_call
  attr_reader :volume
  attr_reader :note
  attr_reader :hours
  attr_reader :cost
  attr_reader :is_pending_pickup
  attr_reader :is_pending_manager_approval
  attr_reader :is_pending_swap
  attr_reader :is_pending_swap_manager_approval
  attr_reader :hide_end_times
  attr_reader :raw
end
