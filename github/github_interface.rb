require 'httparty'
class GithubInterface
  include HTTParty
  base_uri 'https://api.github.com'
  format   :json
  headers 'Content-Type' => 'application/json', 'User-Agent' => 'api_testing_user_agent'
  
  def self.set_access_token( token )
   @token = token    
  end
  
  def self.get_access_token
   @token    
  end
  
  def self.user_emails( authentication_token )
    response = get("/user/emails", :headers => {:Authorization => "token #{authentication_token}"})
    response
  end
  
  def self.fails_in_case_authentication_token_is_missing
    puts "Running test one: fails_in_case_authentication_token_is_missing"
    r = user_emails( nil )
    r.response.code.to_i == 401 
  end
  
  def self.success_in_case_authentication_token_is_present
    puts "Running test one: success_in_case_authentication_token_is_present"
    r = user_emails( get_access_token )
    r.response.code.to_i == 200 
  end
  
  def self.test_user_emails
    # Test if it fails in case if authentication_token is missing
   puts self.fails_in_case_authentication_token_is_missing
   puts self.success_in_case_authentication_token_is_present
  end
end
GithubInterface.set_access_token( ARGV[0] )
GithubInterface.test_user_emails