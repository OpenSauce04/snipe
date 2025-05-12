# Snipe
A simple-to-use command-line file finder

## What is this?
Snipe is a file finder designed to be used as part of a development environment to search for and opening files in a project's source tree.

To search for a file, `cd` into a project directory and run `snipe` to open the search interface, then type in the name of the file you want to open. If necessary navigate to the file using the arrow keys, and then select the file with the enter key.

Optionally, a relative path can be provided as a command line parameter (e.g. `snipe ../src`), and that path will be used as the root for searching files instead of the current directory. Currently, only paths relative to the current directory are supported, meaning absolute paths will not work.

Once the file has been selected, its filename relative to the project directory is copied to the clipboard and printed to the terminal. This copied path can then be used elsewhere, such as within Emacs's `find-file`.

## How does searching work/ How does it differ from fuzzy finders?
Unlike existing "fuzzy finder" tools, Snipe doesn't use a fuzzy finding algorithm.

When processing a search query, Snipe doesn't match any text before the final directory separator (/). This way, directory names are not included in the results unless they are explicitly stated.

For example, say there is a file in the location `foo/bar/baz.txt`. This table demonstrates whether the following queries will find the file:

✅ `foo/bar/baz.txt` \
✅ `bar/baz.txt` \
✅ `baz.txt` \
✅ `baz` \
❌ `foo/bar` \
✅ `foo/bar/` \
❌ `foo/` \
✅ `bar/` \
❌ `bar`

## Requirements

- This program only supports Wayland sessions
- `wl-clipboard` must be installed

## Building from source
1. Ensure that the above requirements are met
2. Install the [Crystal](https://crystal-lang.org/) programming language
3. Clone this repository
4. Run `shards install` to install library dependencies
5. Run `make release` or `make debug` to build the program
6. Once built, the final executable will be located at `bin/snipe`
