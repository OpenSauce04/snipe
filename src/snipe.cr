require "ncurses"

require "./consts.cr"

files = Dir["**/*"]
matched_files = [] of String
search = ""

NCurses.start
NCurses.cbreak
NCurses.set_cursor NCurses::Cursor::Invisible

loop do
	NCurses.clear
	NCurses.print ">#{search}|\n"
	NCurses.print "---------------------------\n"
	NCurses.print Dir.current + "/\n"
	matched_files.first(MAX_FILES).each { |item| NCurses.print("   #{item}\n") }
	if matched_files.size > MAX_FILES
		NCurses.print "   + #{matched_files.size - MAX_FILES} more\n"
	end

	input = NCurses.get_char

	case input
	when BACKSPACE
		search = search[0...-1] # Remove last character
	else
		next if !input.to_s.match(/[[:print:]]/)
		search += input.to_s
	end

	matched_files = files.select(/#{Regex.escape(search)}[^\/]*$/)
end
