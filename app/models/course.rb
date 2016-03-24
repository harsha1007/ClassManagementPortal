class Course < ActiveRecord::Base
	validates :course_number, :title, :description, :instructor, :start_date, :end_date, :status, presence: true
	
	has_many :course_mappings
	has_many :users, through: :course_mappings
	has_many :materials
end
