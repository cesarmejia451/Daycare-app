desc 'Fetch Daycare Centers'

task create_daycare_db: :environment do 
  api_daycares_array = Unirest.get("https://data.cityofchicago.org/resource/uyys-tdck.json").body
    count = 0
    api_daycares_array.each do |api_daycare|
      # count += 1
      # break if count > 10
      Center.create(
        name: api_daycare["doing_business_as_name"],
        address: api_daycare["address"],
        city: api_daycare["city"],
        state: api_daycare["state"],
        zip_code: api_daycare["zip_code"],
        latitude: api_daycare["latitude"].to_f,
        longitude: api_daycare["longitude"].to_f
        )
    end
end

count = 0
token = ENV['PLACE_API']
token_two = ENV['DETAILS_API']

task update_daycare_db: :environment do 
  Center.all.each do |center|

    # count += 1
    # break if count > 2

    next unless center.latitude.present? && center.longitude.present?

    keyword = URI.encode(center.name)
    location = Unirest.get("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{center.latitude},#{center.longitude}&keyword=#{keyword}&rankby=distance&key=#{token}")
    if(location.body["results"].empty?)
      next
    end

    place_id = location.body["results"].first["place_id"]

    if place_id.present?
      place = Unirest.get("https://maps.googleapis.com/maps/api/place/details/json?placeid=#{place_id}&key=#{token_two}").body["result"] 
      opening_hours = place["opening_hours"]
      weekday_text = opening_hours["weekday_text"] if opening_hours

      photos = place["photos"]
      photo_reference = photos[0]["photo_reference"] if photos


      center.update(
        name: place["name"],
        website: place["website"],
        phone: place["formatted_phone_number"],
        hours: weekday_text,
        description: photo_reference,
        latitude: place["geometry"]["location"]["lat"],
        longitude: place["geometry"]["location"]["lng"],
        )
      # puts "#{result}: #{center.id}"
    else
      next  
    end
  end
end 

token_three = ENV['GEOCODE_API']

task update_neighborhood: :environment do
  Center.all.each do |center|
    hood = Unirest.get("https://maps.googleapis.com/maps/api/geocode/json?latlng=#{center.latitude},#{center.longitude}&location_type=APPROXIMATE&result_type=political&key=#{token_three}")
    if(hood.body["results"].empty?)
      next
    else
      hood_find = hood.body["results"].first
      results = hood_find["address_components"].first
      name = results["long_name"] 

      center.update(
        neighborhood: name,
        )
    end
  end
end 

