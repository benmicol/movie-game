class ImdbService
	def get_rating_by_title(title)
		response = HTTP.get("http://www.omdbapi.com/?apikey=efdd29c4&t=#{title}").to_s
		parsed_response = JSON.parse(response)
		parsed_response("imdbRating")
	end
	def get_image_by_title(title)
		response = HTTP.get("http://www.omdbapi.com/?apikey=efdd29c4&t=#{title}").to_s
		parsed_response = JSON.parse(response)
		parsed_response("Poster")
	end
end