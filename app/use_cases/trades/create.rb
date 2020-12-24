# frozen_string_literal: true

module Trades
  class Create < Micro::Case
    attribute :survivor_id
    attribute :params

    flow([
           ValidateDoNotSelfTrade,
           ValidateTargetSurvivorExistence,
           ItemList::ValidatePresence,
           ItemList::ValidateItems,
           ItemList::ValidateSurvivorsInventory,
           ValidateOffer,
           self
         ])

    def call!
      access_survivors_inventory
      access_trade_items
      remove_items_from_survivor_inventory
      collect_target_survivor_items
      remove_items_from_target_inventory
      collect_survivor_items
      update_inventories

      Success result: { survivor: survivor.as_json.except('created_at', 'updated_at') }
    end

    private

    attr_reader :survivor, :target_survivor, :survivor_stored_items, :target_survivor_stored_items,
                :offer_items, :for_items, :access_trade_items

    def access_survivors_inventory
      @survivor = Survivor.find(survivor_id)
      @survivor_stored_items = @survivor.items.attributes
      @target_survivor = Survivor.find(params.dig(:for, :survivor_id))
      @target_survivor_stored_items = @target_survivor.items.attributes
    end

    def access_trade_items
      @offer_items = params.dig(:offer, :items)
      @for_items = params.dig(:for, :items)
    end

    def remove_items_from_survivor_inventory
      survivor_stored_items.merge!(offer_items) { |_, stored, offer| (stored - offer).abs }
    end

    def collect_target_survivor_items
      survivor_stored_items.merge!(for_items) { |_, stored, offer| (stored + offer) }
    end

    def remove_items_from_target_inventory
      target_survivor_stored_items.merge!(for_items) { |_, stored, offer| (stored - offer).abs }
    end

    def collect_survivor_items
      target_survivor_stored_items.merge!(offer_items) { |_, stored, offer| (stored + offer) }
    end

    def update_inventories
      survivor.update(items: survivor_stored_items)
      target_survivor.update(items: target_survivor_stored_items)
    end
  end
end
