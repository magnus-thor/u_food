class AddAdminUserToRestaurants < ActiveRecord::Migration[5.1]
  def change
    add_reference :restaurants, :admin_user, foreign_key: true
  end
end
