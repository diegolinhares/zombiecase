# frozen_string_literal: true

module Trades
  module ItemList
    class ValidateSurvivorsInventory < Micro::Case
      attribute :params
      attribute :survivor_id

      def call!
        search_unavailable_items_to_trade

        return Success(:valid_attributes) if validation_errors.empty?

        Failure(:invalid_attributes, result: { errors: validation_errors })
      end

      private

      attr_reader :validation_errors

      def search_unavailable_items_to_trade
        @validation_errors =
          survivors.each_with_object({}) do |(key, survivor_trade_data), error_messages|
            survivor_stored_items = Survivor.find(survivor_trade_data[:id]).items.attributes.symbolize_keys

            unavailable_items = unavailable_items_to_trade(survivor_stored_items,
                                                           survivor_trade_data[:items])

            next if unavailable_items.empty?

            error_messages[key] = { items: unavailable_items }
          end
      end

      def survivors
        {
          offer: {
            id: survivor_id,
            items: params.dig(:offer, :items)
          },
          for: {
            id: params.dig(:for, :survivor_id),
            items: params.dig(:for, :items)
          }
        }
      end

      def unavailable_items_to_trade(stored_items, items)
        items.to_h.select { |item, quantity| quantity.to_i > stored_items[item.to_sym] || quantity.to_i.zero? }
             .map { |item, _| { item => "Not enough items, only #{stored_items[item.to_sym]} available" } }
      end
    end
  end
end
