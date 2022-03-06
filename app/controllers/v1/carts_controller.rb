module V1
	class CartsController < ApplicationController
		before_action :set_cart

		def index
			if @cart
				@cart_items = @cart.cart_items.order('id')
			end
		end

		def update_cart_item	
			Cart.transaction do
				if @cart
					cart_item = @cart.cart_items.where(
						item_id: params[:item_id], 
						addon_id: params[:addon_id],
						variation_id: params[:variation_id]
					).first_or_initialize
					cart_item.update!(cart_item_params)
				else
					cart = current_user.carts.new(active: true)
					if cart.save!
						cart.cart_items.create!(cart_item_params)
					end
				end
			end
			render json: {success: true}
		end

		def remove_item
			cart_item = CartItem.find(params[:id])
			if cart_item.destroy
				render json: {success: true}
			else
				render json: {success: false, errors: cart_item.errors.full_messages}
			end
		end

		def checkout
			if @cart and @cart.update(active: false, checked_out: Datetime.now)
				render json: {success: true}
			else
				render json: {success: false, errors: @cart.errors.full_messages}
			end
		end

		private

		def set_cart
			@cart = current_user.active_cart
		end

		def cart_item_params
			prms = params.permit(:item_id, :addon_id, :variation_id, :quantity, :addon_price, :variation_price)
			prms['base_price'] = params[:addon_price].to_f + params[:variation_price].to_f
			prms['total_price'] = prms['base_price'] * params[:quantity].to_i
			return prms
		end

	end
end