Geocoder.configure(
  timeout: 10,
  lookup: :google,
  api_key: ENV['GOOGLE_MAPS_API_KEY'],
  units: :mi
)
