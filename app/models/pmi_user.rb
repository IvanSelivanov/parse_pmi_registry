class PmiUser < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: %i[country city] }
  validates :country, presence: true
  validates :city, presence: true

  has_many :pmi_credentials
end
