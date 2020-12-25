# frozen_string_literal: true

module InfectionReports
  class SerializeAsJson < Micro::Case
    attribute :infection_report
    attribute :serializer

    def call!
      json = serializer.new(infection_report)

      Success(result: { infection_report_as_json: json })
    end
  end
end
