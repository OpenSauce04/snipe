def render_file_list(max_files, matched_files, selection)
	matched_files.first(max_files).each_with_index do |item, index|
		selection_char = " "
		if index == selection
			selection_char = "*"
		end
		NCurses.set_color 4
		NCurses.print " #{selection_char} "
		NCurses.set_color 3
		NCurses.print "#{item.rpartition('/').first}/"
		NCurses.set_color 1
		NCurses.print "#{item.rpartition('/').last}\n"
	end

	if matched_files.size > max_files
		NCurses.set_color 1
		NCurses.print "   + #{matched_files.size - max_files} more\n"
	end
end

def render_legend
	NCurses.print "\n#{" "*7}DOWN "
	NCurses.set_color 2
	NCurses.print "{"
	NCurses.set_color 1
	NCurses.print "'"
	NCurses.set_color 2
	NCurses.print "/"
	NCurses.set_color 1
	NCurses.print "#"
	NCurses.set_color 2
	NCurses.print "}"

	NCurses.set_color 5
	NCurses.print "#{" "*5}UP "
	NCurses.set_color 2
	NCurses.print "{"
	NCurses.set_color 1
	NCurses.print "["
	NCurses.set_color 2
	NCurses.print "/"
	NCurses.set_color 1
	NCurses.print "]"
	NCurses.set_color 2
	NCurses.print "}"

	NCurses.set_color 5
	NCurses.print "#{" "*5}CLEAR "
	NCurses.set_color 2
	NCurses.print "{"
	NCurses.set_color 1
	NCurses.print "="
	NCurses.set_color 2
	NCurses.print "}"
end
