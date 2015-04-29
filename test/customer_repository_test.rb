require './test/test_helper'
require 'csv'

class CustomerRepositoryTest < Minitest::Test

  def setup
    engine = SalesEngine.new('./test/fixtures/')
    engine.startup
    @repo = engine.customer_repository
  end

  def test_it_returns_all_customers
    assert_equal 10, @repo.all.count
    assert_equal "Joey", @repo.all.first.first_name
    assert_equal "Ramona", @repo.all.last.first_name
  end

  def test_it_returns_a_random_customer
    sample = 10.times.map { |i| @repo.random.first_name }
    refute sample.all? { |name| name == sample.first }
  end

  def test_it_finds_a_customer_by_id
    assert_equal "Sylvester", @repo.find_by_id(5).first_name
  end

end