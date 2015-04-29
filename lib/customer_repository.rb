require_relative 'parser'
require_relative 'customer'

class CustomerRepository
  include Parser

  attr_reader :customers_data, :customers, :engine

  def initialize(customers_csv, engine)
    @customers_data = parse(customers_csv)
    @customers      = generate
    @engine         = engine
  end

  def generate
    customers_data.map do |customer_data|
      Customer.new(customer_data, self)
    end
  end

  def all
    customers
  end

  def random
    customers.sample
  end

  def find_by_id(id)
    customers.select { |customer| customer.id == id }.first
  end
end