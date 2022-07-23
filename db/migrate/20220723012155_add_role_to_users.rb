# migration_signature: fa2955a48bf0429f9711e0d0df927537

class AddRoleToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :role, :integer
  end
end
