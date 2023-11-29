class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :country
      t.string :city
      t.string :house_address
      t.string :phone_number
      t.string :greeting_name
      # t.integer :customer_id
      t.references :customer, foreign_key: true
      t.timestamps
    end
  end
end
