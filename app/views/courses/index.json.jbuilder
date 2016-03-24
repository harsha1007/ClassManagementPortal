json.array!(@courses) do |course|
  json.extract! course, :id, :Title, :Description, :Instructor, :StartDate, :EndDate, :Status
  json.url course_url(course, format: :json)
end
