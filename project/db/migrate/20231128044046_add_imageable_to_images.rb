class AddImageableToImages < ActiveRecord::Migration[7.0]
  def change
    add_reference :images, :imageable, polymorphic: true, null: false
  end
end
