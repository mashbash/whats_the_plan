class AddTimestampsToActivityPlans < ActiveRecord::Migration
  def change
    add_column :activity_plans, :created_at, :datetime, :null => false
    add_column :activity_plans, :updated_at, :datetime, :null => false
  end
end
