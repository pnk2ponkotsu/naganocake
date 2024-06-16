class Public::OrdersController < ApplicationController
	before_action :authenticate_customer!
	before_action :check_cart_items,only: [:new]

	def about
		@order = Order.new
		@customer = current_customer
		@addresses = ShippingAddress.where(customer_id: current_customer.id)
	end

	def create
		@order = Order.new(order_params)
		@order.customer_id = current_customer.id
		
		#@customer = current_customer
		#@addresses = ShippingAddress.where(customer_id: current_customer.id)

		# sessionを使ってデータを一時保存
		#session[:order] = Order.new

		cart_items = current_customer.cart_items

		# total_paymentのための計算
		sum = 0
		cart_items.each do |cart_item|
			sum += cart_item.item.price_with_tax * cart_item.amount
		end

		@order.postage = 800
	  @order.total_payment = sum + @order.postage
		#session[:order][:order_status] = 0

		# ラジオボタンで選択された支払方法のenum番号を渡している
		#session[:order][:payment_method] = params[:method].to_i

		# ラジオボタンで選択されたお届け先によって条件分岐
		#destination = params[:a_method].to_i


		# お届け先情報に漏れがあればリダイレクト
		# if session[:order][:post_code].presence && session[:order][:address].presence && session[:order][:name].presence
		# 	redirect_to new_order_path
		# else
		# 	redirect_to customers_orders_about_path
		# end

		if @order.save!
			# 以下、order_detail作成
			cart_items.each do |cart_item|
				order_detail = OrderDetail.new
				order_detail.order_id = @order.id
				order_detail.item_id = cart_item.item.id
				order_detail.amount = cart_item.amount
				order_detail.making_status = 0
				order_detail.price = cart_item.item.price_with_tax
				order_detail.save!
			end
	
			# 購入後はカート内商品削除
			cart_items.destroy_all
			redirect_to orders_complete_path
		else
		    render :new
		end

	end


	def new
		@order = Order.new
		@customer = current_customer
		@addresses = ShippingAddress.where(customer_id: current_customer.id)
	end

	def check
		@cart_items = current_customer.cart_items
        @order = Order.new(order_params)
        @order.postage = 800
        @sum = 0
        @cart_items.each do |cart_item|
        	@sum += (cart_item.item.price * cart_item.amount * 1.1 ).floor
        end
        @order.total_payment = @sum + @order.postage


      if params[:order][:a_method] == "0"
       	 @order.post_code = current_customer.postal_code
     	 @order.address = current_customer.address
     	 @order.name = current_customer.last_name + current_customer.first_name

      elsif params[:order][:a_method] == "1"
     	 @address = ShippingAdrress.find(params[:order][:adrress_id])
     	 @order.post_code = @address.postal_code
     	 @order.address = @address.address
     	 @order.name = @address.name

      elsif params[:order][:a_method] == "2" && (@order.post_code =~ /\A\d{7}\z/) && @order.address? && @order.name?

      else
      	render :new
      end
    end


	def complete

		
	end

	def index
		@orders = current_customer.orders
	end

	def show
		@order = Order.find(params[:id])
		@order_details = @order.order_details
	end

    def check_cart_items
      unless current_customer.cart_items.present?
        redirect_to cart_items_path
      end
    end


	 private
		# def shipping_address_params
		# 	params.require(:shipping_address).permit(:customer_id, :postal_code, :name, :address)

	def order_params
	    params.require(:order).permit(:customer_id, :postage, :total_payment, :payment_method, :order_status, :post_code, :address, :name)
	end


	#     def order_detail_params
	#        params.require(:order_detail).permit(:order_id, :item_id, :quantity, :making_status, :price)
	#     end
end
