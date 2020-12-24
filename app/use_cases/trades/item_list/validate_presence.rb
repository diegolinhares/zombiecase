# frozen_string_literal: true

module Trades
  module ItemList
    class ValidatePresence < Micro::Case
      attribute :params

      def call!
        offer_items = params.dig(:offer, :items)
        for_items = params.dig(:for, :items)

        validation_errors = {}
        validation_errors[:offer] = { items: 'Empty item-list is not allowed' } if offer_items.empty?
        validation_errors[:for] = { items: 'Empty item-list is not allowed' } if for_items.empty?

        return Success(:valid_attributes) if validation_errors.empty?

        Failure(:invalid_attributes, result: { errors: validation_errors })
      end
    end
  end
end
