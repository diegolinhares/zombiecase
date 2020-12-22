class Survivors::SerializeAsJson < Micro::Case
  attribute :survivor

  def call!
    json = survivor.as_json.except('created_at', 'updated_at')

    Success(result: { survivor_as_json: json })
  end
end
