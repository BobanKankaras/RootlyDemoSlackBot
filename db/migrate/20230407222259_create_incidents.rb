class CreateIncidents < ActiveRecord::Migration[6.1]
  def change
    create_table :incidents do |t|
      t.string :title
      t.string :description
      t.string :severity
      t.string :created_by
      t.integer :resolved
      t.string :resolved_by
      t.datetime :resolved_at
      t.string :channel_id

      t.timestamps
    end
  end
end

