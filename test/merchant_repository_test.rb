require_relative 'test_helper'

class MerchantRepositoryTest < Minitest::Test
  attr_reader :repo, :repo_from_engine

  def setup
    data  = Parser.new("./test/fixtures/merchants.csv").values
    @repo = MerchantRepository.new(data, nil)

    engine = SalesEngine.new('./test/fixtures/')
    engine.startup
    @repo_from_engine = engine.merchant_repository
  end

  def test_it_can_find_merchants_by_name
    invoice_object = repo.find_by_name("Hand-Spencer")

    assert_equal 9, invoice_object.id
  end

  def test_it_can_find_all_merchants_by_name
    assert_equal 1, repo.find_all_by_name("Schroeder-Jerde").count
  end

  def test_it_can_find_top_merchants_by_revenue
    assert_equal [4, 1], repo_from_engine.most_revenue(2).map(&:id)
  end

  def test_it_can_find_top_selling_items
    assert_equal [4, 1], repo_from_engine.most_items(2).map(&:id)
  end

  def test_it_returns_total_revenue_for_a_date
    assert_equal 0, repo_from_engine.revenue(Date.parse('2012-03-27 14:53:59 UTC'))
  end
  
end
