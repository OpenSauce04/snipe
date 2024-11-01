files = Dir["**/*"]

loop do
	search = gets || ""
	next if search.empty?

	matched_files = files.select(/#{Regex.escape(search)}[^\/]*$/)
	puts matched_files
end
