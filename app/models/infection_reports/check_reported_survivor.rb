# frozen_string_literal: true

module InfectionReports
  class CheckReportedSurvivor < Micro::Case
    attribute :params

    def call!
      reported_survivor_id = params[:infected_id]

      validation_errors = {}
      if InfectionReport.exists?(reported_survivor_id: reported_survivor_id)
        validation_errors[:infected_id] = ['has already been reported']
      end

      return Success(:valid_attributes) if validation_errors.empty?

      Failure(:invalid_infection_report, result: { infection_report: validation_errors })
    end
  end
end
