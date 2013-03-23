class AddIndexesToActivityPlans < ActiveRecord::Migration
  def change
    add_index :activity_plans, [:plan_id, :activity_id]
    add_index :activity_plans, :activity_id
  end
end
