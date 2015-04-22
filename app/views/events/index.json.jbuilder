json.array! @nearby_events do |event|

  json.id event.id
  json.latitude event.latitude
  json.longitude event.longitude
  json.created_at event.created_at
  json.category event.category
  json.sub_category event.sub_category
  json.note event.note
  json.distance event.distance

  json.people_attending event.users.count 

end
