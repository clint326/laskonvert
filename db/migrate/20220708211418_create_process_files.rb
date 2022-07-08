class CreateProcessFiles < ActiveRecord::Migration[7.0]
  def change
    create_table :process_files do |t|
      t.integer :step
      t.text :text

      t.timestamps
    end
  end
end
