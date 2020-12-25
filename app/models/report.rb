# frozen_string_literal: true

class Report
  def self.infected
    {
      details: 'This number represents the percentage of infected survivors ' \
               'in relation to the total of registered survivors.',
      value: infected_percent
    }
  end

  def self.non_infected
    {
      details: 'This number represents the percentage of non infected survivors ' \
               'in relation to the total of registered survivors.',
      value: 1 - infected_percent
    }
  end

  def self.inventories_overview
    not_infected_count = Survivor.count - InfectionReport.count

    average_amount_of_each_item_type =
      sum_non_infected_survivors_items_by_type.transform_values do |quantity|
        (not_infected_count / quantity.to_f).round(2)
      end

    {
      details: 'This report contains the average amount of each type of ' \
               'item that are in the non-infected survivors\' inventories',
      value: average_amount_of_each_item_type
    }
  end

  def self.resources_lost
    infected_survivors_items_quantity = Survivor.where(id: infected_survivors_ids)
                                                .map(&:items).map(&:attributes)
                                                .map { |hash| hash.values.sum }.sum
    {
      details: 'This report represents the values in points of all resources ' \
               'that were lost because their owner are infected',
      value: infected_survivors_items_quantity
    }
  end

  def self.infected_percent
    (InfectionReport.count / Survivor.count.to_f).round(2)
  end

  def self.sum_non_infected_survivors_items_by_type
    survivors_items_quantity = Survivor.where.not(id: infected_survivors_ids)
                                       .map(&:items).map(&:attributes)

    survivors_items_quantity.reduce({}) do |hash, survivor_item|
      hash.merge(survivor_item) { |_, a, b| a + b }
    end
  end

  def self.infected_survivors_ids
    InfectionReport.pluck(:reported_survivor_id)
  end
end
