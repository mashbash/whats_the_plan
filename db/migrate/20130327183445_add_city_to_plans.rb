class AddCityToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :city, :string
    add_index  :plans, :city
  end
end
