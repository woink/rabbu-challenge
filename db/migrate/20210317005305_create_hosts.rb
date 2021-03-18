class CreateHosts < ActiveRecord::Migration[6.1]
  def change
    create_table :hosts do |t|
      t.integer :host_id
      t.string :first_name
      t.string :resp_rate
      t.string :resp_time
      t.string :accept_rate
      t.integer :reviewee_count

      t.timestamps
    end
  end
end
