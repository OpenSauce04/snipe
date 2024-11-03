require "ncurses"

require "./consts.cr"

files = Dir["**/*"]
matched_files = [] of String
search = ""
selection = 0

NCurses.start
NCurses.cbreak
NCurses.no_echo
NCurses.set_cursor NCurses::Cursor::Invisible

loop do
	NCurses.clear
	NCurses.print ">#{search}|\n"
	NCurses.print "---------------------------\n"
	NCurses.print Dir.current + "/\n"

	selection = [0, selection].max
	selection = [selection, MAX_FILES-1].min
	selection = [selection, matched_files.size-1].min

	matched_files.first(MAX_FILES).each_with_index do |item, index|
		selection_char = " "
		if index == selection
			selection_char = "*"
		end
		NCurses.print " #{selection_char} #{item}\n"
	end

	if matched_files.size > MAX_FILES
		NCurses.print "   + #{matched_files.size - MAX_FILES} more\n"
	end

	input = NCurses.get_char

	case input
	when ']' # TODO: Make navigation keyboard-layout-agnostic
		selection -= 1
		next
	when '#'
		selection += 1
		next
	when KEY_ENTER
		system "#{ENV["EDITOR"]} #{matched_files[selection]}"
		next
	when KEY_BACKSPACE
		search = search[0...-1] # Remove last character
	else
		next if !input.to_s.match(/[[:print:]]/)
		search += input.to_s
	end

	matched_files = files.select(/#{Regex.escape(search)}[^\/]*$/)
	selection = 0
end
