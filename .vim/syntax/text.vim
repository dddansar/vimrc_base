"==============================================================================
" File: text.vim
"------------------------------------------------------------------------------
" Description: This file adds custom syntax highlighting for all text files.
"------------------------------------------------------------------------------
" Authors: Danny Sarraf
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


" NOTE: Removed guard so that syntax gets reloaded if file was reloaded.
" Exit if the file was already loaded
" if exists("b:text_loaded")
"    finish
" endif
if !exists("g:syntax_on") || !isdirectory(expand($vim_folder_path))
   finish
endif
if !exists("b:current_syntax") || b:current_syntax == ""
   let b:current_syntax = "text"
endif
" NOTE: Guards against double loading if syntax filetype1 loads filetype2.
if !exists("b:current_syntax") || b:current_syntax != "text"
   finish
endif
if exists("g:debug_syntax")
   echom "text.vim syntax file loaded"
endif
let b:text_loaded = 1


let b:comment_leader = '//'
let b:multi_line_comment_start = '\(^\|\s\)\@<=/\*'
let b:multi_line_comment_end = '\*/'
source $vim_folder_path/lib/more_colors.vim
source $vim_folder_path/lib/syntax_library.vim
source $vim_folder_path/lib/regex.vim
source $vim_folder_path/lib/abbrev.vim

call AllShiftOp()
call AllOperators()
call AllFilesDefaultSyntax()

" smartindent in Vim is an indentation option that provides automatic
" indentation when starting a new line.
" Keep autoindent, but remove cindent/smartindent
setlocal nosmartindent
setlocal nocindent

hi  link    TextSlash      Function
syn match   TextSlash      "\%#=1\/"

" Match alone quotes. Quote pairs are matched elsewhere
hi  link    TextAloneQuotes Function
syn match   TextAloneQuotes "\%#=1["]"
syn match   TextAloneQuotes "\%#=1\%(\ws\)\@<!'"
syn match   TextUnmatchQuotes "\%#=1\%(\w\)\@<='\%([dstm]\|ve\|ll\|re\)\>"


" Match (+) (-) (~)
"------------------------------------------------------------------------------
hi  link    TextPlusParen      StorageClass
syn match   TextPlusParen      "\%#=1(+)"
hi  link    TextMinusParen     Function
syn match   TextMinusParen     "\%#=1(-)"
hi  link    TextTildaParen     Define
syn match   TextTildaParen     "\%#=1(\~)"
"------------------------------------------------------------------------------

call AllSpecial()
call AllEqualities()
call AllArrows()
call AllParenBr()
" call AllWebsites(0)
call AllSeparators2() " needs to be before AllNumbers()
call AllNumbers()
call AllNumbersHex()
" call AllLabel()
" call AllMultiWordLabel(0)
call AllSlashes()
call AllFontStyles(0)
call AllCommentAnywhere()
call AllMultiLineCommentAnywhere()
" call AllHLWords()
call AllTitlesMarkdown()
call AllTitlesNotContained()
call AllQuotesLookbehind(0)
" AllPaths needs to be after regex/slashes/operators/separators...
call AllPaths1(0)
call AllPathsWin(0)
call AllPathsDollar(0)

" Match 1) A) (2) (B)...
" Start of line, one or more spaces followed by 0 or 1 "(" followed by
" number/letter and ")".
hi  link    TextNumberParen    Function
hi  link    TextLetterParen    Question
syn match   TextNumberParen    "\%#=1^\s*-\?\s*(\?[0-9]\+)" contains=@NoSpell containedin=AllLabel3
syn match   TextLetterParen    "\%#=1^\s*-\?\s*(\?[A-Z])" contains=@NoSpell containedin=AllLabel3
syn match   TextNumberParen    "\%#=1\s\+([0-9]\+)" contains=@NoSpell containedin=AllLabel3
syn match   TextLetterParen    "\%#=1\s\+([A-Z])" contains=@NoSpell containedin=AllLabel3

call AllMultiWordLabel(0)

