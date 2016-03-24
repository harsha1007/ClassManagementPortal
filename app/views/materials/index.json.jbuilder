json.array!(@materials) do |material|
  json.extract! material, :id, :CourseID, :Information
  json.url material_url(material, format: :json)
end
