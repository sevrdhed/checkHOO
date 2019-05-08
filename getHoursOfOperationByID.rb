# * *Arguments* :
#   - +token+ -> a token hash
#   - +fields+ -> List of elements to return in response
#   - +profileId+ -> ID of the profile
#
# * *Returns* :
#   - the Hours of Operation profile identified by profileId
#
# * *Raises* :
#   - +ArgumentError+ -> if the token object doesn't have expected fields
#

require '/mnt/c/Users/stephen.heath/Ruby/checkHOO/rubyincontacttoken.rb'



def getHoursOfOperationByID(profileId)
  # Check that the token is a valid token.
  token = getToken()
  unless !(token["access_token"] == nil && 
           token["resource_server_base_uri"] == nil)
    raise ArgumentError, "the function didn't receive a token it could understand"
  end
      
  # Pull the access token and base URL from the response body.
  accessToken = token["access_token"]
  baseURL = token["resource_server_base_uri"]
 
  # Create the URL that accesses the API.
  apiURL = "services/V15.0/hours-of-operation/#{profileId}"
  uri = URI.parse(baseURL + apiURL)
 
  # Create the GET request headers.
  headers = 
    { "accept-encoding" => "identity",
	  "Accept" => "application/json, text/javascript, */*; q=0.01",
      "Authorization" => "bearer #{accessToken}",
      "Content-Type" => "application/x-www-form-urlencoded",
      "Data-Type" => "json" }
 
  # Set up an HTTP object.
  http = Net::HTTP.new uri.host, uri.port
 
  # Make the GET request an HTTPS GET request.
  http.use_ssl = true
 
  # Delete this line and be sure you have a valid certificate.
  # The default Ruby library, net/https, doesn't check the validity of a 
  # certificate during a handshake. Using VERIFY_NONE is a simple, and insecure,
  # hack to get around this limitation.
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
 
  # Make the request and store the response.
  response = http.request_get(baseURL + apiURL, headers)
    
  # The data the API returns is in JSON, so parse it if it's valid.
  data = if response.body != ""
      JSON.parse(response.body)
    else
	
      "The response was empty."
  end
  
 # Now you can do something with the data the API returned.
end

