class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.references :user, null: false, foreign_key: true
      t.string :author
      t.string :title
      t.text :summary
      t.integer :publishing_year
      t.decimal :price

      t.timestamps
    end
  end
end
