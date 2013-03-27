class AddSequencedColumnToPlan < ActiveRecord::Migration
  def change
    add_column :plans, :sequenced, :boolean, :default => false
  end
end
