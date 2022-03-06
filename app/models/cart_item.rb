class CartItem < ApplicationRecord
	belongs_to :cart

	after_commit :update_gross_amount

	def update_gross_amount
		cart = self.cart
		cart.gross_amount = cart.cart_items.sum(:total_price)
		cart.save!
	end
end
