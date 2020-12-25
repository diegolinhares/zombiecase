# frozen_string_literal: true

module Trades
  class ValidateOffer < Micro::Case
    attribute :params

    def call!
      offer_items = params.dig(:offer, :items).to_h.keys
      for_items = params.dig(:for, :items).to_h.keys

      validation_errors = {}

      if offer_items == for_items
        validation_errors[:for] = [{ items: 'Invalid Offer, the items offered and received do not worth the same' }]
      end

      return Success(:valid_attributes) if validation_errors.empty?

      Failure(:invalid_attributes, result: { errors: validation_errors })
    end
  end
end
