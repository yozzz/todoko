class CreateItems < ActiveRecord::Migration[8.1]
  def change
    create_table :items do |t|
      t.text :description
      t.datetime :due_date
      t.references :list

      t.timestamps
    end
  end
end
