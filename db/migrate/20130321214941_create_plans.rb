class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.integer  :user_id
      t.string   :title
      t.string   :location
      t.date     :start_date
      t.date     :end_date

      t.timestamp
    end
  end    
end
