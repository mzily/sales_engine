class Merchant

  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :repository

  def initialize(data, repository)
    @id          = data[:id].to_i
    @name        = data[:name]
    @created_at  = data[:created_at]
    @repository  = repository
  end
end