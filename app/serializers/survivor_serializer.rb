# frozen_string_literal: true

class SurvivorSerializer
  include JSONAPI::Serializer
  attributes :name, :age, :gender, :latitude, :longitude, :items
end
