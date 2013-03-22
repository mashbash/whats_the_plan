class CreateActivityPlans < ActiveRecord::Migration
  def change
    create_table :activity_plans do |t|
      t.integer  :plan_id
      t.integer  :activity_id
      t.integer  :sequence
    end  
  end
end
