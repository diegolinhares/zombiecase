# frozen_string_literal: true

module InfectionReports
  class CheckSelfReporting < Micro::Case
    attribute :survivor_id
    attribute :params

    def call!
      reported_survivor_id = params[:infected_id]

      validation_errors = {}
      validation_errors[:infected_id] = ["can't flag yourself as an infected"] if survivor_id == reported_survivor_id

      return Success(:valid_attributes) if validation_errors.empty?

      Failure(:invalid_infection_report, result: { infection_report: validation_errors })
    end
  end
end
