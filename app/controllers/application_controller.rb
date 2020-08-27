require 'uri'
require 'csv'

class ApplicationController < ActionController::Base
	def index
		
		@id = rand(0..77)
		@raw_title = get_mov(@id)
		@title = URI.escape(@raw_title)
		@rating = get_rating_by_title(@title)
		@image = get_image_by_title(@title)
	end
	def get_rating_by_title(title)
		response = HTTP.get("http://www.omdbapi.com/?apikey=efdd29c4&t=#{title}").to_s
		parsed_response = JSON.parse(response)
		parsed_response["imdbRating"]
	end
	def get_image_by_title(title)
		response = HTTP.get("http://www.omdbapi.com/?apikey=efdd29c4&t=#{title}").to_s
		parsed_response = JSON.parse(response)
		parsed_response["Poster"]
	end
	def get_rating_by_id(id)
		response = HTTP.get("http://www.omdbapi.com/?apikey=efdd29c4&i=tt#{id}").to_s
		parsed_response = JSON.parse(response)
		parsed_response["imdbRating"]
	end
	def get_image_by_id(id)
		response = HTTP.get("http://www.omdbapi.com/?apikey=efdd29c4&t=tt#{id}").to_s
		parsed_response = JSON.parse(response)
		parsed_response["Poster"]
	end
	def get_title_by_id(id)
		response = HTTP.get("http://www.omdbapi.com/?apikey=efdd29c4&t=tt#{id}").to_s
		parsed_response = JSON.parse(response)
		parsed_response["Title"]
	end
	def get_mov(random)
		contents = CSV.parse(File.read("app/assets/CSV/movies.csv"), headers: true)
		title_arr = contents.by_col[0]
		mov_title = title_arr[random]
	end
end
