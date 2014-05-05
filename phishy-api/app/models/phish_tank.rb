module PhishTank

  class Client
    include HTTParty

    base_uri "http://data.phishtank.com/data"

    def initialize(api_key)
      @api_key = api_key
    end

    def online_valid()
      response = self.class.get("/#{@api_key}/online-valid.json")
      return JSON(response.body)
    end
  end

  class Api

    attr_reader :api_key
    attr_reader :client

    def initialize(api_key)
      @api_key = api_key
      @client = PhishTank::Client.new(@api_key)
    end

    # returns a list of PhishTank's blacklisted urls
    def blacklisted()
      online_valid = @client.online_valid()
      online_valid.map { |json| json['url'] }
    end

  end
end
