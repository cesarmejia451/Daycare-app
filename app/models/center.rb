class Center < ActiveRecord::Base
  has_many :images
  has_many :center_programs
  has_many :programs, through: :center_programs

  has_many :posts
  has_many :referrals

 def open_hours
    

    keyword = URI.encode(name)
    p 'keyword'
    p keyword
    location = Unirest.get("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{latitude},#{longitude}&keyword=#{keyword}&rankby=distance&key=#{ENV["HOURS_API"]}")
    p location.body
    if(location.body["results"].empty?)
      p ""
    else
      opening_hours = location.body["results"].first
      open_now = opening_hours["opening_hours"]
      open = open_now["open_now"]

      if open == false
        p "Closed Now"
      else open == true
        p "Open Now"
      end
    end
  end   

  # def neighborhood
  #   hood = Unirest.get("https://maps.googleapis.com/maps/api/geocode/json?latlng=#{latitude},#{longitude}&key=#{ENV["GEOCODE_API"]}")

  #   hood = Unirest.get("https://maps.googleapis.com/maps/api/geocode/json?latlng=#{latitude},#{longitude}&location_type=APPROXIMATE&result_type=political&key=#{ENV["GEOCODE_API"]}")

  #   if(hood.body["results"].empty?)
  #     p ""
  #   else
  #     hood_find = hood.body["results"].first
  #     results = hood_find["address_components"].first
  #     name = results["long_name"] 
  #   end
  # end 

  def random_image

    image = ["https://bfb89515afffff903eb7a381cf5e58e24a620c1b-www.googledrive.com/host/0B09DNIgcGom_b1hxS2JnYXBiWFk/daycareimg.jpg", "https://bfb89515afffff903eb7a381cf5e58e24a620c1b-www.googledrive.com/host/0B09DNIgcGom_b1hxS2JnYXBiWFk/daycare_toy.jpg", "https://bfb89515afffff903eb7a381cf5e58e24a620c1b-www.googledrive.com/host/0B09DNIgcGom_b1hxS2JnYXBiWFk/Logo2.jpg", "https://bfb89515afffff903eb7a381cf5e58e24a620c1b-www.googledrive.com/host/0B09DNIgcGom_b1hxS2JnYXBiWFk/toy_1.jpg", "https://bfb89515afffff903eb7a381cf5e58e24a620c1b-www.googledrive.com/host/0B09DNIgcGom_b1hxS2JnYXBiWFk/toy_org.jpg", "https://bfb89515afffff903eb7a381cf5e58e24a620c1b-www.googledrive.com/host/0B09DNIgcGom_b1hxS2JnYXBiWFk/toy_duck.jpg"]
    url = image.shuffle
    p url.first

  end

end



