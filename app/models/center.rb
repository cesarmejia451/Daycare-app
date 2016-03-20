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

      p '++++++++++++++++++'
      p open
      p '+++++++++++++++++'
      if open == false
        p "Closed Now"
      else open == true
        p "Open Now"
      end
    end
  end   

  def neighborhood
    hood = Unirest.get("https://maps.googleapis.com/maps/api/geocode/json?latlng=#{latitude},#{longitude}&key=#{ENV["GEOCODE_API"]}")

    if(hood.body["results"].empty?)
      p ""
    else
      hood_find = hood.body["results"].fifth
      results = hood_find["address_components"].first
      name = results["long_name"] 
    end
  end 

end



