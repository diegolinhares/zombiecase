# frozen_string_literal: true

class InfectionReportsSerializer
  include JSONAPI::Serializer

  set_key_transform :dash

  belongs_to :survivor
  belongs_to :reported_survivor, key: :'infected-survivor',
                                 serializer: SurvivorSerializer
end
