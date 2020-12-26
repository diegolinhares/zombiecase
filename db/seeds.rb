# frozen_string_literal: true

# The Walking Dead characters
names = ['Rick Grimes', 'Daryl Dixon']

names.each do |name|
  Survivor.create(
    name: name,
    age: 40,
    gender: 'male',
    latitude: -90.0,
    longitude: -180.0,
    items: {
      'water': 1,
      'food': 2,
      'ammunition': 1,
      'medication': 1
    }
  )
end
