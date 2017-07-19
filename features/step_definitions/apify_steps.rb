# frozen_string_literal: true

# refactored to use rest client.
# These steps will currently not work due to oauth settings.
# TODO determine if these should even be in this repo.

Given(/^I fill in input fields with valid credentials for apple tv$/) do
  @http_parameters = {}
  @test_time = Time.now.to_i
  @http_parameters['email_address'] = "spiritclipsqa+#{@test_time}@gmail.com"
  @http_parameters['platform_type'] = 'Apple TV'
  @http_parameters['device_id'] = '2BB54445-287D-4E0F-A943-D3D7B463BB2F'
  @http_parameters['transaction_id'] = '180000138989082'
  @http_parameters['plan_type'] = 'ZKT3IAGN.W7BN'
  @http_parameters['receipt'] = 'ewoJInNpZ25hdHVyZSIgPSAiQW9GRU5sT09rMC9PWmpVd01DZ1pOMVp1d2k3Nzl4NHRSRVM3ZVcyblRqcS9mcnpDRkVsMUFSMmxBelVobzVTZElLRC85MGxQTkgvaS94WWlXZkVwL0xEaVhqS3dkTlhzS2ZQTzdrZjMybXJ3MktnUHpBa05uUndRc2V2R3J4Z05MZEpTVzVqVVlTWWZyOGlTMTQ4N0p2eVg5K1F3OEk5U0NVY2MwV3FIaGNSVEFBQURWekNDQTFNd2dnSTdvQU1DQVFJQ0NCdXA0K1BBaG0vTE1BMEdDU3FHU0liM0RRRUJCUVVBTUg4eEN6QUpCZ05WQkFZVEFsVlRNUk13RVFZRFZRUUtEQXBCY0hCc1pTQkpibU11TVNZd0pBWURWUVFMREIxQmNIQnNaU0JEWlhKMGFXWnBZMkYwYVc5dUlFRjFkR2h2Y21sMGVURXpNREVHQTFVRUF3d3FRWEJ3YkdVZ2FWUjFibVZ6SUZOMGIzSmxJRU5sY25ScFptbGpZWFJwYjI0Z1FYVjBhRzl5YVhSNU1CNFhEVEUwTURZd056QXdNREl5TVZvWERURTJNRFV4T0RFNE16RXpNRm93WkRFak1DRUdBMVVFQXd3YVVIVnlZMmhoYzJWU1pXTmxhWEIwUTJWeWRHbG1hV05oZEdVeEd6QVpCZ05WQkFzTUVrRndjR3hsSUdsVWRXNWxjeUJUZEc5eVpURVRNQkVHQTFVRUNnd0tRWEJ3YkdVZ1NXNWpMakVMTUFrR0ExVUVCaE1DVlZNd2daOHdEUVlKS29aSWh2Y05BUUVCQlFBRGdZMEFNSUdKQW9HQkFNbVRFdUxnamltTHdSSnh5MW9FZjBlc1VORFZFSWU2d0Rzbm5hbDE0aE5CdDF2MTk1WDZuOTNZTzdnaTNvclBTdXg5RDU1NFNrTXArU2F5Zzg0bFRjMzYyVXRtWUxwV25iMzRucXlHeDlLQlZUeTVPR1Y0bGpFMU93QytvVG5STStRTFJDbWVOeE1iUFpoUzQ3VCtlWnRERWhWQjl1c2szK0pNMkNvZ2Z3bzdBZ01CQUFHamNqQndNQjBHQTFVZERnUVdCQlNKYUVlTnVxOURmNlpmTjY4RmUrSTJ1MjJzc0RBTUJnTlZIUk1CQWY4RUFqQUFNQjhHQTFVZEl3UVlNQmFBRkRZZDZPS2RndElCR0xVeWF3N1hRd3VSV0VNNk1BNEdBMVVkRHdFQi93UUVBd0lIZ0RBUUJnb3Foa2lHOTJOa0JnVUJCQUlGQURBTkJna3Foa2lHOXcwQkFRVUZBQU9DQVFFQWVhSlYyVTUxcnhmY3FBQWU1QzIvZkVXOEtVbDRpTzRsTXV0YTdONlh6UDFwWkl6MU5ra0N0SUl3ZXlOajVVUllISytIalJLU1U5UkxndU5sMG5rZnhxT2JpTWNrd1J1ZEtTcTY5Tkluclp5Q0Q2NlI0Szc3bmI5bE1UQUJTU1lsc0t0OG9OdGxoZ1IvMWtqU1NSUWNIa3RzRGNTaVFHS01ka1NscDRBeVhmN3ZuSFBCZTR5Q3dZVjJQcFNOMDRrYm9pSjNwQmx4c0d3Vi9abEwyNk0ydWVZSEtZQ3VYaGRxRnd4VmdtNTJoM29lSk9PdC92WTRFY1FxN2VxSG02bTAzWjliN1BSellNMktHWEhEbU9Nazd2RHBlTVZsTERQU0dZejErVTNzRHhKemViU3BiYUptVDdpbXpVS2ZnZ0VZN3h4ZjRjemZIMHlqNXdOelNHVE92UT09IjsKCSJwdXJjaGFzZS1pbmZvIiA9ICJld29KSW05eWFXZHBibUZzTFhCMWNtTm9ZWE5sTFdSaGRHVXRjSE4wSWlBOUlDSXlNREUwTFRFeExURTJJREF5T2pBd09qVXdJRUZ0WlhKcFkyRXZURzl6WDBGdVoyVnNaWE1pT3dvSkluQjFjbU5vWVhObExXUmhkR1V0YlhNaUlEMGdJakUwTVRZeE16SXdOVEF3TURBaU93b0pJblZ1YVhGMVpTMXBaR1Z1ZEdsbWFXVnlJaUE5SUNKRU16Y3dPVUZFUWpNNE56RXlSVVZGTkRJek4wTTNOekpETnpNeE9EYzRRalEzT0VSRU9FVTJJanNLQ1NKdmNtbG5hVzVoYkMxMGNtRnVjMkZqZEdsdmJpMXBaQ0lnUFNBaU1UZ3dNREF3TVRNNE9UZzVNRGd5SWpzS0NTSmxlSEJwY21WekxXUmhkR1VpSUQwZ0lqRTBNVFkzTXpZNE5UQXdNREFpT3dvSkltRndjQzFwZEdWdExXbGtJaUE5SUNJME56STFOamMxTnpjaU93b0pJblJ5WVc1ellXTjBhVzl1TFdsa0lpQTlJQ0l4T0RBd01EQXhNemc1T0Rrd09ESWlPd29KSW5GMVlXNTBhWFI1SWlBOUlDSXhJanNLQ1NKdmNtbG5hVzVoYkMxd2RYSmphR0Z6WlMxa1lYUmxMVzF6SWlBOUlDSXhOREUyTVRNeU1EVXdNREF3SWpzS0NTSjNaV0l0YjNKa1pYSXRiR2x1WlMxcGRHVnRMV2xrSWlBOUlDSXhPREF3TURBd01URXdNREV3TkRBaU93b0pJbWwwWlcwdGFXUWlJRDBnSWpreU9EVTJORGMxTXlJN0Nna2laWGh3YVhKbGN5MWtZWFJsTFdadmNtMWhkSFJsWkNJZ1BTQWlNakF4TkMweE1TMHlNeUF4TURvd01EbzFNQ0JGZEdNdlIwMVVJanNLQ1NKd2RYSmphR0Z6WlMxa1lYUmxJaUE5SUNJeU1ERTBMVEV4TFRFMklERXdPakF3T2pVd0lFVjBZeTlIVFZRaU93b0pJbTl5YVdkcGJtRnNMWEIxY21Ob1lYTmxMV1JoZEdVaUlEMGdJakl3TVRRdE1URXRNVFlnTVRBNk1EQTZOVEFnUlhSakwwZE5WQ0k3Q2draWNISnZaSFZqZEMxcFpDSWdQU0FpVlVOSVdVczRSRmN1VGtWVk1TSTdDZ2tpWlhod2FYSmxjeTFrWVhSbExXWnZjbTFoZEhSbFpDMXdjM1FpSUQwZ0lqSXdNVFF0TVRFdE1qTWdNREk2TURBNk5UQWdRVzFsY21sallTOU1iM05mUVc1blpXeGxjeUk3Q2draWFYTXRkSEpwWVd3dGNHVnlhVzlrSWlBOUlDSjBjblZsSWpzS0NTSndkWEpqYUdGelpTMWtZWFJsTFhCemRDSWdQU0FpTWpBeE5DMHhNUzB4TmlBd01qb3dNRG8xTUNCQmJXVnlhV05oTDB4dmMxOUJibWRsYkdWeklqc0tDU0ppYVdRaUlEMGdJbU52YlM1emNHbHlhWFJqYkdsd2N5NXpZeUk3Q2draVluWnljeUlnUFNBaU1TNHdJanNLZlE9PSI7CgkicG9kIiA9ICIxOCI7Cgkic2lnbmluZy1zdGF0dXMiID0gIjAiOwp9'
  @http_parameters['X-Forwarded-Proto'] = 'https'
end

Given(/^I fill in input fields with valid credentials for roku$/) do
  @http_parameters = {}
  @test_time = Time.now.to_i
  @http_parameters['email_address'] = "spiritclipsqa+#{@test_time}@gmail.com"
  @http_parameters['platform_type'] = 'Roku'
  @http_parameters['device_id'] = '123456'
  @http_parameters['transaction_id'] = '37873f3e-4b52-4fbe-9f8e-a48e00e987fb'
  @http_parameters['plan_type'] = 'annual'
end

Given(/^I fill in input fields with valid credentials for ios$/) do
  @http_parameters = {}
  @test_time = Time.now.to_i
  @http_parameters['email_address'] = "spiritclipsqa+#{@test_time}@gmail.com"
  @http_parameters['platform_type'] = 'ios'
  @http_parameters['device_id'] = '2BB54445-287D-4E0F-A943-D3D7B463BB2F'
  @http_parameters['transaction_id'] = '180000138989082'
  @http_parameters['plan_type'] = 'ZKT3IAGN.W7BN'
  @http_parameters['receipt'] = 'ewoJInNpZ25hdHVyZSIgPSAiQW1wTXA1cXZMdklrcDA1MHV1N1kxdlhsVXhjSlh2QkJDWTduR1hJa09kRHFQWmJqM2R0TDdsMld3aW1SV3UwZUc1NnhmcnF0djU5VERmODQ1YlJTZnZSWTJERjZDYnNUR2E2TW5HK1FDY0REMUlIZUNwQ1ozbnFXT2R2NElQZERUUittdHZja0M0N05BaWlmNjJxMUlMWG9lelUwVWROcHlBMTd5Vmhnd3dzSEFBQURWekNDQTFNd2dnSTdvQU1DQVFJQ0NCdXA0K1BBaG0vTE1BMEdDU3FHU0liM0RRRUJCUVVBTUg4eEN6QUpCZ05WQkFZVEFsVlRNUk13RVFZRFZRUUtEQXBCY0hCc1pTQkpibU11TVNZd0pBWURWUVFMREIxQmNIQnNaU0JEWlhKMGFXWnBZMkYwYVc5dUlFRjFkR2h2Y21sMGVURXpNREVHQTFVRUF3d3FRWEJ3YkdVZ2FWUjFibVZ6SUZOMGIzSmxJRU5sY25ScFptbGpZWFJwYjI0Z1FYVjBhRzl5YVhSNU1CNFhEVEUwTURZd056QXdNREl5TVZvWERURTJNRFV4T0RFNE16RXpNRm93WkRFak1DRUdBMVVFQXd3YVVIVnlZMmhoYzJWU1pXTmxhWEIwUTJWeWRHbG1hV05oZEdVeEd6QVpCZ05WQkFzTUVrRndjR3hsSUdsVWRXNWxjeUJUZEc5eVpURVRNQkVHQTFVRUNnd0tRWEJ3YkdVZ1NXNWpMakVMTUFrR0ExVUVCaE1DVlZNd2daOHdEUVlKS29aSWh2Y05BUUVCQlFBRGdZMEFNSUdKQW9HQkFNbVRFdUxnamltTHdSSnh5MW9FZjBlc1VORFZFSWU2d0Rzbm5hbDE0aE5CdDF2MTk1WDZuOTNZTzdnaTNvclBTdXg5RDU1NFNrTXArU2F5Zzg0bFRjMzYyVXRtWUxwV25iMzRucXlHeDlLQlZUeTVPR1Y0bGpFMU93QytvVG5STStRTFJDbWVOeE1iUFpoUzQ3VCtlWnRERWhWQjl1c2szK0pNMkNvZ2Z3bzdBZ01CQUFHamNqQndNQjBHQTFVZERnUVdCQlNKYUVlTnVxOURmNlpmTjY4RmUrSTJ1MjJzc0RBTUJnTlZIUk1CQWY4RUFqQUFNQjhHQTFVZEl3UVlNQmFBRkRZZDZPS2RndElCR0xVeWF3N1hRd3VSV0VNNk1BNEdBMVVkRHdFQi93UUVBd0lIZ0RBUUJnb3Foa2lHOTJOa0JnVUJCQUlGQURBTkJna3Foa2lHOXcwQkFRVUZBQU9DQVFFQWVhSlYyVTUxcnhmY3FBQWU1QzIvZkVXOEtVbDRpTzRsTXV0YTdONlh6UDFwWkl6MU5ra0N0SUl3ZXlOajVVUllISytIalJLU1U5UkxndU5sMG5rZnhxT2JpTWNrd1J1ZEtTcTY5Tkluclp5Q0Q2NlI0Szc3bmI5bE1UQUJTU1lsc0t0OG9OdGxoZ1IvMWtqU1NSUWNIa3RzRGNTaVFHS01ka1NscDRBeVhmN3ZuSFBCZTR5Q3dZVjJQcFNOMDRrYm9pSjNwQmx4c0d3Vi9abEwyNk0ydWVZSEtZQ3VYaGRxRnd4VmdtNTJoM29lSk9PdC92WTRFY1FxN2VxSG02bTAzWjliN1BSellNMktHWEhEbU9Nazd2RHBlTVZsTERQU0dZejErVTNzRHhKemViU3BiYUptVDdpbXpVS2ZnZ0VZN3h4ZjRjemZIMHlqNXdOelNHVE92UT09IjsKCSJwdXJjaGFzZS1pbmZvIiA9ICJld29KSW05eWFXZHBibUZzTFhCMWNtTm9ZWE5sTFdSaGRHVXRjSE4wSWlBOUlDSXlNREUxTFRBMUxUSTNJREF6T2pFNE9qUTFJRUZ0WlhKcFkyRXZURzl6WDBGdVoyVnNaWE1pT3dvSkluQjFjbU5vWVhObExXUmhkR1V0YlhNaUlEMGdJakUwTXpJM01qRTVNalF3TURBaU93b0pJblZ1YVhGMVpTMXBaR1Z1ZEdsbWFXVnlJaUE5SUNKRU1VTXpNalEzTXpOQk16QkVRelV6TWtJMk56TkJNREJDT0RZd01FWTBRa00xTWtSRk5VRXpJanNLQ1NKdmNtbG5hVzVoYkMxMGNtRnVjMkZqZEdsdmJpMXBaQ0lnUFNBaU16WXdNREF3TVRJeE16QXhOekV6SWpzS0NTSmxlSEJwY21WekxXUmhkR1VpSUQwZ0lqRTBOalF6TkRRek1qUXdNREFpT3dvSkltRndjQzFwZEdWdExXbGtJaUE5SUNJME56STFOamMxTnpjaU93b0pJblJ5WVc1ellXTjBhVzl1TFdsa0lpQTlJQ0l6TmpBd01EQXhNakV6TURFM01UTWlPd29KSW5GMVlXNTBhWFI1SWlBOUlDSXhJanNLQ1NKM1pXSXRiM0prWlhJdGJHbHVaUzFwZEdWdExXbGtJaUE5SUNJek5qQXdNREF3TURrMk5UWTFOemtpT3dvSkltOXlhV2RwYm1Gc0xYQjFjbU5vWVhObExXUmhkR1V0YlhNaUlEMGdJakUwTXpJM01qRTVNalV3TURBaU93b0pJbVY0Y0dseVpYTXRaR0YwWlMxbWIzSnRZWFIwWldRdGNITjBJaUE5SUNJeU1ERTJMVEExTFRJM0lEQXpPakU0T2pRMElFRnRaWEpwWTJFdlRHOXpYMEZ1WjJWc1pYTWlPd29KSW1sMFpXMHRhV1FpSUQwZ0lqa3lPRFUyTkRVNE1DSTdDZ2tpWlhod2FYSmxjeTFrWVhSbExXWnZjbTFoZEhSbFpDSWdQU0FpTWpBeE5pMHdOUzB5TnlBeE1Eb3hPRG8wTkNCRmRHTXZSMDFVSWpzS0NTSndjbTlrZFdOMExXbGtJaUE5SUNKVlEwaFpTemhFVnk1TVRGaGFJanNLQ1NKd2RYSmphR0Z6WlMxa1lYUmxJaUE5SUNJeU1ERTFMVEExTFRJM0lERXdPakU0T2pRMElFVjBZeTlIVFZRaU93b0pJbTl5YVdkcGJtRnNMWEIxY21Ob1lYTmxMV1JoZEdVaUlEMGdJakl3TVRVdE1EVXRNamNnTVRBNk1UZzZORFVnUlhSakwwZE5WQ0k3Q2draWNIVnlZMmhoYzJVdFpHRjBaUzF3YzNRaUlEMGdJakl3TVRVdE1EVXRNamNnTURNNk1UZzZORFFnUVcxbGNtbGpZUzlNYjNOZlFXNW5aV3hsY3lJN0Nna2lZbWxrSWlBOUlDSmpiMjB1YzNCcGNtbDBZMnhwY0hNdWMyTWlPd29KSW1KMmNuTWlJRDBnSWpFdU1DSTdDbjA9IjsKCSJwb2QiID0gIjM2IjsKCSJzaWduaW5nLXN0YXR1cyIgPSAiMCI7Cn0='
end

Given(/^I fill in input fields with valid credentials for fire tv$/) do
  @http_parameters = {}
  @test_time = Time.now.to_i
  @http_parameters['email_address'] = "spiritclipsqa+#{@test_time}@gmail.com"
  @http_parameters['platform_type'] = 'firetv'
  @http_parameters['device_id'] = '2BB54445-287D-4E0F-A943-D3D7B463BB2F'
  @http_parameters['transaction_id'] = '180000138989082'
  @http_parameters['plan_type'] = 'annual'
  @http_parameters['amazon_uid'] = '99FD_DL23EMhrOGDnur9-ulvqomrSg6qyLPSD3CFE='
  @http_parameters['receipt'] = 'q1YqVrJSSs7P1UvMTazKz9PLTCwoTswtyEktM9JLrShIzCvOzM-LL04tiTdW0lFKASo2NDEwMjCwMDM2MTC0AIqVAsUsLd1c4l18jIxdfTOK_N1d8kqLLHVLc8oK83OLgtPNCit9AoJdjJ3dXG2BGkqUrAxrAQ'
end

Given(/^I initialize the http_parameters for playing a film using email$/) do
  @http_parameters = {}
  @test_time = Time.now.to_i
  @http_parameters['email'] = 'azraqa'
  @http_parameters['filmId'] = '1'
  @http_parameters['position'] = '15'
  @http_parameters['deviceCode'] = '123456'
  @http_parameters['deviceId'] = '145797'
end

Given(/^I invalidate http_parameters "(.*?)"$/) do |k|
  @http_parameters[k] = 'foo'
end

When(/^the client requests POST to "(.*?)"$/) do |url|
  uri = "#{Capybara.app_host}#{url}"
  # http = Net::HTTP.new(uri.host, uri.port)
  request = RestClient.post(uri, @http_parameters)
  # request.set_form_data(@http_parameters)
  # response = http.request(request)
  @response_body = request.body
  @response_code = request.code
  puts "Email: #{@http_parameters['email_address']}"
  puts "url is #{uri}"
  puts @response_body.to_s
  puts @response_code.to_s
end

When(/^the client GETs "(.*?)"$/) do |url|
  # no tests are using this step at the moment
  url = URI.parse("#{Capybara.app_host}#{url}")
  request = Net::HTTP.get(url.to_s)
  @response_body = request.body
  @response_code = request.code
  # response = Net::HTTP.start(url.host, url.port){|http|http.request(req)}
end

Then(/^the response body should be JSON$/) do
  expect(@response_body).to_not be nil
end

Then(/^the json response key "(.*?)" will be "(.*?)"$/) do |key, value|
  if JSON.parse(@response_body)[key].to_s != value
    puts key, value
    raise 'key does not match value'
  end
end

Then(/^the nested json keys "(.*?)" and "(.*?)" will be "(.*?)"$/) do |key, nested_key, value|
  if JSON.parse(@response_body)[key][nested_key].to_s != value
    raise 'key, nested_key does not match value'
  end
end
