json.array!(@course_mappings) do |course_mapping|
  json.extract! course_mapping, :id, :CourseID, :UserID, :Decision, :Grade
  json.url course_mapping_url(course_mapping, format: :json)
end
