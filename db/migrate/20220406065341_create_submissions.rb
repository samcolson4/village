class CreateSubmissions < ActiveRecord::Migration[7.0]
  def change
    create_table :submissions do |t|
      t.string :headline
      t.string :url
      t.string :image_url
      t.integer :score
      t.boolean :today, :default => false
      t.boolean :used, :default => false
      t.date :used_date
      t.timestamps
    end
  end
end
