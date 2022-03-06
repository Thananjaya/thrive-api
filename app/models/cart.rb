class Cart < ApplicationRecord
	has_many :cart_items, dependent: :destroy

	belongs_to :user

	default_scope {where(active: true)}
end
