require_relative 'repository'
require_relative 'invoice'
require_relative 'invoice_item_repository'

class InvoiceRepository < Repository
  attr_reader :model_class

  def initialize(data, engine)
    @model_class = Invoice
    super
  end

  def find_all_by_customer_id(customer_id)
    @all_by_customer_id ||= hash_repo("customer_id")
    @all_by_customer_id[customer_id]
  end

  def find_by_customer_id(customer_id)
    find_all_by_customer_id(customer_id).first
  end

  def find_all_by_merchant_id(merchant_id)
    @all_by_merchant_id ||= hash_repo("merchant_id")
    @all_by_merchant_id[merchant_id]
  end

  def find_by_merchant_id(merchant_id)
    find_all_by_merchant_id(merchant_id).first
  end

  def find_all_by_status(status)
    @all_by_status ||= hash_repo("status")
    @all_by_status[status]
  end

  def find_by_status(status)
    find_all_by_status(status).first
  end

  def create(invoice_info = {})
    invoice_info[:created_at]  = Time.now.to_s
    invoice_info[:updated_at]  = Time.now.to_s
    invoice_info[:id]          = all.last.id + 1
    invoice_info[:customer_id] = invoice_info[:customer].id
    invoice_info[:merchant_id] = invoice_info[:merchant].id

    engine.invoice_item_repository
          .create_invoice_item(invoice_info[:items], invoice_info[:id] )

    new_invoice = Invoice.new(invoice_info, self)

    collection << new_invoice
    new_invoice
  end

end
