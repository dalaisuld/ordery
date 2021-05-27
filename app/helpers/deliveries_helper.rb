module DeliveriesHelper
  def self.delviery_products(delivery_id)
    product_name = ''
    delivery_products = DeliveryProduct.where(delivery_id: delivery_id)
    delivery_products.each do |delivery_product|
      order_detail = OrderDetail.find_by(id: delivery_product.order_detail_id)
      if order_detail
        product = Product.find_by(id: order_detail.product_id)
        product_name = product_name + product.name
        product_name += '('+order_detail.quantity.to_s+'), '
      end
    end
    return product_name
  end
end
