#require 'uri'
require 'csv'

class ApplicationController < ActionController::Base
	def index
		@idRow = rand(0..226)
		@id = get_mov(@idRow)		
		@image = get_info(@id, 'Poster')
		@title = get_info(@id, 'Title')
		@year = get_info(@id, 'Year')
		@cast = get_info(@id, 'Actors')
		start = rand(1..3)
		@ratingCheck = get_info(@id, 'imdbRating')
		@rating = ''
		@rating1 = ''
		@rating2 = ''
		ratingArr = 6.0.step(by: 0.1, to: 9.5).to_a
		avail = ratingArr.select {|x| x < (@ratingCheck.to_f - 0.2) || x > (@ratingCheck.to_f + 0.2) }
		avail2 = avail.select {|x| x > (@ratingCheck.to_f - 1.0) && x < (@ratingCheck.to_f + 1.0)}
		arrRand = rand(0..avail2.length)
		seed1 = avail2[rand(0..avail2.length-1)]
		avail3 = avail2 - [seed1]
		seed2 = avail3[rand(0..avail3.length-1)]
		if start == 1
			@rating = @ratingCheck
			@rating1 = seed1
			@rating2 = seed2
		elsif start == 2
			@rating1 = @ratingCheck
			@rating = seed1
			@rating2 = seed2
		else
			@rating2 = @ratingCheck
			@rating = seed1
			@rating1 = seed2
		end
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