class Public::CartItemsController < ApplicationController
    before_action :authenticate_customer!


    # カート商品一覧を表示
    def index
        @cart_items = current_customer.cart_items
        # CartItem.all.sum(:price)

    end

    # カート商品を追加する
    def create
        # @cart_item = current_customer.cart_items.build(item_id: params[:item_id])
        @cart_item = CartItem.new(cart_item_params)
        @cart_item.customer_id = current_customer.id
        @cart_item.item_id = params[:cart_item][:item_id]
        #byebug

        if(cart_item_params[:amount].empty?)
            flash[:alert] = "個数を選択してください"
            @item = Item.find(params[:cart_item][:item_id])
            render "public/items/show"
        else
            if cart_item = current_customer.cart_items.find_by(item_id: cart_item_params[:item_id])
                #byebug
              amount = cart_item.amount + cart_item_params[:amount].to_i
              cart_item.update(amount: amount)
            else
                cart_item = CartItem.new(cart_item_params)
                cart_item.customer_id = current_customer.id
                cart_item.save
            end

            redirect_to cart_items_path
        end


    end

    # 削除や個数を変更した際、カート商品を再計算する
    def update
        @cart_item = CartItem.find(params[:id])
        #@cart.units += cart_params[:units].to_i
        @cart_item.update(cart_item_params)
        redirect_to cart_items_path
    end

    # カート商品を一つのみ削除
    def destroy
        @cart_item = CartItem.find(params[:id])
        @cart_item.destroy
        flash.now[:alert] = "#{@cart_item.item.name}を削除しました"
        redirect_to cart_items_path
    end

    # カート商品を空ににする
    def all_destroy
        @cart_item = current_customer.cart_items
        @cart_item.destroy_all
        flash[:alert] = "カートの商品を全て削除しました"
        redirect_to cart_items_path
    end









    private

      def cart_item_params
        params.require(:cart_item).permit(:amount, :item_id, :customer_id)
      end

end