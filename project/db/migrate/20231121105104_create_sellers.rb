class CreateSellers < ActiveRecord::Migration[7.0]
  def change
    create_table :sellers do |t|
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
