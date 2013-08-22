class CreateLabels < ActiveRecord::Migration
  def change
    create_table :labels do |t|
      t.integer :post_id
      t.integer :category_id

      t.timestamps
    end
  end
end
