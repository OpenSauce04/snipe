def render_file_list(max_files, matched_files, selection)
	matched_files.first(max_files).each_with_index do |item, index|
		style = if index == selection
		          NCurses::Attribute::Reverse
		        else
		          NCurses::Attribute::Normal
		        end
		NCurses.print "  "
		NCurses.with_attribute(style) do
			NCurses.set_color ColorPair::ACCENT
			NCurses.print "#{item.rpartition('/').first}/"
			NCurses.set_color ColorPair::REGULAR
			NCurses.print "#{item.rpartition('/').last}\n"
		end
	end

	if matched_files.size > max_files
		NCurses.set_color ColorPair::REGULAR
		NCurses.print "   + #{matched_files.size - max_files} more\n"
	end
end

def render_legend
	NCurses.print " "
	NCurses.with_attribute(NCurses::Attribute::Underline) do
		NCurses.set_color ColorPair::INFO
		NCurses.with_attribute(NCurses::Attribute::Bold) do
			NCurses.print "="
		end
		NCurses.set_color ColorPair::REGULAR
		NCurses.with_attribute(NCurses::Attribute::Dim) do
			NCurses.print " Clear"
		end
	end
end
