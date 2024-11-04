require "ncurses"

require "./consts.cr"

files = Dir["**/*"].select { |f| File.file?(f) }
search = ""
matched_files = files.select(/#{Regex.escape(search)}/)
selection = 0

def init_ncurses
	NCurses.start
	NCurses.cbreak
	NCurses.no_echo
	NCurses.set_cursor NCurses::Cursor::Invisible
end

init_ncurses

loop do
	NCurses.clear
	NCurses.print ">#{search}|\n\n"
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
		NCurses.print " #{selection_char} #{item}\n"
	end

	if matched_files.size > max_files
		NCurses.print "   + #{matched_files.size - max_files} more\n"
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
		NCurses.end
		system "#{ENV["EDITOR"]} #{matched_files[selection]}"
		init_ncurses
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
