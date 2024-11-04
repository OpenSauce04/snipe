require "ncurses"

require "./consts.cr"

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
NCurses.init_color_pair(1, 247, NCurses::Color::Default)
NCurses.init_color_pair(2, 244, NCurses::Color::Default)
NCurses.init_color_pair(3, 14, NCurses::Color::Default)


loop do
	# Draw interface
	NCurses.clear
	NCurses.set_color
	NCurses.print "\n"
	NCurses.print ">#{search}|\n\n"
	NCurses.set_color 1
	NCurses.print Dir.current + "/\n"

	max_files = NCurses.max_y - 7

	selection = [0, selection].max
	selection = [selection, max_files-1].min
	selection = [selection, matched_files.size-1].min

	matched_files.first(max_files).each_with_index do |item, index|
		selection_char = " "
		if index == selection
			selection_char = "*"
		end
		NCurses.set_color 3
		NCurses.print " #{selection_char} "
		NCurses.set_color 2
		NCurses.print "#{item.rpartition('/').first}/"
		NCurses.set_color
		NCurses.print "#{item.rpartition('/').last}\n"
	end

	if matched_files.size > max_files
		NCurses.set_color 3
		NCurses.print "   + #{matched_files.size - max_files} more\n"
	end

	# Get input
	input = NCurses.get_char

	# Process input
	case input
	when ']' # TODO: Make navigation keyboard-layout-agnostic
		selection -= 1
		next
	when '#'
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
