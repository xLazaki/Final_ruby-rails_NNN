class CreateVideos < ActiveRecord::Migration[6.1]
  def change
    create_table :videos do |t|
      t.text :title
      t.text :description
      t.text :tag

      t.timestamps
    end
  end
end
