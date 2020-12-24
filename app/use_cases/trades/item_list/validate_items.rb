# frozen_string_literal: true

module Trades
  module ItemList
    class ValidateItems < Micro::Case
      attribute :params

      def call!
        offer_items = params.dig(:offer, :items)
        for_items = params.dig(:for, :items)

        validation_errors = {}

        if does_not_have_valid_items_for?(offer_items)
          validation_errors[:offer] = { items: 'There is an invalid item in the list' }
        end

        if does_not_have_valid_items_for?(for_items)
          validation_errors[:for] = { items: 'There is an invalid item in the list' }
        end

        return Success(:valid_attributes) if validation_errors.empty?

        Failure(:invalid_attributes, result: { errors: validation_errors })
      end

      private

      def does_not_have_valid_items_for?(items)
        items.slice(:water, :food, :ammunition, :medication).empty?
      end
    end
  end
end
