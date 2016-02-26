class Daycare < ActiveRecord::Base

  attr_reader :id
  attr_accessor :doing_business_as_name, :address, :city, :state, :zip_code, :longitude, :latitude 

  def initialize(hash)
    @id = hash["id"]
    @doing_business_as_name = hash["doing_business_as_name"]
    @address = hash["address"]
    @city = hash["city"]
    @state = hash["state"]
    @zip_code = hash["zip_code"]
    @longitude = hash["longitude"]
    @latitude = hash["latitude"]
  end

  def self.all
    api_daycares_array = Unirest.get("https://data.cityofchicago.org/resource/uyys-tdck.json").body
    daycares = []
    api_daycares_array.each { |api_daycare| daycares << Daycare.new(api_daycare) }
    daycares
  end

end
