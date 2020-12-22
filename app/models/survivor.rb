class Survivor < ApplicationRecord
  attribute :items, Survivors::Items.to_type

  enum gender: { male: 'male', female: 'female' }

  validates :name, :gender, presence: true

  validates :items, store_model: { merge_errors: true }

  validates :age, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0
  }

  validates :latitude, numericality: {
    only_decimal: true,
    greater_than_or_equal_to: -90,
    less_than_or_equal_to: 90
  }
  
  validates :longitude, numericality: {
    only_decimal: true,
    greater_than_or_equal_to: -180,
    less_than_or_equal_to: 180
  }
end
