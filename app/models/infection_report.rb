class InfectionReport < ApplicationRecord
  belongs_to :survivor
  belongs_to :reported_survivor, class_name: 'Survivor'

  validates :reported_survivor, 'infection_reports/self_report': true,
                                'infection_reports/already_reported': true
end
