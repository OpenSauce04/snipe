module ColorPair
	REGULAR = 1
	ACCENT = 2
	ACCENTDARK = 3
	INFO = 4
end

def init_color_pairs
	NCurses.init_color_pair(ColorPair::REGULAR, NCurses::Color::Default, NCurses::Color::Default)
	NCurses.init_color_pair(ColorPair::ACCENT, NCurses::Color::Cyan, NCurses::Color::Default)
	NCurses.init_color_pair(ColorPair::ACCENTDARK, NCurses::Color::Blue, NCurses::Color::Default)
	NCurses.init_color_pair(ColorPair::INFO, NCurses::Color::Yellow, NCurses::Color::Default)
end
