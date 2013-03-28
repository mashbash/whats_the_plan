class AddBestRouteToPlan < ActiveRecord::Migration
  def change
    add_column :plans, :best_route_ids, :text
  end
end
