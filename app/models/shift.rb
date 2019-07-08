class Shift < ApplicationRecord
  belongs_to :user
  delegate :organization, to: :user

  def shift_length
    self.finish - self.start
  end

  def hours_worked
    seconds_worked = shift_length - (self.break_length * 60)
    (seconds_worked / 3600).round(2)
  end

  def shift_cost
    (hours_worked * self.organization.hourly_rate).round(2)
  end
end
