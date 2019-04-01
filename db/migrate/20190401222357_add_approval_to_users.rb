class AddApprovalToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :approval, :integer
  end
end
