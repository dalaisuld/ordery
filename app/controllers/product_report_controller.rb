class ProductReportController < ApplicationController
  def index
    @page_product_report_active = true

    @ordered_products = OrderDetail.joins('as od inner join products as p on p.id = od.product_id')
                            .select('p.id, p.name, p.price, p.quantity, p.ordered_count, p.received_count, p.sold_count,  SUM(od.quantity) as all_product,
                          SUM(case when od.status = 0 then od.quantity else 0 end) as is_waiting,
                          SUM(case when od.status = 1 then od.quantity else 0 end) as is_willing,
                          SUM(case when od.status = 2 then od.quantity else 0 end) as is_delivery,
                          SUM(case when od.status = 3 then od.quantity else 0 end) as is_finish,
                          SUM(case when od.status = 4 then od.quantity else 0 end) as is_cancelled')
                            .group('p.id, p.name')
  end

  def sell_product
    sell_quantity = params[:sell_quantity]
    sell_price = params[:sell_price]
    product_id = params[:product_id]
    product = Product.find(product_id)
    product.quantity = product.quantity.to_i - sell_quantity.to_i
    product.save
    sold = Sold.new
    sold.product_id = product_id
    sold.product_name = product.name.to_s
    sold.quantity = sell_quantity
    sold.price = sell_price
    sold.action_user_id = current_user.id
    sold.sold_date = Time.now.strftime('%Y-%m-%d')
    sold.save!
    render json:{ message: product_id }, status: 200
  end

end
