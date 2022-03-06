child @cart, object_root: false, root: 'cart' do
	node do |cart|
		{
			cart_id: @cart.id,
			gross_amount: @cart.gross_amount		
		}
	end
end

child @cart_items, object_root: false, root: 'cart_items' do
	attributes :id, :quantity, :total_price, :base_price, :variation_id, :variation_price, :addon_id, :addon_price
end

node(:success){true}

if @cart.blank?
	node(:success){false}
	node(:errors){['item not yet added in the cart']}
end