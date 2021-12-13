class AddVideoToChannel < ActiveRecord::Migration[6.1]
  def change
    add_reference :channels, :video, null: false, foreign_key: true
  end
end
