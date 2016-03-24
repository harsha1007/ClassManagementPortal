class RenameCourseMappings < ActiveRecord::Migration
  def change
  	rename_column :course_mappings, :CourseID, :course_id
  	rename_column :course_mappings, :UserID, :user_id
  end
end
