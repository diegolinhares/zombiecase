class Survivors::Items
  include StoreModel::Model

  attribute :water, :integer
  attribute :food, :integer
  attribute :medication, :integer
  attribute :ammunition, :integer

  validates :water, :food, :medication, :ammunition,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0
            }
end
