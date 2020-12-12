class AddChangedPasswordToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :changed_password, :string, default: "true"
  end
end
