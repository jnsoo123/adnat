class ShiftForm
  include ActiveModel::Model

  attr_accessor(
    :shift,
    :shift_date,
    :start,
    :finish,
    :break_length,
    :user_id
  )

  validates :shift_date,   presence: true
  validates :start,        presence: true
  validates :finish,       presence: true
  validates :break_length, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def initialize(attr={})
    super
    set_attributes if self.shift.present?
  end

  def save
    return false if invalid?
    create_shift
  end

  def update
    return false if invalid?
    update_shift
  end

  def self.model_name
    ActiveModel::Name.new(self, nil, 'Shift')
  end

  private

  def set_attributes
    @shift_date   ||= self.shift.start.to_date.to_s
    @start        ||= self.shift.start.strftime('%I:%M %p')
    @finish       ||= self.shift.finish.strftime('%I:%M %p')
    @break_length ||= self.shift.break_length
    @user_id      ||= self.shift.user_id
  end

  def start_time_greater_than_finish_time?
    Time.parse(@start) > Time.parse(@finish)
  end

  def create_shift
    Shift.create(shift_params)
  end

  def update_shift
    @shift.update(shift_params)
  end

  def start_shift
    datetime_parser(@shift_date, @start)
  end

  def end_shift
    date = Date.parse(@shift_date)
    date = date + 1.day if start_time_greater_than_finish_time?
    datetime_parser(date, @finish)
  end

  def datetime_parser(date, time)
    date = Date.parse(date) unless date.class == Date
    date.to_datetime +
      Time.parse(time).seconds_since_midnight.seconds
  end

  def shift_params
    {
      start:        start_shift,
      finish:       end_shift,
      break_length: @break_length,
      user_id:      @user_id
    }
  end
end
