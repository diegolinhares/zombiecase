module InfectionReports
  class SelfReportValidator < ActiveModel::Validator
    def validate(record)
      if record.survivor_id == record.reported_survivor_id
        record.errors.add(:infected_id, "can't flag yourself as an infected")
      end
    end
  end
end
