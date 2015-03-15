json.array! @users do |user|
  json.id user.id
  json.username user.username
  json.email user.email
  json.latitude user.latitude
  json.longitude user.longitude
end
