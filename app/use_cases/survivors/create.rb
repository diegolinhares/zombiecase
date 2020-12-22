module Survivors
  class Create < Micro::Case
    attribute :name
    attribute :age
    attribute :gender
    attribute :latitude
    attribute :longitude
    attribute :inventory

    def call!
      create_survivor
    end

    private

    def create_survivor
      survivor = Survivor.new(
        name: name,
        age: age,
        gender: gender,
        latitude: latitude,
        longitude: longitude,
        items: inventory
      )

      if survivor.save
        Success result: { survivor: survivor }
      else
        Failure :invalid_survivor, result: { survivor: survivor.errors.as_json }
      end
    end
  end
end