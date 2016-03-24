class AddInactiveRequestColumnToCourse < ActiveRecord::Migration
  def change
  	add_column :courses, :inactive_request, :string
  end
end
