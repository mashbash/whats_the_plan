class CreateActivityPlans < ActiveRecord::Migration
  def change
    create_table :activity_plans do |t|
      t.integer  :plan_id,      :null => false
      t.integer  :activity_id,  :null => false
      t.integer  :sequence

      t.timestamps
    end  
  end
end
