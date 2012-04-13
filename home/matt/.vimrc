set nocompatible
syn on

" allow the mouse (for middle-clicking, which can also be done with the *
" register)
set mouse=a

set softtabstop=2
set shiftwidth=2
set tabstop=2
set expandtab
set display=lastline "shows partial lines at end of view when wordwrapped

filetype plugin on  
filetype indent on "allow filetype-specific auto-indenting
"filetype detection on "this apparently is broken now

" rulers     
set guioptions-=R
set guioptions-=L
set guioptions-=r
set guioptions-=l
set guioptions-=m "get rid of menu bar
set guioptions-=T         "disable toolbar

"I have no idea why I'm using ack instead of grep...
set grepprg=ack

set hlsearch
set incsearch
set ignorecase
""set smartcase

set wildmenu "shows a tab-completion list in the command line
set wildmode=longest,full "Complete longest common string, then each full match

set wildignorecase "ignore case in filename completion :)


if has("gui_running")
  "set fuoptions=maxvert,maxhorz
  colorscheme freya
  set lines=50
  set columns=84
  set cursorline
  "set guifont=Menlo\ Regular:h14
  set spell
else
  set nospell "spell check highlighting is annoying in terminals.
endif
set number "show line numbers
"set cindent "was autoindent before. use c indenting rules "using auto-indent instead right now.. ?

set guioptions+=r

"word wrap
"noremap j gj
"noremap k gk
"noremap gj j
"noremap gk k

"convenience
noremap H H0
noremap L L0
noremap M M0

"use C-N and C-P to move between tabs in normal mode
nnoremap <c-n> gt
nnoremap <c-p> gT

"to be able to undo c-u & c-w in insert mode (because it happens all too often
"by accident)
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

"automatically mkview and loadview
au BufWritePost,BufLeave,WinLeave ?* mkview
"au BufReadPre ?* silent loadview

"takes whatever was last searched for and does a find and
"replace for whatever you type in next 
"(especially useful for searching with *)
"used with \r in normal mode
nmap <leader>r <Esc>:%s/\(<C-r>/\)//g<left><left>
nmap <leader>R <Esc>:%s/\(<C-r>/\)//gc<left><left><left>

" set showtabline=2 " always show tabs in gvim, but not vim
" set up tab labels with tab number, buffer name, number of windows
function! GuiTabLabel()
  let label = ''
  let bufnrlist = tabpagebuflist(v:lnum)
  " Add '+' if one of the buffers in the tab page is modified
  for bufnr in bufnrlist
    if getbufvar(bufnr, "&modified")
      let label = '+'
      break
    endif
  endfor
  " Append the tab number
  let label .= v:lnum.': '
  " Append the buffer name
  let name = bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
  if name == ''
    " give a name to no-name documents
    if &buftype=='quickfix'
      let name = '[Quickfix List]'
    else
      let name = '[No Name]'
    endif
  else
    " get only the file name
    let name = fnamemodify(name,":t")
  endif
  let label .= name
  " Append the number of windows in the tab page
  let wincount = tabpagewinnr(v:lnum, '$')
  return label " . '  [' . wincount . ']'
endfunction
set guitablabel=%{GuiTabLabel()}

"make the enter key temporarily clear the search highlighting
nnoremap <CR> :noh<CR>

"make word-wrapped lines look kind of nice
let &showbreak=repeat('.', 20)

"show tabs and trailing whitespace
set listchars=tab:>-,trail:-
set list

"For taglist"
nmap <leader>l :TlistToggle<CR>

" Allow sudo writing of files
cmap w!! w !sudo tee >/dev/null %

"automaticcaly change working directory to directory of current buffer:
"autocmd BufEnter * lcd %:p:h


"SPECIAL THINGS FOR THE MWWM WIKI CONVENIENCE:"
inoremap <Right> &rarr;
inoremap <Up> &uarr;
inoremap <Down> &darr;

"JAVA CONVENIENCE:"
imap sout System.out.println();<Left><Left>

"this is good to use in python maybe, but not as much generally. I wonder if I can set
"it...
"set foldmethod=indent"

"ignore white space in vim diffs
"set diffopt+=iwhite
