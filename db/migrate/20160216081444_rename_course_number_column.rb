class RenameCourseNumberColumn < ActiveRecord::Migration
  def change
  	rename_column :courses, :course_num, :Course_number
  end
end
