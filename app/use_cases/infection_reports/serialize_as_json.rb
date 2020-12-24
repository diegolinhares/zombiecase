# frozen_string_literal: true

module InfectionReports
  class SerializeAsJson < Micro::Case
    attribute :infection_report

    def call!
      json = {
        'survivor' => {
          'id' => infection_report.survivor_id
        },
        'infected-survivor' => {
          'id' => infection_report.reported_survivor_id
        }
      }

      Success(result: { infection_report_as_json: json })
    end
  end
end
