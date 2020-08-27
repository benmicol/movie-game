require 'uri'
require 'csv'

class ApplicationController < ActionController::Base
	def index
		@idRow = rand(0..226)
		@id = get_mov(@idRow)		
		@rating = get_info(@id, 'imdbRating')
		@image = get_info(@id, 'Poster')
		@title = get_info(@id, 'Title')
		@year = get_info(@id, 'Year')
		@cast = get_info(@id, 'Actors')
	end
	def get_info(id,item)
		@api = ENV["API_KEY"]
		response = HTTP.get("http://www.omdbapi.com/?apikey=#{@api}&i=#{id}").to_s
		parsed_response = JSON.parse(response)
		parsed_response[item]
	end
	def get_mov(random)
		contents = CSV.parse(File.read("app/assets/CSV/data.csv"), headers: true)
		id_arr = contents.by_col[0]
		mov_id = id_arr[random]
	end
end
=begin
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
		response = HTTP.get("http://www.omdbapi.com/?apikey=efdd29c4&i=#{id}").to_s
		parsed_response = JSON.parse(response)
		parsed_response["imdbRating"]
	end
	def get_image_by_id(id)
		response = HTTP.get("http://www.omdbapi.com/?apikey=efdd29c4&i=#{id}").to_s
		parsed_response = JSON.parse(response)
		parsed_response["Poster"]
	end
	def get_title_by_id(id)
		response = HTTP.get("http://www.omdbapi.com/?apikey=efdd29c4&t=#{id}").to_s
		parsed_response = JSON.parse(response)
		parsed_response["Title"]
	end
	@title = URI.escape(@id)
=end