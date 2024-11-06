def render_file_list(max_files, matched_files, selection)
	matched_files.first(max_files).each_with_index do |item, index|
		selection_indicator = "  "
		if index == selection
			selection_indicator = "~>"
		end
		NCurses.set_color ColorPair::ACCENT2
		NCurses.print " #{selection_indicator}"
		NCurses.set_color ColorPair::ACCENT1
		NCurses.print "#{item.rpartition('/').first}/"
		NCurses.set_color ColorPair::REGULAR
		NCurses.print "#{item.rpartition('/').last}\n"
	end

	if matched_files.size > max_files
		NCurses.set_color ColorPair::REGULAR
		NCurses.print "   + #{matched_files.size - max_files} more\n"
	end
end

def render_legend
	NCurses.print "\n#{" "*7}DOWN "
	NCurses.set_color ColorPair::DARK
	NCurses.print "{"
	NCurses.set_color ColorPair::REGULAR
	NCurses.print "'"
	NCurses.set_color ColorPair::DARK
	NCurses.print "/"
	NCurses.set_color ColorPair::REGULAR
	NCurses.print "#"
	NCurses.set_color ColorPair::DARK
	NCurses.print "}"

	NCurses.set_color ColorPair::INFO
	NCurses.print "#{" "*5}UP "
	NCurses.set_color ColorPair::DARK
	NCurses.print "{"
	NCurses.set_color ColorPair::REGULAR
	NCurses.print "["
	NCurses.set_color ColorPair::DARK
	NCurses.print "/"
	NCurses.set_color ColorPair::REGULAR
	NCurses.print "]"
	NCurses.set_color ColorPair::DARK
	NCurses.print "}"

	NCurses.set_color ColorPair::INFO
	NCurses.print "#{" "*5}CLEAR "
	NCurses.set_color ColorPair::DARK
	NCurses.print "{"
	NCurses.set_color ColorPair::REGULAR
	NCurses.print "="
	NCurses.set_color ColorPair::DARK
	NCurses.print "}"
end
