class CreateCourseMappings < ActiveRecord::Migration
  def change
    create_table :course_mappings do |t|
      t.integer :CourseID
      t.integer :UserID
      t.string :Decision
      t.string :Grade

      t.timestamps null: false
    end
  end
end
