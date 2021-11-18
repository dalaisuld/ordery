class ProductReportController < ApplicationController
  def index
    @page_product_report_active = true

    @ordered_products = OrderDetail.joins('as od inner join products as p on p.id = od.product_id')
                            .select('p.id, p.name, p.price, p.quantity, SUM(od.quantity) as all_product,
                          SUM(case when od.status = 0 then od.quantity else 0 end) as is_waiting,
                          SUM(case when od.status = 1 then od.quantity else 0 end) as is_willing,
                          SUM(case when od.status = 2 then od.quantity else 0 end) as is_delivery,
                          SUM(case when od.status = 3 then od.quantity else 0 end) as is_finish,
                          SUM(case when od.status = 4 then od.quantity else 0 end) as is_cancelled')
                            .group('p.id, p.name')
  end

  def sell_product
    sell_quantity = params[:sell_quantity]
    product_id = params[:product_id]
    product = Product.find(product_id)
    product.quantity = product.quantity.to_i - sell_quantity.to_i
    product.save
    render json:{ message: product_id }, status: 200
  end

end
