# frozen_string_literal: true

module Trades
  class ValidateTargetSurvivorExistence < Micro::Case
    attribute :params

    def call!
      survivor_id = params.dig(:for, :survivor_id)

      validation_errors = {}
      validation_errors[:for] = [{ survivor_id: 'Survivor does not exist' }] if infected_or_not_exist?(survivor_id)

      return Success(:valid_attributes) if validation_errors.empty?

      Failure(:invalid_attributes, result: { errors: validation_errors })
    end

    private

    def infected_or_not_exist?(survivor_id)
      !Survivor.exists?(survivor_id) ||
        InfectionReport.exists?(reported_survivor_id: survivor_id)
    end
  end
end
