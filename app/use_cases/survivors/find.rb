module Survivors
  class Find < Micro::Case
    attribute :survivor_id

    def call!
      survivor = Survivor.find(survivor_id)

      if survivor
        Success(result: { survivor: survivor })
      else
        Failure(:not_found_survivor)
      end
    end
  end
end