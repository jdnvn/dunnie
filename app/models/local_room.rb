class LocalRoom < Room
  reverse_geocoded_by :latitude, :longitude
end
