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

task update_daycare_db: :environment do 
  Center.all.each do |center|
    next unless center.latitude.present? && center.longitude.present?

    keyword = URI.encode(center.name)
    location = Unirest.get("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{center.latitude},#{center.longitude}&keyword=#{keyword}&rankby=distance&key=AIzaSyA_avcWZehsC2QH_V83EZwjkg26NVptYmQ 
")
    if(location.body["results"].empty?)
      next
    end

    place_id = location.body["results"].first["place_id"]

    if place_id.present?
      place = Unirest.get("https://maps.googleapis.com/maps/api/place/details/json?placeid=#{place_id}&key=AIzaSyCAORTL2oMfcfEqz4ttarDXfrGhIOvDJL0  
").body["result"] 
      opening_hours = place["opening_hours"]
      # weekday_text = nil
      weekday_text = opening_hours["weekday_text"] if opening_hours

      center.update(
        name: place["name"],
        website: place["website"],
        phone: place["formatted_phone_number"],
        hours: weekday_text,
        description: place["photos"],
        latitude: place["geometry"]["location"]["lat"],
        longitude: place["geometry"]["location"]["lng"],
        )
      # puts "#{result}: #{center.id}"
    else
      next  
    end
  end
end 

task update_daycare_db_2: :environment do 
  Center.all.each do |center|
    next unless center.latitude.present? && center.longitude.present?

    keyword = URI.encode(center.name)
    location = Unirest.get("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{center.latitude},#{center.longitude}&keyword=#{keyword}%20chicago%20daycare&rankby=distance&key=AIzaSyCEqCLo4TVtpXq41YwGb36CKvG95gfvvw0")
    if(location.body["results"].empty?)
      next
    end

    place_id = location.body["results"].first["place_id"]

    if place_id.present?
      # fire request 2 to google with place id
      place = Unirest.get("https://maps.googleapis.com/maps/api/place/details/json?placeid=#{place_id}&key=AIzaSyCEqCLo4TVtpXq41YwGb36CKvG95gfvvw0  
").body["result"]

      opening_hours = place["opening_hours"]
      weekday_text = opening_hours["weekday_text"] if opening_hours
      # do a similar check for presence
      # center.update ....
      center.update(
        #add sad path
        name: place["name"],
        website: place["website"],
        phone: place["formatted_phone_number"],
        hours: weekday_text,
        description: place["photos"]
        )
    else
      next  
    end
  end
end 
