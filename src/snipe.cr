require "ncurses"

require "./consts.cr"
require "./interface.cr"

files = Dir["**/*"].select { |f| File.file?(f) }
search = ""
matched_files = files.select(/#{Regex.escape(search)}/)
selection = 0

NCurses.start
NCurses.cbreak
NCurses.no_echo
NCurses.set_cursor NCurses::Cursor::Invisible
NCurses.start_color
NCurses.use_default_colors
# TODO: These should probably be customizable
NCurses.init_color_pair(1, 15, NCurses::Color::Default)
NCurses.init_color_pair(2, 8, NCurses::Color::Default)
NCurses.init_color_pair(3, 14, NCurses::Color::Default)
NCurses.init_color_pair(4, 13, NCurses::Color::Default)
NCurses.init_color_pair(5, 11, NCurses::Color::Default)


loop do
	# Draw interface
	NCurses.clear
	NCurses.set_color 1
	NCurses.print "\n"
	NCurses.print ">#{search}|\n\n"
	NCurses.set_color 2
	NCurses.print Dir.current + "/\n"

	max_files = NCurses.max_y - 7

	selection = [0, selection].max
	selection = [selection, max_files-1].min
	selection = [selection, matched_files.size-1].min

	render_file_list(max_files, matched_files, selection)

	# Move cursor to consistent position at bottom of terminal
	NCurses.set_color 5
	NCurses.print "\n" * [0, max_files+1 - matched_files.size].max

	render_legend

	# Get input
	input = NCurses.get_char

	# Process input
	case input
	when '[', ']'
		selection -= 1
		next
	when '\'', '#'
		selection += 1
		next
	when KEY_ENTER
		NCurses.end
		system "#{ENV["EDITOR"]} #{matched_files[selection]}"
		NCurses.start
		next
	when KEY_BACKSPACE
		search = search[0...-1] # Remove last character
	when '='
		search = ""
	else
		next if !input.to_s.match(/[[:print:]]/)
		search += input.to_s
	end

	# Update search results
	matched_files = files.select(/#{Regex.escape(search)}[^\/]*$/)
	selection = 0
end
