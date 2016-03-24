class CreateTables < ActiveRecord::Migration
  def change
    create_table "courses", force: :cascade do |t|
    	t.string   "Title"
    	t.string   "Description"
    	t.string   "Instructor"
    	t.datetime "StartDate"
    	t.datetime "EndDate"
    	t.string   "Status"
    	t.datetime "created_at",  null: false
    	t.datetime "updated_at",  null: false
    	t.string   "course_num"
    end

    create_table "users", force: :cascade do |t|
    	t.string   "name"
    	t.string   "email"
    	t.string   "password"
    	t.datetime "created_at", null: false
    	t.datetime "updated_at", null: false
    	t.string   "usertype"
    end
  end
end
