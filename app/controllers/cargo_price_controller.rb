class CargoPriceController < ApplicationController
  def index
    @page_cargo_price_active = true


    if params[:@start_date].present? and params[:end_date].present?
      @start_date = params[:@start_date]
      @end_date = params[:end_date]
    else
      @start_date = (Time.now - 1.month).strftime('%Y-%m-%d')
      @end_date = Time.now.strftime('%Y-%m-%d')
    end

    # @products = Product.all
    # @products = @products.where.not(cargo: [nil])
    # @products = @products.where("cargo > ?", 0).order('updated_at desc')
    # if params[:q]
    #   @products = @products.where("name like ?", "%#{params[:q]}%")
    # end


    sql = "SELECT
    pr.id,
    pr.name,
    pr.received_count as irsen_too,
    pr.cargo,
    (SELECT
            SUM(P.cargo * P.received_count)
        FROM
            products P
        WHERE
            P.id = pr.id) AS total,
    SUM(od.quantity) AS zarsan,
    SUM(od.cargo_price * od.quantity) AS zarsan_niit,
    (pr.received_count - pr.rejected - pr.sold_count - (select sum(order_details.quantity)
    FROM
        order_details WHERE finish_date <= '#{Time.now.strftime('%Y-%m-%d')}' and order_details.product_id = pr.id)) as uldegdel
    FROM
        order_details AS od
            INNER JOIN
        products AS pr ON od.product_id = pr.id
    WHERE
        od.finish_date BETWEEN '#{@start_date}' AND '#{@end_date}'
            AND pr.received_count > 0 AND pr.cargo > 0
    GROUP BY od.product_id order by pr.id desc;"
    @records_array = ActiveRecord::Base.connection.execute(sql)

    @total = 0
    @total_range = 0
    @total_remainder = 0

    @records_array.each do |report|
      @total = @total + report[4]
      @total_range = @total_range + report[6]
      @total_remainder = @total_remainder + (report[7]*report[3])
    end


  end
end
