module ProductsHelper
  def removeImage(product)
    product.remove_image!
    product.save
  end

  def add_to_cart
    #product = params[:]
    puts "add_to_cart called"
    #cookies.permanent[:ecomm_app_cart] = cookies.permanent[:ecomm_app_cart]+","+product.id
  end
end
