class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    quantity = updated_count if updated_count >= 0
    # Code review: `quantity` needs an `@` prefix; otherwise, `quantity`
    # will be initialized as a local variable.
    # Note: one should limit instance variable changes to one method for better
    # code maintainability.
  end
end
