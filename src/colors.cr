module ColorPair
	REGULAR = 1
	DARK = 2
	ACCENT1 = 3
	ACCENT2 = 4
	INFO = 5
end

def init_color_pairs
	NCurses.init_color_pair(ColorPair::REGULAR, 15, NCurses::Color::Default)
	NCurses.init_color_pair(ColorPair::DARK, 8, NCurses::Color::Default)
	NCurses.init_color_pair(ColorPair::ACCENT1, 14, NCurses::Color::Default)
	NCurses.init_color_pair(ColorPair::ACCENT2, 13, NCurses::Color::Default)
	NCurses.init_color_pair(ColorPair::INFO, 11, NCurses::Color::Default)
end
