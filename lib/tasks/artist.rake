desc "Finding artist by name and fetching his albums"
task :artist, [:name] => :environment do |t, args|
	args.with_defaults(:name => "Abba")

		# search artist by name
	response = HTTParty.get(URI.encode("https://itunes.apple.com/search?term=#{args.name}&entity=musicArtist"))
	data = JSON.parse(response.body)
	results = data["resultCount"]
	if results > 0
		artist_name = data["results"].first["artistName"]
		artist_id = data["results"].first["artistId"]
		if Artist.find_by(itunes_id: artist_id)
			puts "#{artist_name} was already added"
		else
	  		Artist.create(name: artist_name, itunes_id: artist_id)
			albums = HTTParty.get("https://itunes.apple.com/lookup?id=#{artist_id}&entity=album")
			albums = JSON.parse(albums.body)
			albumsCount = albums["resultCount"]
			for num in 1..(albumsCount - 1)
				album_name = albums["results"][num]["collectionName"]
				artwork_url_100 = albums["results"][num]["artworkUrl100"]
				Artist.find_by(itunes_id: artist_id).albums.create(name: album_name, artwork_url_100: artwork_url_100)
			end
			puts "#{artist_name} (#{num} albums) added"
		end
	end

end