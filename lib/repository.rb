require_relative 'parser'
require_relative 'customer'
# require_relative 'merchant'
# require_relative 'invoice'
# require_relative 'item'
# require_relative 'transaction'
# require_relative 'invoice_item'

class Repository
  include Parser

  attr_reader :collection, :engine

  def initialize(data, engine)
    @collection = generate(data)
    @engine     = engine
  end

  def generate(data)
    data.map do |object_data|
      model_class.new(object_data, self)
    end
  end

  def all
    collection
  end

  def random
    collection.sample
  end

  def find_by_id(id)
    find_all_by_id(id).first
  end

  def find_all_by_id(id)
    collection.select {|object| object.id == id}
  end

  def find_by_created_at(time_stamp)
    find_all_by_created_at(time_stamp).first
  end

  def find_all_by_created_at(time_stamp)
    collection.select {|object| object.created_at == time_stamp}
  end

  def find_by_updated_at(time_stamp)
    find_all_by_created_at(time_stamp).first
  end

  def find_all_by_updated_at(time_stamp)
    collection.select {|object| object.updated_at == time_stamp}
  end

end