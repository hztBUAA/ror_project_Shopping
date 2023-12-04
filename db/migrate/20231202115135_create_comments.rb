class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :commodity, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.string :text

      t.timestamps
    end
  end
end