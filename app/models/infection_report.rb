# frozen_string_literal: true

class InfectionReport < ApplicationRecord
  belongs_to :survivor
  belongs_to :reported_survivor, class_name: 'Survivor'
end
