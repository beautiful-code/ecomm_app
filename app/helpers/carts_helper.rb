module CartsHelper

  def getCartItemsCount
    #get cart items
    cart = JSON.parse( cookies[:shopping_cart] || '{}')
    #iterate over the hash and add the values up
    sum = 0
    cart.each do |product_id,quantity|
      sum += quantity
    end
    return sum
  end
end
