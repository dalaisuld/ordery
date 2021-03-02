module DashboardHelper
  def self.order_count_by_product(product_id)
    return  OrderDetail.where(product_id: product_id).count
  end

  def self.order_count_by_waiting(product_id)
    return  OrderDetail.where(product_id: product_id).count
  end

  def self.order_count_by_delivery(product_id)
    return Order.where(product_id: product_id, status: 'delivery').count
  end

  def self.order_count_by_cancel(product_id)
    return Order.where(product_id: product_id, status: 'cancel').count
  end

  def self.order_count_by_finish(product_id)
    return Order.where(product_id: product_id, status: 'finish').count
  end
end
