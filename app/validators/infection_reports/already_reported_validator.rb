# frozen_string_literal: true

module InfectionReports
  class AlreadyReportedValidator < ActiveModel::Validator
    def validate(record)
      if InfectionReport.exists?(reported_survivor_id: record.reported_survivor_id)
        record.errors.add(:infected_id, 'has already been reported')
      end
    end
  end
end
