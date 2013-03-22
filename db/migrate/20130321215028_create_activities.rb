class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string   :title
      t.string   :street
      t.string   :city
      t.string   :state
      t.integer  :zip_code
      t.string   :country
      t.float    :latitude
      t.float    :longitude
      t.integer  :meal

      t.timestamp
    end  
  end
end
