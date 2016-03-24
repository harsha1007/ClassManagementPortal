class RenameCourseNumber < ActiveRecord::Migration
  def change
  	rename_column :courses, :Course_number, :course_number
  end
end
