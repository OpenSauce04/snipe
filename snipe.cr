MAX_FILES = 20
CLEAR_SCREEN = "\e[H\e[2J"

files = Dir["**/*"]

print CLEAR_SCREEN

loop do
	puts Dir.current
	print ">"
	search = gets || ""
	print CLEAR_SCREEN
	next if search.empty?

	matched_files = files.select(/#{Regex.escape(search)}[^\/]*$/)
	matched_files.first(MAX_FILES).each { |item| puts item }
	if matched_files.size > MAX_FILES
		puts "+ #{matched_files.size - MAX_FILES} more"
	end
end
