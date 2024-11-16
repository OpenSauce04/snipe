# Snipe
A simple-to-use command-line file finder and editor launcher

## What is this?
Snipe is a file finder designed to be used as part of a command-line development environment for repeatedly searching for and opening code files in a project's code tree.

To search for a file, run `snipe` to open the search interface and type in the name of the file you want to open.

When a file is selected with the Enter key, it is immediately opened using the executable defined in your `EDITOR` environment variable, and when the editor is closed, you are returned to the search interface.

This way, Snipe is always available at a moment's notice by closing the currently open file, making jumping between many different files quick and seamless.

## How does seaching work/ How does it differ from fuzzy finders?
Unlike existing "fuzzy finder" tools, Snipe doesn't use a fuzzy finding algorithm.

When processing a search query, Snipe doesn't match any text before the final directory seperator (/). This way, directory names are not included in the results unless they are explicitly stated.

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

## Why does this exist?
This project came from a desire to explore alternative methods of programming after deciding that I wanted to move away from using VSCode.

While looking at the available options I discovered the [Micro](https://github.com/zyedidia/micro) editor, and while the editor itself was functionally appealing, I realized that needing to type out the full path of each code file I wanted to open was slow.

I tried out a few existing finder programs, but wasn't able to find any that behaved the way I wanted them to. Naturally I then took the typical programmer approach of spending hours of my time creating tool that saves a few seconds.

This likely won't be part of my main workflow going forwards as I will inevitably end up using Vim or Emacs or something, but writing this was fun regardless!

## Building from source
1. Install the [Crystal](https://crystal-lang.org/) programming language
2. Clone this respository
3. Run `shards install` to install library dependencies
4. Run `make build` to build the program
5. The final executable will be built at `build/snipe`
