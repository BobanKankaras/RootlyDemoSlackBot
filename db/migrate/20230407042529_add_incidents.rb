class AddIncidents < ActiveRecord::Migration[7.0]
  def change
    add_column :incidents, :channel_id, :string
  end
end
