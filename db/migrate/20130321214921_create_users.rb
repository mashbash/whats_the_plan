class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string   :name
      t.string   :street
      t.string   :city
      t.string   :state
      t.integer  :zip_code
      t.string   :country

      t.timestamps
    end
  end
end
