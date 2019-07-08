class CreateOrganizations < ActiveRecord::Migration[5.2]
  def change
    create_table :organizations do |t|
      t.string :name
      t.float :hourly_rate

      t.timestamps
    end
  end
end
