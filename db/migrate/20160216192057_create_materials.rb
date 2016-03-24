class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.integer :CourseID
      t.text :Information

      t.timestamps null: false
    end
  end
end
