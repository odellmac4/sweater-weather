class AddApiKeyToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :api_key, :string, default: nil
  end
end
