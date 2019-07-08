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
  validate  :finish_time_greater_than_start_time

  def save
    return false if invalid?
    create_shift
  end

  def self.model_name
    ActiveModel::Name.new(self, nil, 'Shift')
  end

  private

  def finish_time_greater_than_start_time
    if @start.present? && @finish.present? && @shift_date.present?
      if (start_shift.to_i >= end_shift.to_i)
        errors.add(:shift, 'is invalid')
      end
    end
  end

  def create_shift
    Shift.create(
      start:        start_shift,
      finish:       end_shift,
      break_length: @break_length,
      user_id:      @user_id
    )
  end

  def start_shift
    datetime_parser(@shift_date, @start)
  end

  def end_shift
    datetime_parser(@shift_date, @finish)
  end

  def datetime_parser(date, time)
    Date.parse(date).to_datetime +
      Time.parse(time).seconds_since_midnight.seconds
  end
end
