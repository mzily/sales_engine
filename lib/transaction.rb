require_relative 'model_object'

class Transaction < ModelObject

  attr_reader :invoice_id,
              :credit_card_number,
              :cc_expiration_date,
              :result

  def initialize(data, transaction_repo)
    super
    @invoice_id         = data[:invoice_id].to_i
    @credit_card_number = data[:credit_card_number]
    @cc_expiration_date = data[:cc_expiration_date]
    @result             = data[:result]
  end

  def invoice
    repository.engine.invoice_repository.find_by_id(invoice_id)
  end

  def merchant
    invoice.merchant
  end

  def success?
    result == 'success'
  end

end
