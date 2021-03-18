class CreateListings < ActiveRecord::Migration[6.1]
  def change
    create_table :listings do |t|
      t.integer :airbnb_id
      t.string :name
      t.integer :bedrooms
      t.integer :beds
      t.integer :person_capcity
      t.string :city
      t.string :state
      t.string :zipcode
      t.belongs_to :host, null: false, foreign_key: true

      t.index :airbnb_id, unique: true
      t.index [:name, :zipcode], unique: true
    end
  end
end
