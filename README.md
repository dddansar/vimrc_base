# vimrc_simple

This is a simplified version of my vimrc_full repo without all the extra clutter that don't apply for most users.

- Removed spell checking/autocorrect related files and syntax groups
- Removed Unicode and math Vim files
- Removed plugins such as claude.vim, vim-characterize, vim-autocorrect, vim-you-autocorrect
- Removed niche files and settings


## Features

- Works in GVim, Vim and NeoVim
- Supports Windows and Linux OS
- Supports Colemak-DH and QWERTY keyboard layouts
- Uses a custom colorscheme fully controlled by the user
- Supports different syntax configurations
- Can select between Vim's syntax matching, or add custom syntax matching on top of the Vim's syntax matching (default), or completely override Vim's syntax matching
- Contains custom syntax library files that can add custom syntax matching to any filetype in addition to filetype specific customizations
- Contains font and GUI customizations
- Adds font styles such as bold, underline, italic, colors, strikethrough and other combinations
- Displays the name of the syntax group being applied under the cursor
- Includes performance optimization features and multiple performance modes
- Includes custom mappings and abbreviations
- Improved search and replace functionality with mappings

## Vim Files and Folder Contents
```
.vimrc                          # Main vimrc settings and mappings
.vim/
├── colors/                     # Contains custom colorschemes
├── lib/                        # Contains generic functions, abbreviations, mappings, highlights, syntax and include files
│   ├── abbrev.vim              # Common abbreviations and shortcuts
│   ├── more_colors.vim         # Adds additional highlighting groups and colors
│   ├── regex.vim               # Regular expression custom syntax highlighting
│   └── syntax_library.vim      # Library of syntax highlighting functions for use in all filetypes
├── pack/
│   └── colorschemes/start/ddd_colorschemes/    # Contains my ddd_colorschemes
├── syntax/
│   ├── custom_syntax.vim       # Loads the custom syntax highlighting groups based on file extension
│   ├── lean.vim                # Lean math prover custom syntax highlighting
│   └── text.vim                # Plain text custom syntax highlighting
├── thesaurus/
│   └── abbrevlist.txt          # Abbreviations list from all files for thesaurus lookup
└── after/
    ├── ftplugin/
    │   └── qf.vim              # Quickfix window statusline override
    └── syntax/
        ├── asm.vim             # Assembly custom syntax highlighting
        ├── c.vim               # C/C++ custom syntax highlighting
        ├── csh.vim             # C shell custom syntax highlighting
        ├── java.vim            # Java custom syntax highlighting
        ├── javascript.vim      # JavaScript custom syntax highlighting
        ├── json.vim            # JSON custom syntax highlighting
        ├── lua.vim             # Lua custom syntax highlighting
        ├── markdown.vim        # Markdown custom syntax highlighting
        ├── netrw.vim           # File browser custom syntax highlighting
        ├── perl.vim            # Perl custom syntax highlighting
        ├── plaintex.vim        # Plain TeX custom syntax highlighting
        ├── python.vim          # Python custom syntax highlighting
        ├── qf.vim              # Quickfix window custom syntax highlighting
        ├── sh.vim              # Bash/shell custom syntax highlighting
        ├── svn.vim             # SVN custom syntax highlighting
        ├── tcl.vim             # TCL custom syntax highlighting
        ├── tex.vim             # LaTeX custom syntax highlighting
        ├── verilog.vim         # Verilog and SystemVerilog custom syntax highlighting
        ├── vhdl.vim            # VHDL custom syntax highlighting
        └── vim.vim             # Vim custom syntax highlighting
```

## Getting Started

To use, first install GVim, Vim or NeoVim on Linux or Windows (GVim being my main editor), and then place the .vim files in the appropriate location.
- For Linux, place the .vimrc file and the .vim/ folder in ~/ (aka $HOME/ or /home/username/) then open any file with GVim and the settings should all be loaded.
- For Windows, place the .vimrc file and the .vim/ folder under C:\Users\username\ (but rename the .vim folder to vimfiles in Windows) then open any file with GVim and the settings should all be loaded.


## NeoVim

NeoVim uses different configuration directories than Vim. You can get all the vimrc settings to work in NeoVim by 1) placing the files in the proper NeoVim directories and loading the Vim settings through the init.lua file or option 2) by linking NeoVim to Vim's .vimrc and .vim/ in Linux.


### Option 2) Linking NeoVim to Vim

Option 2) Linking NeoVim to Vim, can depend on the specific locations that NeoVim uses in your OS. Below is what works for me in Ubuntu/Mint Linux.

Link Vim's .vimrc and .vim/ subfolders in NeoVim.
```bash.
ln -s ~/.vim/after      ~/.config/nvim/after
ln -s ~/.vim/colors     ~/.config/nvim/colors
ln -s ~/.vim/lib        ~/.config/nvim/lib
ln -s ~/.vim/pack       ~/.config/nvim/pack
ln -s ~/.vim/plugin     ~/.config/nvim/plugin
ln -s ~/.vim/spell      ~/.config/nvim/spell
ln -s ~/.vim/syntax     ~/.config/nvim/syntax
ln -s ~/.vim/thesaurus  ~/.config/nvim/thesaurus
```

And add to ~/.config/nvim/init.lua
```lua
-- Source existing vimrc for shared config
vim.cmd('source ~/.vimrc')
```

Now when I open a file with NeoVim, it gets the same settings as when I load the file with GVim.


## Custom Colorscheme

The Vim files contains my own independent custom colorscheme files found in ~/.vim/pack/colorschemes/start/ddd_colorschemes/colors/. The colorschemes are written in a clear, easy to understand and easy to modify format.

The colorschemes are independent from the rest of the files and settings. If you want to enable the custom colorschemes without bringing in any of the other files, simply add a colors/ folder in the appropriate location (usually in your .vim/ path), copy over the colorscheme files into the colors/ folder, and then load the colorscheme into your .vimrc file.

You can do so by adding the following line to your .vimrc file:

```vim
colorscheme ddd_black
```

If you are using NeoVim instead of Vim/GVim, then add the ddd_black.vim file to the equivalent path (~/.config/nvim/colors/ in Linux) and add one of the following to your init.lua file:

```lua
vim.cmd.colorscheme("ddd_black")
" vim.cmd("colorscheme ddd_black") " Also works
" vim.cmd[[colorscheme ddd_black]] " Also works
```

Make sure you don't have any other colorschemes enabled overriding the custom colorscheme.

### Comparison with/without my custom syntax matching.

Both images below use my ddd_black.vim file. The image on the left shows the default syntax matching and the image on the right adds my custom syntax matching on top.

For vim files:

![Alt Text](https://raw.githubusercontent.com/dddansar/vimrc/assets/vimrc_example.png)

For C files:

![Alt Text](https://raw.githubusercontent.com/dddansar/vimrc/assets/c_example.png)

### More Colorschemes

For a complete list of other colorschemes I have available, check out:
https://github.com/dddansar/colorschemes

