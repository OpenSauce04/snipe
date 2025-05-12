require "ncurses"

require "./consts.cr"
require "./colors.cr"
require "./interface.cr"

files = Dir["**/*"].select { |f| File.file?(f) }
search = ""
matched_files = files.select(/#{Regex.escape(search)}/)
selection = 0

NCurses.start
NCurses.cbreak
NCurses.keypad true
NCurses.no_echo
NCurses.set_cursor NCurses::Cursor::Invisible
NCurses.start_color
NCurses.use_default_colors
init_color_pairs

loop do
    # Draw interface
    NCurses.clear
    NCurses.set_color ColorPair::REGULAR
    NCurses.print "\n🔎 "
    NCurses.print search
    NCurses.with_attribute(NCurses::Attribute::Blink) do
        NCurses.print "|\n\n"
    end

    NCurses.set_color ColorPair::ACCENTDARK
    NCurses.with_attribute(NCurses::Attribute::Bold) do
        NCurses.print Dir.current + "/\n"
    end

    max_files = NCurses.max_y - 7

    selection = [0, selection].max
    selection = [selection, max_files-1].min
    selection = [selection, matched_files.size-1].min

    render_file_list(max_files, matched_files, selection)

    # Move cursor to consistent position at bottom of terminal
    NCurses.print "\n" * ([0, max_files+1 - matched_files.size].max + 1)

    render_legend

    # Get input
    input = NCurses.get_char

    # Process input
    case input
    when NCurses::Key::Up
        selection -= 1
        next
    when NCurses::Key::Down
        selection += 1
        next
    when 10 # TODO: Represents the Enter key; See https://github.com/SamualLB/ncurses/issues/24
        NCurses.end
        selected_file = matched_files[selection]
        system "wl-copy #{selected_file}"
        puts "Copied to clipboard:\n#{selected_file}"
        exit
    when NCurses::Key::Backspace, KEY_BS # Some terminals output a BS control character when the backspace is pressed
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
