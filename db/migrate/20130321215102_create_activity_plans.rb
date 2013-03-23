class CreateActivityPlans < ActiveRecord::Migration
  def change
    create_table :activity_plans do |t|
      # Don't forget :null => false where appropriate!
      t.integer  :plan_id
      t.integer  :activity_id
      t.integer  :sequence

      # What about timestamps?
    end  
  end
end
