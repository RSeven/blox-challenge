class RemoveResetPasswordTokenIndexFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_index :users, :reset_password_token
  end
end
