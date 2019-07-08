class Organization < ApplicationRecord
  validates :name, presence: true
  validates :hourly_rate, numericality: { greater_than: 0 }

  has_many :users, dependent: :nullify
end
