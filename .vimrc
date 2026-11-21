"==============================================================================
" File: .vimrc
"------------------------------------------------------------------------------
" Description: Settings loaded when opening any file with Vim/GVim/NeoVim.
"------------------------------------------------------------------------------
" Author: Danny Sarraf
"------------------------------------------------------------------------------
" URL: https://github.com/dddansar/vimrc
"------------------------------------------------------------------------------
" Copyright: MIT License
"
" Copyright (c) 2026 Danny Sarraf
"
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to deal
" in the Software without restriction, including without limitation the rights
" to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
" copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
"
" The above copyright notice and this permission notice shall be included in
" all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
" OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
" SOFTWARE.
"==============================================================================


"------------------------------------------------------------------------------
" 1. Global Variables
"------------------------------------------------------------------------------

" Selects between windows and linux OS
if has("win32") || has("win64")
    let g:using_windows = 1
else
    let g:using_windows = 0
endif

" Some systems do not support CTRL-SHIFT or ALT-SHIFT...
let g:ctrl_shift_enabled = 0

" Enable autocorrect
" let g:use_autocorrect = 1

" Set the <leader> key to space
let mapleader="\<space>"

" This is used to load large files faster by not loading vimrc settings.
" File is large if over 500MB.
let g:LargeFile = 1024 * 1024 * 500

" Disable generation of the .netrwhist file when opening a folder
let g:netrw_dirhistmax = 0

" In $VIMRUNTIME/syntax/vim.vim don't load python/perl/lua scripts if set to 0.
let g:vimsyn_embed = 0

" Set gvimdiff to wrap text.
let g:wrap_gvimdiff=0

" /d Performance mode y/
" Will turn off additional settings and syntax matching if set to 1 or 2.
let g:performance_mode = 0

" Path to key Vim folders
if g:using_windows
   if !has('nvim')
      let $vim_folder_path  = '$HOME/vimfiles'
   else
      let $vim_folder_path  = '$HOME/AppData/Local/nvim'
   endif
else " For Linux
   if !has('nvim')
      let $vim_folder_path  = '$HOME/.vim'
   else
      let $vim_folder_path  = '$HOME/.vim'
    " let $nvim_folder_path = '$HOME/.config/nvim'
   endif
endif

" NOTE: You can open multiple splits/tabs from terminal!!!
" gvim -o *.sv   horizontal split all files
" gvim -O *.sv   vertical split all files
" gvim -p *.sv   tabs all files

" NOTE: Link NeoVim to Vim's .vimrc and .vim/ in linux!
" Link the .vimrc file in NeoVim.
" ln -s ~/.vimrc ~/.config/nvim/init.vim
" Link various .vim/ subfolders in NeoVim.
" ln -s ~/.vim/after ~/.config/nvim/after
" ln -s ~/.vim/colors ~/.config/nvim/colors
" ln -s ~/.vim/lib ~/.config/nvim/lib
" ln -s ~/.vim/pack ~/.config/nvim/pack
" ln -s ~/.vim/plugin ~/.config/nvim/plugin
" ln -s ~/.vim/spell ~/.config/nvim/spell
" ln -s ~/.vim/syntax ~/.config/nvim/syntax
" ln -s ~/.vim/thesaurus ~/.config/nvim/thesaurus


"------------------------------------------------------------------------------
" 2. Functions
"------------------------------------------------------------------------------

"------------------------------------------------------------------------------
" Function: CommonSettings()
" Description: These options and commands set the font, the background, the
"              colorscheme, the dimensions of the Vim window, and the mappings.
"------------------------------------------------------------------------------
function! CommonSettings()
   let g:EnteredCommonSetting = 1

   if exists("g:debug_syntax")
      echom "Entered CommonSettings()"
   endif

   "---------------------------------------------------------------------------
   " Enable syntax highlighting
   "---------------------------------------------------------------------------
   syntax enable


   "---------------------------------------------------------------------------
   " NOTE: Need to set colorscheme after syntax on or highlight groups defined
   "       before 'syntax on' may be partially reset.
   " /d Load colorscheme y/ before checking file size in the MainFunction augroup to
   " avoid a white flash when first opening new files.
   "---------------------------------------------------------------------------
   call LoadColorscheme()


   "---------------------------------------------------------------------------
   " Set the font and set the dimensions of the Vim window
   "---------------------------------------------------------------------------
   if has("gui_running")
      " Selects between windows and linux OS
      " NOTE: use ":set guifont=(tab)" to cycle through the list of fonts.
      if g:using_windows
         if !has('nvim')
            set guifont=Consolas:h15:cANSI
         else " For NeoVim
            set guifont=Consolas:h15:cANSI
         endif
         set lines=46
         set columns=140

      else " For Linux
         if !has('nvim')
            set guifont=Monospace\ 15
         " winpos 1000 0         " Open GVim in top right by default
         else " for NeoVim
            set guifont=Monospace:h15
         endif
         set lines=39
         set columns=120
      endif
   endif

   " Display line numbers on the left.
   set number

   "---------------------------------------------------------------------------
   " Load all Mappings
   "---------------------------------------------------------------------------
   call LoadMappings()

endfunction


"------------------------------------------------------------------------------
" Function: LoadColorscheme()
" Description: Loads the selected colorscheme.
"------------------------------------------------------------------------------
function! LoadColorscheme()
   if exists("g:debug_syntax")
      echom "Entered LoadColorscheme()"
   endif
   colorscheme ddd_black
   " Use one of the default colorschemes
   " colorscheme pablo
endfunction


"------------------------------------------------------------------------------
" Function: DefaultSettings()
" Description: Loads the default settings, mappings and syntax files
"------------------------------------------------------------------------------
function! DefaultSettings()
   if exists("g:debug_syntax")
      echom "Entered DefaultSettings()"
   endif
   let g:EnteredDefaultSetting = 1

   "---------------------------------------------------------------------------
   " Set 'nocompatible' to ward off unexpected things that your distro might
   " have made, as well as sanely reset options when re-sourcing .vimrc.
   set nocompatible

   " Attempt to determine the type of a file based on its name and possibly
   " its contents.  Use this to allow intelligent auto-indenting for each
   " filetype, and for plugins that are filetype specific.
   filetype indent plugin on

   " Enable title if titlestring is set
   set title
   " Show only filename in the titlebar
   " set titlestring=%t
   " Show relative path
   " set titlestring=%f
   " Show filename + modified flag
   if &titlestring ==# ''
      set titlestring=%t\ %m
   endif

   "---------------------------------------------------------------------------
   " Allows you to switch from an unsaved buffer without saving it first.
   " Also allows you to keep an undo history for multiple files.
   " Vim will complain if you try to quit without saving, and swap files
   " will keep you safe if your computer crashes.
   set hidden

   " Command-line completion when pressing tab to autocomplete.
   set wildmenu
   set wildmode=full
   " set wildmode=longest,full

   " Show partial commands in the last line of the screen.
   set showcmd

   " Highlight searches.
   set hlsearch

   " Highlight searches as you type.
   set incsearch

   "---------------------------------------------------------------------------
   " Use case insensitive search, except when using capital letters.
   set ignorecase
   set smartcase

   " Allow backspacing over autoindent, line breaks, and start of insert.
   " action.
   set backspace=indent,eol,start

   " When entering a new line and no filetype-specific indenting is enabled,
   " keep the same indentation as the line you're currently on.
   set autoindent
   " smartindent in Vim is an indentation option that provides automatic
   " indentation when starting a new line.
   " 'cindent' does something like this, works better in most cases, but is
   " more strict,  When 'cindent' is on or 'indentexpr' is set, setting
   " 'smartindent' has no effect. See |C-indenting|.
   " Normally 'autoindent' should also be on when using 'smartindent'.
   " An indent is automatically inserted:
   " - After a line ending in '{'.
   " - After a line starting with a keyword from 'cinwords'.
   " - Before a line starting with '}' (only with the "O" command).
   " When typing '}' as the first character in a new line, that line is
   " given the same indent as the matching '{'. When using the ">>" command,
   " lines starting with '#' are not shifted right.
   " WARNING: smartindent makes it so I can't use >> on lines that start
   " with # !!
   " set smartindent
   " Need to set this or I can't use >> on lines that start with # !!
   " but this also make Vim indent c style with { parenthesis }.
   " See |C-indenting|.
   " NOTE: Changing this may affect multiline abbreviations...
   " Set based on filetype? -> some of my .vim files will override this...
   set cindent
   set cinkeys-=0#

   " Stop certain movements from going to the first character of a line.
   " While this behaviour deviates from that of Vi, it does what most users
   " coming from other editors would expect. It changes the default behavior
   " of various navigation commands to keep the cursor in the same column
   " rather than moving it to the first non-blank character of the
   " destination line.
   set nostartofline

   " Display the cursor position on the last line of the screen or in the
   " status line of a window.
   set ruler

   " Always display the status line (showing file name and path), even if
   " only one window is displayed.
   set laststatus=2

   " statusline: sets the text in the status line bar under the file.
   " statusline refreshes on cursor movement, mode changes (insert → normal, etc.)
   " buffer changes (edits, saves), window focus changes, any command execution.
   " %n: buffer number, %f: file path, %t: file name only %h: help buffer
   " flag, %=: creates sections %m: modified flag," \ : add space, %p: line
   " percentage, %r: display read only [RO], %v display current column number,
   " %l: display current line number, %L: display total line numbers.
   set statusline=%f%m%r
   " set statusline+=\ \ \ %{g:status_line_var}
   " set statusline+=\ \ \ %{SynGroup()}
   " set statusline+=\ \ \ %{SynStackGroup()}
   set statusline+=\ \ \ %{SynStackCached()}
   " set statusline+=%=%p%%\ %l/%L:%v\ %t
   set statusline+=%=\ %l/%L:%v\ %p%%
   augroup SynStackIdle
      autocmd!
      autocmd CursorHold  * let g:syn_stack = SynStackGroup()
   augroup END

   " The update time for cursor hold
   " set updatetime=500
   set updatetime=200

   " Turn on blinking cursor in NeoVim
   if has('nvim')
      set guicursor+=a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
   end

   " Turn off cursor blinking.
   " set guicursor+=a:blinkon0

   " Instead of failing a command because of unsaved changes, instead raise
   " a dialogue asking if you wish to save changed files.
   set confirm

   " Use visual bell instead of beeping when doing something wrong.
   set visualbell

   " Enable use of the mouse for all modes.
   set mouse=a
   set mousemodel=popup

   " Yank/copy to clipboard like in windows.
   " set clipboard^=unnamedplus "append += does not word if an item has
   " exclude, but prepend ^= will work.
   set clipboard=unnamedplus

   " Hide mouse when typing - hidden by default.
   " set mousehide
   " set nomousehide

   " Set the command window height (where commands such as / and : are typed).
   set cmdheight=1

   " lastline: When included, as much as possible of the last line
   " in a window will be displayed. When not included, a last line
   " that doesn't fit is replaced with "@" lines.
   set display=lastline

   " If set, then line numbers above or below are numbered relatively to the
   " current line ...,3,2,1 for lines above and 1,2,3,... for lines below
   " instead of their actual line number.
   " set relativenumber

   " Quickly time out on keycodes, but never time out on mappings.
   set notimeout ttimeout ttimeoutlen=100

   " If this is here, will not auto-comment by default. This may get overriden
   " by filetype plugins therefore using an autogroup instead.
   " set formatoptions-=cro
   augroup format_options
      autocmd!
      autocmd FileType * setlocal formatoptions-=cro
   augroup END

   "---------------------------------------------------------------------------
   " Use 3 spaces instead of tabs. Converts tab to spaces.
   set expandtab
   " Automatically indent after new line ex if inside function.
   set shiftwidth=3
   " How many spaces a tab is worth.
   set tabstop=3
   " With shiftround, > and < rounds indentation to the next/previous multiple
   set shiftround

   " Indents word-wrapped lines as much as the 'parent' line.
   set breakindent
   set breakindentopt=min:40
   " set breakindentopt=shift:2,min:40

   " Turn on line-wrapping (text loops around if not enough space).
   set wrap
   " Vim will wrap lines at white spaces if possible.
   set linebreak

   " Automatically enter a new line after X characters (0 means never).
   set textwidth=0

   " In GVim, 'guioptions' controls whether various GUI widgets are shown.
   " Below means left/bottom scroll bar disabled, right scroll bar enabled.
   " Default: aegimrLtT
   if !has('nvim')
      set guioptions=aegimrt
   endif
   " Remove the toolbar menu (icon bar) in GVim.
   " set guioptions-=T

   " Will highlight spelling mistakes in all file types if set
   " I set this in txt.vim as I don't want it enabled in most file types.
   " set nospell
   " set spell spelllang=en_us
   " Ignore uppercase of first word.
   " set spellcapcheck=

   " When you turn on spell checking, tell Vim to not check the spelling of
   " text that is not explicitly covered by a syntax item.
   " syntax spell notoplevel

   " Prevents the cursor from going within the top or bottom x lines of the
   " screen and will readjust the screen to show a min of x lines below or
   " above the cursor.
   set scrolloff=2

   " Automatically reloads file if it was changed in another window.
   set autoread

   " Disable swap files (used to restore changes made to buffer in case of
   " crash and to avoid multiple instances of the file being open) (since I
   " save almost all the time, crashes do not affect me as much...).
   " Disabling swapfiles is done to remove the ".swp" files cluttering
   " project directories and to avoid constant prompts when opening files.
   set noswapfile

   " Do not access the menu items with ALT anymore, ALT is also used to
   " access some specific characters such as è that is mapped to a-h. I also
   " map other ALT shortcuts below.
   set winaltkeys=no

   " Enable delcombine to remove combining characters (like U+0336 aka
   " strikethrough) on their own without deleting the underlying character.
   set delcombine

   " Add the abbreviation list to the thesaurus to look them up as you type
   " with <c-x><c-t> or <c-n> or <c-p>.
   if filereadable(expand($vim_folder_path . "/thesaurus/abbrevlist.txt"))
      set thesaurus+=$vim_folder_path/thesaurus/abbrevlist.txt
   endif

   " When this option is set, the screen will not be redrawn while executing
   " macros, registers and other commands that have not been typed. Speeds
   " up macros significantly!!!
   " WARNING: Messes with some mappings like ones that rely on the linux
   " selection buffer to copy and paste contents! But there are workarounds.
   set lazyredraw

   " Search down into subfolders when using the :find command.
   " set path+=**
   " default path=.,/usr/include,, however /usr/include/ can take too long
   " to search and slow down autocompletion.
   set path=.,**
   " Then you can use :find file_name.txt and it will open the file, you can
   " even tab and it will complete the name and cycle through all matches
   " even if in different folders.
   " :find file_ (tab) (finds files and folders.)
   " :find test_*.* (tab) (also works, finds just files no folders.)
   " :find *word*.* (tab) (finds file with the word in it)

   " Autocomplete lists that will be used when typing <c-n> in insert mode.
   " .: Scan the current buffer.
   " w: Scan buffers in other windows.
   " b: Scan loaded buffers from the buffer list.
   " u: Scan unloaded buffers that are in the buffer list.
   " t: Scan tag files (requires generating a tags file with ctags).
   " i: Scan the current and included files (uses your path and include
   "    settings).
   " set complete=.,w,b,u,t,i     " Default
   " s: Scan the thesaurus (I added all my abbreviations in there!).
   " k: Scan dictionary files. (adds too many entries, so keeping this
   "    separate) (see autocomplete mappings further below).
   " set complete=.,w,b,u,t,i,s
   set complete+=s
   " Use the autocomplete menu even if there is only one match.
   set completeopt=menu,preview,menuone

   " netrw file browser (can be opened with :E).
   " Disable banner
   let g:netrw_banner=0
   " Tree view (expands/collapses folder in same window).
   let g:netrw_liststyle=3

   " NOTE: ctags in a terminal will create a tags file for current folder and
   " all it's subfolders.
   "    ctags -R .
   " c-]  To jump to tag under the cursor! (jumps to the definition of the
   "      function even if in a different file!).
   " gc-] For ambiguous tags (select btw multiple tags with the same name).
   " c-t  To jump up the tag stack.

   " Set a line at column 80 to help encourage keeping the text under 80
   " characters per line.
   " set cc=80

   " Maximum column per line before disabling syntax highlighting.
   " set synmaxcol can limit highlighting very long lines
   " syn sync minlines (or syn sync fromstart) limits how far back
   " Vim re-parses. See ":syntax sync" for current values
   if g:performance_mode > 0
      set synmaxcol=1000
   else
      set maxmempattern=5000
   endif
   " syn sync minlines=1

   " Select which Vim regex engine to use
   " set regexpengine=1

   " Disable modelines to avoid potential security issues...
   set nomodeline

   " Remove the dashes "----------..." from the gvimdiff filler lines.
   set fillchars+=diff:\ " Fill with space instead

   " NOTE: For improved Unicode ga command use:
   " git clone https://github.com/tpope/vim-characterize ~/.vim/pack/plugins/start/vim-characterize

   " joinspaces inserts two spaces after '.', '?' and '!' with a join command
   " nojoinspaces does not insert these 2 spaces. nojoinspaces fixes the double
   " space after period case, but not trailing whitespace on the current line.
   set nojoinspaces

   "---------------------------------------------------------------------------
   " Some non GUI settings
   "---------------------------------------------------------------------------
   if !has("gui_running")
      " Changes cursor shape in visual/insert mode.
      let &t_SI = "\e[6 q"
      let &t_SR = "\e[4 q"
      let &t_EI = "\e[2 q"

      " Enable true color support
      if has('termguicolors') && $COLORTERM =~# 'truecolor\|24bit'
        set termguicolors
      endif
      " set t_Co=256
   endif


   "---------------------------------------------------------------------------
   " /d Load autocorrect files y/
   " vim-autocorrect plugin: panozzaj/vim-autocorrect ships a pre-built list
   " of corrections. Install or download, then enable with call AutoCorrect().
   " NOTE: Vim auto-loads anything under .vim/pack/*/start/.
   " To download you can use:
   " git clone https://github.com/panozzaj/vim-autocorrect.git ~/.vim/pack/plugins/start/vim-autocorrect
   " There are also many other autocorrect plugins.
   "---------------------------------------------------------------------------
   " if !exists("g:AutocorrectLoaded") && g:use_autocorrect
   "    if exists('*AutoCorrect')
   "       call AutoCorrect()
   "    endif
   "    let g:AutocorrectLoaded = 1
   " endif


   "---------------------------------------------------------------------------
   " NOTE: This file is responsible for /d loading additional options r/ based on
   " the file extension/filetype
   "---------------------------------------------------------------------------
   if !exists("b:filetype_settings_loaded")
      source $vim_folder_path/lib/filetype_settings.vim
   end


   "---------------------------------------------------------------------------
   " Always load file at last known cursor position
   "---------------------------------------------------------------------------
   augroup RestoreCursor
      autocmd!
      if g:performance_mode <= 1
         autocmd BufReadPost *
            \ let g:line = line("'\"")
            \ | if g:line >= 1
            \      && g:line <= line("$") && &filetype !~# 'commit'
            \      && index(['xxd', 'gitrebase', 'tutor', 'svn', 'netrw', 'diff', 'fugitive', 'oil'], &filetype) == -1
            \      && expand("%") !~# '\(svn-commit\|/tmp/\|fugitive://\)'
            \ |    execute "normal! g`\""
            \ |    if len(getbufinfo({'buflisted': 1})) == 1
            \ |       execute "redraw!"
            \ |    endif
            \ | endif
      endif
   augroup END

   "---------------------------------------------------------------------------
   " Automatically Resize splits whenever a new split is opened or closed.
   "---------------------------------------------------------------------------
   " Whenever a window is open in multi-splits, maximize the active window.
   augroup MaximizeAfterOpen
      autocmd!
      " WinEnter will prevent keeping 2 splits equal length for comparison.
      " autocmd WinEnter * wincmd _ | exe "wincmd |"
      autocmd WinNew * if &buftype == '' | wincmd _ | exe "wincmd |" | endif
   augroup END

   " Whenever a window is closed in multi-splits, maximize the active window.
   augroup MaximizeAfterClose
      autocmd!
      " WinClosed fires just before the window is removed, so wincmd _
      " maximizes the window that's about to disappear -> need timer_start()
      " autocmd WinClosed * wincmd _ | wincmd |
      autocmd WinClosed * call timer_start(0, {-> execute('wincmd _ | wincmd |')})
   augroup END

   "---------------------------------------------------------------------------
   " Set gvimdiff to wrap by default.
   "---------------------------------------------------------------------------
   if has("gui_running") && !has('nvim') && g:wrap_gvimdiff
      augroup VimDiff
         autocmd!
         autocmd VimEnter * call IfDiff()
      augroup END
   endif

endfunction

function! IfDiff()
   if &diff
      windo set wrap
      set columns=9999
      wincmd =
   endif
endfunction

"------------------------------------------------------------------------------
" Function: LoadMappings()
" Description: /d Loads all mappings y/
"------------------------------------------------------------------------------
" remap vs noremap:
" remap is an option that makes mappings work recursively.
"
" :map and :noremap are recursive and non-recursive versions of the various
" mapping commands. What that means is that if you do:
"     :map j gg
"     :map Q j
"     :noremap W j
"
" j will be mapped to gg. Q will also be mapped to gg, because j will be
" expanded for the recursive mapping. W will be mapped to j (and not to gg)
" because j will not be expanded for the non-recursive mapping.
" WARNING: You can create infinite recursive mappings if you map the same key!
"
" Other variations include:
"     :map/noremap: Normal, Visual, Select, Operator-pending modes.
"     :map!/noremap!: Insert and Command-line modes.
"     :nmap/nnoremap: Normal mode only.
"     :vmap/vnoremap: Visual and Select modes only.
"        :xmap/xnoremap: Visual mode only (not Select mode).
"        :smap/snoremap: Select mode only (not Visual mode).
"     :omap/onoremap: Operator-pending mode only.
"     :imap/inoremap: Insert mode only.
"     :cmap/cnoremap: Command-line mode only.
"------------------------------------------------------------------------------
function! LoadMappings()

   "---------------------------------------------------------------------------
   " /d Make Vim similar to windows g/ (save, copy, paste, select, ...)
   "---------------------------------------------------------------------------

   " Update jump list with m' on cut, copy and paste (you can use <c-o>
   " and <c-i> to jump to past locations). NOTE: GVim requires an extra
   " <c-o> to do the first jump but NeoVim does not seem to require it...
   if g:using_windows
      " <c-c> to copy and <c-x> to paste using "set clipboard".
      nnoremap yy m'V"+y$
      vnoremap y "+ym'
      nnoremap p "+gp<a-bs>m'
      vnoremap p "+gpgv"+yy<esc>m'
      nnoremap d m'd
      vnoremap d dm'
      vnoremap <s-p> p
   else " For Linux
      nnoremap y m'y
      vnoremap y ym'
      nnoremap p pm'
      vnoremap p pgvym'
      nnoremap d m'd
      vnoremap d dm'
      vnoremap <s-p> p
   endif

   " Paste last selected without using mouse.
   " cnoremap <a-p>   <middlemouse>
   " nnoremap <a-p>   a<middlemouse><esc>
   " <c-r>* inserts the * register  (primary selection on Linux, the clipboard
   " on Windows) on the command line without the need for <middlemouse>.
   cnoremap <a-p> <c-r>*
   nnoremap <a-p> a<c-r><c-r>*<esc>
   if g:ctrl_shift_enabled
      " Paste after last char in line.
      nnoremap <c-s-p> $pm'
   endif

   " Select all in file.
   nnoremap <a-a> ggVG
   vnoremap <a-a> <esc>ggVG

   " Use CTRL-S for saving, also in Insert mode.
   nnoremap <silent> <c-s> :update<cr>
   " vnoremap <silent> <c-s> <esc>:update<cr>
   vnoremap <silent> <c-s> <cmd>update<cr>
   " inoremap <silent> <c-s> <esc>:update<cr>gi
   inoremap <silent> <c-s> <cmd>update<cr>

   " Map backspace to delete like in windows.
   nnoremap <bs> i<bs><right><esc>
   vnoremap <bs> <del>
   nnoremap <del> i<del><right><esc>

   " Set and unset line wrap.
   nnoremap <silent><a-q> :set wrap!<cr>


   "---------------------------------------------------------------------------
   " /d Tab, enter, whitespace mappings g/
   "---------------------------------------------------------------------------

   " Insert newline with enter without entering insert mode.
   nnoremap <expr> <cr> (index(['quickfix','help','terminal'], &buftype) >= 0 \|\| !empty(getcmdwintype())) ? "<cr>" : "o<esc>"
   nnoremap <s-cr> O<esc>

   " WARNING: c-i and tab get the same mapping.
   " NOTE: Make tab and space work the same for visual and block visual
   "       mode, let it shift all lines equally.
   " Inserts spaces/tabs on empty lines
   " NOTE: shiftround only rounds indentation in "v" mode not "V" mode...
   " > and < lose the visual selection once applied, reapply with gv.

   " Make tabs and spaces shift all lines equally in visual mode.
   vnoremap <expr> <tab> getpos('v')[2] > 1 && getpos('.')[2] > 1
         \ ? (mode() =~# '[vV]' ? "<c-v><s-i><tab>" : "<s-i><tab>")
         \ : (mode() =~# '[vV]' ? ">gv" : ">gv")
   vnoremap <expr> <s-tab> mode() ==# "v" \|\| mode() ==# 'V' ? "<c-v><gv" : "<gv"
   vnoremap > >gv
   vnoremap < <gv
   vnoremap <expr> <leader><space> mode() ==# "v" ? "<c-v><s-i><space>" : "<s-i><space>"


   "---------------------------------------------------------------------------
   " /d Movement related mappings g/
   "---------------------------------------------------------------------------

   " Toggle / uppercase / capitalize / lowercase word under cursor.
   nnoremap <c-`> viw~

   " Append next line to end of current line.
   " See help :join   - J without g will insert up to 2 spaces (variable).
   " NOTE: keeppatterns is an Ex command modifier that prevents your search
   "       history and the last search pattern register (/) from being
   "       updated when executing a command
   nnoremap <a-j> :keeppatterns s/\s*\n\s*/ /<cr>
   " NOTE: Set nojoinspaces to not insert 2 spaces after . ? and ! with a
   " join command. But if the line starts with ), <s-j> inserts no spaces.
   vnoremap <a-j> <s-j>


   "---------------------------------------------------------------------------
   " /u Autocorrect related mappings g/
   "---------------------------------------------------------------------------

   " Go to next/prev spell error.
   nnoremap gH [s
   nnoremap gL ]s

   " Fix next/prev spell error.
   noremap gh [sz=1<cr><cr>
   noremap gl ]sz=1<cr><cr>

   " Open a spelling suggestion drop down
   noremap zl [sEa<c-x>s
   noremap zh ]sEa<c-x>s
   " Autocorrect word to first match.
   nnoremap gz z=1<cr><cr>


   "---------------------------------------------------------------------------
   " /d Search related mappings g/
   "---------------------------------------------------------------------------

   " Search for characters selected.
   " Using escape({string}, {chars}) to escape the yanked text inside @", this
   " allows the search to also work on / and \ characters.
   " <a-backspace> moves the cursor left even if on the previous line.
   " substitute({string},'\n','\\n','g') allows searches over multiple lines
   " substitute({string}, {pattern}, {replacement}, {flags})
   "    {string}: the text to operate on.
   "    '\n': matches a newline character (the ^@ you see in the command line).
   "    '\\n': the replacement is the two characters \n.
   "    'g': replace all matches, not just the first.
   " /<up> starts a search then uses the previous search patern.
   " vnoremap /     y<a-backspace>/\V\c<c-r>=escape(@",'/\')<cr><cr>

   " Search for characters selected.
   vnoremap /       y<a-backspace>/\V\c<c-r>=substitute(escape(@",'/\'),'\n','\\n','g')<cr><cr>
   nnoremap <c-/> yiw<a-backspace>/\V\c<c-r>=substitute(escape(@",'/\'),'\n','\\n','g')<cr><cr>
   vnoremap <c-8>   y<a-backspace>/\V\c\<<c-r>=substitute(escape(@",'/\'),'\n','\\n','g')<cr>\><cr>
   nnoremap <c-8> yiw<a-backspace>/\V\c\<<c-r>=substitute(escape(@",'/\'),'\n','\\n','g')<cr>\><cr>
   " Add another word to the existing search.
   vnoremap ?       y<a-backspace>/<up>\\|<c-r>=substitute(escape(@",'/\'),'\n','\\n','g')<cr><cr>
   nnoremap ?     yiw<a-backspace>/<up>\\|<c-r>=substitute(escape(@",'/\'),'\n','\\n','g')<cr><cr>
   vnoremap *       y<a-backspace>/<up>\\|\<<c-r>=substitute(escape(@",'/\'),'\n','\\n','g')<cr>\><cr>
   nnoremap *     yiw<a-backspace>/<up>\\|\<<c-r>=substitute(escape(@",'/\'),'\n','\\n','g')<cr>\><cr>
   " Search for selection yanked as is, useful for regex.
   vnoremap <c-/>   y/<c-r>"<cr>
   " Add another <c-/> to the existing search.
   if g:ctrl_shift_enabled
      vnoremap <c-s-?> y/<up><c-r>"<cr>
   endif

   " Search for item under cursor with a mouse.
   nnoremap <c-leftmouse>  <leftmouse>yiw<a-backspace>/\V\c<c-r>=substitute(escape(@",'/\'),'\n','\\n','g')<cr><cr>
   nnoremap <c-rightmouse> <leftmouse>yiw<a-backspace>/\V\c\<<c-r>=substitute(escape(@",'/\'),'\n','\\n','g')<cr>\><cr>
   nnoremap <s-leftmouse>  <leftmouse>yiw<a-backspace>/<up>\\|<c-r>=substitute(escape(@",'/\'),'\n','\\n','g')<cr><cr>
   nnoremap <s-rightmouse> <leftmouse>yiw<a-backspace>/<up>\\|\<<c-r>=substitute(escape(@",'/\'),'\n','\\n','g')<cr>\><cr>


   " Search in multiple split-windows. Type m to continue the search in
   " next file. NOTE" \<lt> maps to <
   nnoremap <silent> m :exe (search(@/, 'nW') == 0 ?  "normal! \<lt>c-w>\<lt>c-w>\<lt>c-w>\<lt>bar>\<lt>c-w>_Gn" : "normal! nzz")<cr>
   nnoremap <silent> M :exe (search(@/, 'bnW') == 0 ?  "normal! \<lt>c-w>\<lt>s-w>\<lt>c-w>\<lt>bar>\<lt>c-w>_gg$N" : "normal! Nzz")<cr>
   " Remap ALT-m to marks instead of m that got overridden above.
   nnoremap <a-m> m


   " Search and replace.
   " NOTE: gc will ask for confirmation after each replace.
   "       % starts from top of the file.
   "       .,$ to start from current line to end of file.
   "       |1,''-&& to repeat from first line to cursor line minus one.
   " Using escape({string}, {chars}) to escape the yanked text inside @", this
   " allows the search to also work on / and \ characters in the search
   " side and on &, ~, / and \ in replacement side.
   " Replace selected, asking for confirmation each match.
   nnoremap <leader>rn yiw:.,$s/\V\C<c-r>=escape(@",'/\')<cr>/<c-r>=escape(@",'/\&~')<cr>/gc\|1,''-&&
   vnoremap <leader>rn y:.,$s/\V\C<c-r>=escape(@",'/\')<cr>/<c-r>=escape(@",'/\&~')<cr>/gc\|1,''-&&
   " Replace selected, \<exact match\>, asking for confirmation each match.
   nnoremap <leader>re yiw:.,$s/\V\C\<<c-r>=escape(@",'/\')<cr>\>/<c-r>=escape(@",'/\&~')<cr>/gc\|1,''-&&
   vnoremap <leader>re y:.,$s/\V\C\<<c-r>=escape(@",'/\')<cr>\>/<c-r>=escape(@",'/\&~')<cr>/gc\|1,''-&&
   " Replace selected, ALL matches, no confirmation.
   nnoremap <leader>ra m'yiw:%s/\V\C<c-r>=escape(@",'/\')<cr>/<c-r>=escape(@",'/\&~')<cr>/g<left><left>
   vnoremap <leader>ra <esc>m'gvy:%s/\V\C<c-r>=escape(@",'/\')<cr>/<c-r>=escape(@",'/\&~')<cr>/g<left><left>
   " Replace selected, \<exact match\>, ALL matches, no confirmation.
   nnoremap <leader>rr m'yiw:%s/\V\C\<<c-r>=escape(@",'/\')<cr>\>/<c-r>=escape(@",'/\&~')<cr>/g<left><left>
   vnoremap <leader>rr <esc>m'gvy:%s/\V\C\<<c-r>=escape(@",'/\')<cr>\>/<c-r>=escape(@",'/\&~')<cr>/g<left><left>


   " Search for CamelCase.
   nnoremap <leader>sC /\(\<\u\l\+\\|\l\+\)\(\u\)<cr>
   " Convert each NameLikeThis to name_like_this in current line.
   nnoremap <leader>r1c :keeppatterns s#\(\<\u\l\+\\|\l\+\)\(\u\)#\l\1_\l\2#g<cr>
   " Convert each NameLikeThis to name_like_this in current file.
   nnoremap <leader>rc m':keeppatterns %s#\(\<\u\l\+\\|\l\+\)\(\u\)#\l\1_\l\2#g<cr><c-o>
   " Convert each name_like_this to NameLikeThis in current line.
   nnoremap <leader>r1C :keeppatterns s#\(\%(\<\l\+\)\%(_\)\@=\)\\|_\(\l\)#\u\1\2#g<cr>
   " Convert each name_like_this to NameLikeThis in current file.
   nnoremap <leader>rC m':keeppatterns %s#\(\%(\<\l\+\)\%(_\)\@=\)\\|_\(\l\)#\u\1\2#g<cr><c-o>


   "---------------------------------------------------------------------------
   " /d Switching/recentering window positioning mappings g/
   "---------------------------------------------------------------------------

   " Move btw split screens.
   nnoremap <c-j> $<c-w>j<c-w><bar><c-w>_0zz
   nnoremap <c-k> $<c-w>k<c-w><bar><c-w>_0zz
   " NOTE" \<lt> maps to <
   nnoremap <silent> <c-l> :exe "normal! \<lt>c-w>\<lt>c-w>\<lt>c-w>\<lt>bar>\<lt>c-w>_zz"<cr>
   nnoremap <silent> <c-h> :exe "normal! \<lt>c-w>\<lt>s-w>\<lt>c-w>\<lt>bar>\<lt>c-w>_zz"<cr>


   " Terminal mode: Exit terminal mode first, then move between splits
   tnoremap <c-j>    <c-\><c-n>$<c-w>j<c-w><bar><c-w>_
   tnoremap <c-k>    <c-\><c-n>$<c-w>k<c-w><bar><c-w>_
   tnoremap <silent> <c-l> <c-\><c-n>:exe "normal! \<lt>c-w>\<lt>c-w>\<lt>c-w>\<lt>bar>\<lt>c-w>_"<cr>
   tnoremap <silent> <c-h> <c-\><c-n>:exe "normal! \<lt>c-w>\<lt>s-w>\<lt>c-w>\<lt>bar>\<lt>c-w>_"<cr>

   " Same "move btw split screens" as above but using the arrow keys.
   nnoremap <c-down> $<c-w>j<c-w><bar><c-w>_0zz
   nnoremap <c-up>   $<c-w>k<c-w><bar><c-w>_0zz
   nnoremap <silent> <c-right> :exe "normal! \<lt>c-w>\<lt>c-w>\<lt>c-w>\<lt>bar>\<lt>c-w>_zz"<cr>
   nnoremap <silent> <c-left>  :exe "normal! \<lt>c-w>\<lt>s-w>\<lt>c-w>\<lt>bar>\<lt>c-w>_zz"<cr>

   " In multi-split windows, will full-size current file.
   nnoremap <c-space> <c-w><bar><c-w>_zz


   " Zoom in/out.
   nnoremap <c-middlemouse> :LargerFont<cr>
   nnoremap <s-middlemouse> :SmallerFont<cr>
   nnoremap <leader>zi :LargerFont<cr>
   nnoremap <leader>zo :SmallerFont<cr>


   "---------------------------------------------------------------------------
   " /d Useful scripts mappings g/
   "---------------------------------------------------------------------------

   " Commenting blocks of code.
   " <c-b> moves to the beginning of the line in command line mode.
   " <c-e> moves to the end       of the line in command line mode.
   " <c-r> This is the insert mode command to insert the contents of a
   "       register.
   " =     This specifies the expression register.
   " _o_   in visual mode will start from first non white space on first and
   "       last line.
   " NOTE: Align at the block's minimum indent and skip empty lines.
   function! s:CommentBlock(text) range
      let l:lines = filter(range(a:firstline, a:lastline), 'getline(v:val) =~ "\\S"')
      let l:col = min(map(copy(l:lines), 'indent(v:val)'))
      for l:n in l:lines
         let l:line = getline(l:n)
         call setline(l:n, strpart(l:line, 0, l:col) . b:comment_leader . ' ' . a:text . strpart(l:line, l:col))
      endfor
   endfunction
   vnoremap <silent> gc :call <SID>CommentBlock('')<cr>
   vnoremap <silent> gp :call <SID>CommentBlock('NOTE: ')<cr>
   vnoremap <silent> gt :call <SID>CommentBlock('TODO: ')<cr>
   " Commenting in normal mode.
   nnoremap <silent> <expr> gc "_i<c-r>=b:comment_leader<cr> <esc>"
   nnoremap <silent> <expr> gp "_i<c-r>=b:comment_leader<cr> NOTE: <esc>"
   nnoremap <silent> <expr> gt "_i<c-r>=b:comment_leader<cr> TODO: <esc>"
   " Comment all lines including empty lines starting from the first column.
   " NOTE: :<c-u> clears the auto-inserted '<,'>.
   vnoremap <silent> g1 :<c-u>execute "'<,'>normal! 0i" . b:comment_leader . " "<bar>keeppatterns '<,'>s/\s\+$//e<cr>
   vnoremap <silent> g2 :<c-u>execute "'<,'>normal! 0i" . b:comment_leader . " TODO: "<bar>keeppatterns '<,'>s/\s\+$//e<cr>
   vnoremap <silent> g3 :<c-u>execute "'<,'>normal! 0i" . b:comment_leader . " NOTE: "<bar>keeppatterns '<,'>s/\s\+$//e<cr>
   " Remove comments and extra space.
   vnoremap <silent> <expr> gs mode() ==# "v" ? "<c-v>_o_f <del>" : mode() ==# "V" ? "<c-v>_o_f <del>" : "_o_f <del>"
   vnoremap <silent> <expr> gb mode() ==# "v" ? "<c-v>_o_f f <del>" : mode() ==# "V" ? "<c-v>_o_f f <del>" : "_o_f f <del>"
   nnoremap <silent> <expr> gs "_vf <del>"
   nnoremap <silent> <expr> gb "_vf f <del>"


   " Load help for word under cursor.
   " <c-r><c-w> pastes word under cursor into command line!
   nnoremap <leader>fh :help <c-r><c-w><cr><c-w>_:setlocal nospell<cr>


   " m' will update the jump list with the current line.
   " :%s/search_term/replace_term/g means search and replace all lines.
   " g means substitute all matches.
   " % matches entire file.
   " \< matches start of a word.
   " \U tells Vim to uppercase the following character in the substitution
   "    string (&).
   " & means substitute whatever was matched on the left hand side.
   " \(A\|B\) means match a group of alternatives, aka match A or B.
   " ^ matches after a newline.
   " [.?!] \+ means after a terminal punctuation and one or more spaces.
   " <cr> means enter, aka execute previous command.
   " keeppatterns prevents the search history from being updated
   " <c-o> will jump back through the jump list. The first jump will jump
   "       to the current line where we set the last jump list. The last 2
   "       <c-o> jumps will jump back to before the search and replaces to
   "       the first jump list that we set, aka will jump back to the
   "       initial line.

   " Capitalize all words after punctuations and newlines in the entire file.
   " 1st line matches lowercase after a new line or punctuations
   " 2nd line matches lowercase after bullet point style lines like  - abc
   " 3rd line matches lowercase after Titlecase labels like Title:
   " 4rd line matches lowercase after labels like (a), A), (-), and 1)
   nnoremap <leader>fc m':keeppatterns %s/\(^\s*["']\?\s*\\|[A-Z]:\s*\\|[.?!]\s\+\\|[/][/]\s*\)[a-z]\%()\)\@!/\U&/ge<cr>
                        \:keeppatterns %s/\(^\s*\([/][/]\s*\)\?[*+-]\s\+\)[a-z]\%()\)\@!/\U&/ge<cr>
                        \:keeppatterns %s/\(^\s*-\?\s*[A-Z][a-z-]\+\( [&/]\\|[ /-](\?[A-Z][a-z-]\+)\?\)*:\s*\)\@<=[a-z]/\U&/ge<cr>
                        \:keeppatterns %s/\(^\s*\([/][/]\s*\)\?[(]\?\([0-9]\+\\|[a-zA-Z*+-]\)[)]\s*\)\@<=[a-z]/\U&/ge<cr><c-o><c-o><c-o>
   " Capitalize all words after punctuations and newlines on the current line.
   nnoremap <leader>ff mz:keeppatterns s/\(^\s*["']\?\s*\\|[A-Z]:\s*\\|[.?!]\s\+\\|[/][/]\s*\)[a-z]\%()\)\@!/\U&/ge<cr>
                        \:keeppatterns s/\(^\s*\([/][/]\s*\)\?[*+-]\s\+\)[a-z]\%()\)\@!/\U&/ge<cr>
                        \:keeppatterns s/\(^\s*-\?\s*[A-Z][a-z-]\+\( [&/]\\|[ /-](\?[A-Z][a-z-]\+)\?\)*:\s*\)\@<=[a-z]/\U&/ge<cr>
                        \:keeppatterns s/\(^\s*\([/][/]\s*\)\?[(]\?\([0-9]\+\\|[a-zA-Z*+-]\)[)]\s*\)\@<=[a-z]/\U&/ge<cr>`z
   " Capitalize all words after punctuation and newlines in visual selection.
   " NOTE: :<c-u> clears the auto-inserted '<,'>.
   vnoremap <leader>ff :<c-u>keeppatterns '<,'>s/\(^\s*["']\?\s*\\|[A-Z]:\s*\\|[.?!]\s\+\\|[/][/]\s*\)[a-z]\%()\)\@!/\U&/ge<cr>
                      \:<c-u>keeppatterns '<,'>s/\(^\s*\([/][/]\s*\)\?[*+-]\s\+\)[a-z]\%()\)\@!/\U&/ge<cr>
                      \:<c-u>keeppatterns '<,'>s/\(^\s*-\?\s*[A-Z][a-z-]\+\( [&/]\\|[ /-](\?[A-Z][a-z-]\+)\?\)*:\s*\)\@<=[a-z]/\U&/ge<cr>
                      \:<c-u>keeppatterns '<,'>s/\(^\s*\([/][/]\s*\)\?[(]\?\([0-9]\+\\|[a-zA-Z*+-]\)[)]\s*\)\@<=[a-z]/\U&/ge<cr>

   " Capitalize first letter of every word on the current line (Title Case).
   nnoremap <leader>ft :keeppatterns s/\(\w'\)\@<!\<[a-z]/\u&/g<cr>
   " Capitalize first letter of every word on the selected lines (Title Case).
   vnoremap <leader>ft :<c-u>keeppatterns '<,'>s/\(\w'\)\@<!\<[a-z]/\u&/g<cr>
   " Capitalize first letter of every word on every line in the file.
   nnoremap <leader>fT m':keeppatterns %s/\<[a-z]/\u&/g<cr><c-o>
   " Capitalize first letter of every word before a : on the current line
   nnoremap <leader>f: mz:keeppatterns s/\v^[^:]*:/\=substitute(submatch(0), '\<\w', '\u&', 'g')/<cr>`z


   " Remove extra spacing - Remove unwanted trailing white space.
   nnoremap <leader>f<space> m':keeppatterns %s/\%(\s\\| \)\+$//e<cr><c-o>
   " Replace all tabs with spaces according to tabstop setting.
   nnoremap <leader>f<tab> :retab<cr>
   " Every space gets it's own column in visual mode.
   "  -o ' ' : tells column to use a single space (instead of the default 2)
   " since :!command calls external command, you can get more info with man.
   vnoremap <leader>f<space> :%!column -t -o ' '<cr>
   " Every | gets it's own column in visual mode.
   vnoremap <leader>f\| :!column -t -s '\|' -o '\|'<cr>
   " Every tab (but not space) gets it's own column in visual mode.
   vnoremap <leader>f<tab> :%!column -t -s $'	'<cr>


   " Sort selected lines.
   vnoremap <leader>fs  :%!sort<cr>
   " Sort all lines in the file.
   nnoremap <leader>fs  :%sort<cr>
   " Sort and unique selected lines.
   vnoremap <leader>fS :%!sort\|uniq<cr>
   " Sort and unique all lines in the file.
   nnoremap <leader>fS :%sort u<cr>


   " Re-source .vimrc file without reloading file, then update all windows.
   nnoremap <silent> <leader>fg :let g:_w = winnr() \| unlet! g:EnteredDefaultSetting g:EnteredSmallFile g:AutocorrectLoaded g:EnteredCommonSetting g:EnteredLargeFile \| execute 'windo unlet! b:syntax_library_loaded b:current_syntax' \| syntax clear \| source $MYVIMRC \| execute 'windo e' \| execute g:_w . 'wincmd w' \| wincmd _ \| wincmd \|<cr>
   " Reload only syntax matching
   nnoremap <silent>  <leader>fm :unlet! b:syntax_library_loaded b:regex_loaded b:current_syntax \| syntax clear \| let &l:syntax = &l:filetype<cr>


   " Fix window after opening a split screen.
   " nnoremap <leader>sp  :sp<cr><c-w><bar><c-w>_
   " nnoremap <leader>vsp :vsp<cr><c-w><bar><c-w>_
   " Opposite of sp and vsp.
 " nnoremap <leader>sd  :set<space>splitbelow<cr>:sp<cr><c-w><bar><c-w>_:set<space>nosplitbelow<cr>
   nnoremap <leader>sb  :set<space>splitbelow<cr>:sp<cr><c-w><bar><c-w>_:set<space>nosplitbelow<cr>
   nnoremap <leader>rsp :set<space>splitright<cr>:vsp<cr><c-w><bar><c-w>_:set<space>nosplitright<cr>
   " topleft botright
   nnoremap <leader>tsp :topleft<space>split<cr><c-w><bar><c-w>_
   nnoremap <leader>bsp :botright<space>split<cr><c-w><bar><c-w>_

endfunction


"------------------------------------------------------------------------------
" Function: AdjustFontSize(amount)
" Description: /d Zooms in or zooms out y/ a specific amount.
"------------------------------------------------------------------------------
" Functions for the zoom in/out.
function! AdjustFontSize(amount)
   if !has("gui_running") | return | endif
   let l:font = &guifont
   if l:font =~ ':h[0-9]\+$'
      let l:newsize = str2nr(matchstr(l:font, ':h\zs[0-9]\+')) + a:amount
      let &guifont = substitute(l:font, ':h[0-9]\+', ':h' . l:newsize, '')
   elseif l:font =~ ' [0-9]\+$'
      let l:newsize = str2nr(matchstr(l:font, ' \zs[0-9]\+$')) + a:amount
      let &guifont = substitute(l:font, ' [0-9]\+$', ' ' . l:newsize, '')
   endif
endfunction

function! LargerFont()
   call AdjustFontSize(1)
endfunction
command! LargerFont call LargerFont()

function! SmallerFont()
   call AdjustFontSize(-1)
endfunction
command! SmallerFont call SmallerFont()


"------------------------------------------------------------------------------
" Function: Eatchar()
" Description: Use to /d consume the space typed after an abbreviation g/:
"              Add  <c-r>=Eatchar('\s')<cr>  at end of abbreviation.
"------------------------------------------------------------------------------
" See :helpgrep Eatchar
"------------------------------------------------------------------------------
function! Eatchar(pat)
   let c = nr2char(getchar(0))
   return (c =~ a:pat) ? '' : c
endfun


"------------------------------------------------------------------------------
" Function: SynGroup()
" Description: /d Displays the name of the syntax group y/ that is being applied
"              under the cursor. Helps you debug which syntax group is giving
"              you issues.
"------------------------------------------------------------------------------
function! SynGroup()
   " synID({lnum}, {col}, {trans})
   " l:synID gives you the syntax group's number under the cursor.
   " When {trans} is set to 0, the syntax group's number is returned, even if
   " transparent. When {trans} is 1, any transparent groups are reduced to the
   " underlying syntax group.
   let l:synID = synID(line('.'), col('.'), 0)
   " let l:transID = synID(line('.'), col('.'), 1)
   " if l:transFlag is 1, the syntax group under the cursor is transparent.
   let l:transFlag = (l:synID != 0 && l:synID == synIDtrans(l:synID)) ? 1 : 0
   " Returns the names of the syntax and highlight groups under the cursor, and
   " also prints 1 if the syntax group under the cursor is transparent.
   " synIDtrans() follows the syntax links to get the highlight group number.
   " Then synIDattr() returns the group name associated with the numbers.
   return synIDattr(l:synID, 'name') . ' ' . synIDattr(synIDtrans(l:synID), 'name') . ' ' . l:transFlag
endfunction
" Similar to SynGroup() but returns all syntax group names under the cursor.
function! SynStackGroup()
   " synstack() return a list of all the syntax group numbers under the cursor.
   let l:stack = synstack(line('.'), col('.'))
   return join(map(l:stack, 'synIDattr(v:val, "name")'), ' ') . ' ' . synIDattr(synIDtrans(synID(line('.'), col('.'), 0)), "name")
endfunction

" Improves hjkl motion performance by only calling SynStackGroup on Cursor hold
let g:syn_stack = ''
function! SynStackCached()
   return g:syn_stack
endfunction


"------------------------------------------------------------------------------
" Function: LargeFileSettings()
" Description: /d Load large files faster y/ by not using default settings or syntax.
"------------------------------------------------------------------------------
function! LargeFileSettings()
   let g:EnteredLargeFile = 1
   " Disable swap files
   set noswapfile
   " No syntax highlighting etc.
   setlocal eventignore+=FileType
   " Save memory when other file is viewed.
   setlocal bufhidden=unload
   " Is read-only (write with :w new_filename).
   " setlocal buftype=nowrite
   " No undo possible.
   setlocal undolevels=-1
   " Disable modelines to avoid potential security issues...
   set nomodeline
   " Display message.
   augroup LargeFileMsg
      autocmd!
      autocmd VimEnter *  echom "The file is larger than " . (g:LargeFile / 1024 / 1024) . " MB, and most options are disabled (see LargeFileSettings() in .vimrc for details)."
   augroup END
endfunction


"------------------------------------------------------------------------------
" 3. Main Code
"------------------------------------------------------------------------------

"------------------------------------------------------------------------------
" Augroup: MainFunction
" Description: This is basically the equivalent of main() in C. /d MainFunction() r/
"              /d loads everything else in this file r/. First loads CommonSettings()
"              then checks the file size, and if less than g:LargeFile, load
"              DefaultSettings() otherwise load LargeFileSettings().
"------------------------------------------------------------------------------
" Set common setings for Large and Default files. Set the font, the
" colorscheme and the dimensions of the Vim window.
if !exists("g:EnteredCommonSetting")
   call CommonSettings()
endif
augroup MainFunction

   autocmd!

   " Decide whether to call DefaultSettings() or LargeFileSettings() based on the
   " file size.
   autocmd BufReadPre * let f=getfsize(expand("<afile>")) |
      \ if f >= g:LargeFile || f == -2 | call LargeFileSettings() |
      \ else | call DefaultSettings() | endif

   " This gets called if the file is empty and loads DefaultSettings()
   autocmd VimEnter * if !exists("g:EnteredDefaultSetting") && !exists("g:EnteredLargeFile") |
      \ call DefaultSettings() | endif
augroup END

" Set custom syntax for empty files or files with no filetype
augroup SetNoFiletype
   autocmd!
   " NOTE: Was not setting nofiletype when inside filetype_settings.vim with:
   "       grep filetype .vim/ -r | gvim - (but was getting set when opening a
   "       pre-existing file with no filetype). Now works for both cases.
   autocmd BufWinEnter * if &filetype ==# '' | set filetype=nofiletype | endif
augroup END


" NOTE: Check out additional plugins from: https://vimawesome.com/

