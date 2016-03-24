class RenameColumns < ActiveRecord::Migration
  def change
  	rename_column :course_mappings, :Decision, :decision
  	rename_column :course_mappings, :Grade, :grade
  	rename_column :courses, :Title, :title
  	rename_column :courses, :Description, :description
  	rename_column :courses, :Instructor, :instructor
  	rename_column :courses, :StartDate, :start_date
  	rename_column :courses, :EndDate, :end_date
  	rename_column :courses, :Status, :status
  	rename_column :materials, :CourseID, :course_id
  	rename_column :materials, :Information, :information
  end
end
