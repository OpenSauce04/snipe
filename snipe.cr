MAX_FILES = 20

files = Dir["**/*"]

loop do
	search = gets || ""
	next if search.empty?

	matched_files = files.select(/#{Regex.escape(search)}[^\/]*$/)
	matched_files.first(MAX_FILES).each { |item| puts item }
	if matched_files.size > MAX_FILES
		puts "+ #{matched_files.size - MAX_FILES} more"
	end
end
