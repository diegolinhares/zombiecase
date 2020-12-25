# frozen_string_literal: true

module InfectionReports
  class Create < Micro::Case
    attribute :survivor_id
    attribute :params

    flow([
           CheckReportedSurvivor,
           CheckSelfReporting,
           self
         ])

    def call!
      infection_report = InfectionReport.new(
        survivor_id: survivor_id,
        reported_survivor_id: params[:infected_id]
      )

      if infection_report.save
        Success result: { infection_report: infection_report }
      else
        Failure :invalid_infection_report,
                result: {
                  infection_report: infection_report.errors.as_json
                }
      end
    end
  end
end
