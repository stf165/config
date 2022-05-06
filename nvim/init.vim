set title
set hidden
set autoread
set noautochdir
set modelines=0
set nomodeline
set mouse=a
set wildmenu
set backspace=indent,eol,start
set scrolloff=5
set lazyredraw
set background=dark

set virtualedit=block

set incsearch
set hlsearch
set smartcase

set laststatus=0
set showcmd
set showmode
set ruler
set rulerformat=%60(%=%f\ (%l:%c%V)\ %#ModeMsg#%(\ %M\ %)%)

set number
set cursorline

set noexpandtab
set smarttab
set shiftwidth=8
set softtabstop=8
set tabstop=8

set nowrap
set showmatch
set showbreak=↳\
set listchars=tab:․\ ,trail:․
set list

set copyindent
set autoindent
set preserveindent
set smartindent

set textwidth=72
set formatoptions=cqjr

set foldenable
set foldminlines=1
set foldopen=hor,insert,mark,search,undo
set foldcolumn=1
set foldmethod=marker
set foldtext=getline(v:foldstart).'\ '

set undofile
set undodir=/tmp

nnoremap j gj
nnoremap k gk
map <F8> :setlocal spell! spelllang=en_gb<CR>

function! TabWrapper(shift)
	let col = col('.') - 1
	let vcol = virtcol('.') - 1
	if !vcol || getline('.')[col - 1] =~ '	'
		return "	"
	elseif getline('.')[col -1] =~ '^\s*$'
		return repeat(" ", &softtabstop - (vcol % &softtabstop))
	elseif (a:shift)
		return "\<C-P>"
	else
		return "\<C-N>"
	endif
endfunction
inoremap <tab> <c-r>=TabWrapper(0)<CR>
inoremap <S-tab> <c-r>=TabWrapper(1)<CR>
noremap <Tab>   za
noremap <S-Tab> zm

function! TxtFolding(lnum)
	let curline  = getline(a:lnum)
	if curline =~# '^\s*$' && getline(a:lnum + 1) !~# '^\s*$'
		let nextfold = TxtFolding(a:lnum + 1)
		return nextfold[0] == '>' ? nextfold[1] : '='
	elseif curline =~# '^§\+ ' | return '>' .. (len(matchstr(curline,'^§\+'))/2)
	endif
	return '='
endfunction
function! MdFolding(lnum)
	let curline  = getline(a:lnum)
	if curline =~# '^\s*$' && getline(a:lnum + 1) !~# '^\s*$'
		let nextfold = MdFolding(a:lnum + 1)
		return nextfold[0] == '>' ? nextfold[1] : '='
	elseif curline =~# '^##\+ ' | return '>' .. (len(matchstr(curline,'^##\+'))-1)
	endif
	return '='
endfunction
function! CFolding(lnum)
	let curline  = getline(a:lnum)
	if curline =~# '^[^	 ].*{$'         | return '>1'
	elseif curline =~# '^{$'                | return '>1'
	elseif curline =~# '^}.*{$'             | return '='
	elseif curline =~# '^%\?}'              | return '<1'
	elseif curline =~# '^%%$'
		if foldlevel(a:lnum - 1) == 1
			return '<1'
		else
			return '>1'
		endif
	endif
	return '='
endfunction

autocmd BufReadPost * if @% !~# '\.git[\/\\]COMMIT_EDITMSG$' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

syntax on
autocmd FileType c,cpp,yacc,lex,awk,sh,go syntax match MyConstant /\<[A-Z_][A-Z0-9_][A-Z0-9_]\+\>/
hi Comment      ctermfg=8       ctermbg=None    cterm=None
hi PreProc      ctermfg=8       ctermbg=None    cterm=None
hi String       ctermfg=7       ctermbg=None    cterm=Bold,Italic
hi Title        ctermfg=7       ctermbg=None    cterm=Bold,Italic
hi MyConstant   ctermfg=9       ctermbg=None    cterm=None
hi Constant     ctermfg=9       ctermbg=None    cterm=None
hi Special      ctermfg=15      ctermbg=None    cterm=None
hi Identifier   ctermfg=15      ctermbg=None    cterm=None
hi Statement    ctermfg=15      ctermbg=None    cterm=None
hi Conditional  ctermfg=15      ctermbg=None    cterm=None
hi Repeat       ctermfg=15      ctermbg=None    cterm=None
hi Structure    ctermfg=15      ctermbg=None    cterm=None
hi Function     ctermfg=15      ctermbg=None    cterm=None
hi Operator     ctermfg=15      ctermbg=None    cterm=None
hi Type         ctermfg=15      ctermbg=None    cterm=None
hi Error        ctermfg=11      ctermbg=9       cterm=None
hi TODO         ctermfg=9       ctermbg=11      cterm=Bold
hi Folded       ctermfg=15      ctermbg=none    cterm=None
hi Underlined   ctermfg=7                       cterm=None
hi NonText      ctermfg=8                       cterm=None
hi SpecialKey   ctermfg=8                       cterm=None
hi Visual                                       cterm=None
hi Cursor                                       cterm=Reverse
hi CursorLine                   ctermbg=0       cterm=None
hi Search       ctermfg=0       ctermbg=11      cterm=None
hi Directory    ctermfg=None    ctermbg=None    cterm=Bold,Italic
hi ErrorMsg     ctermfg=11      ctermbg=9       cterm=Bold
hi WarningMsg   ctermfg=None    ctermbg=None    cterm=Reverse,Bold
hi ModeMsg      ctermfg=None    ctermbg=None    cterm=Reverse,Bold
hi Pmenu        ctermfg=None    ctermbg=0       cterm=None
hi PmenuSel     ctermfg=None    ctermbg=0       cterm=Reverse,Bold
hi PmenuSbar    ctermfg=8       ctermbg=8       cterm=None
hi PmenuThumb   ctermfg=15      ctermbg=15      cterm=None
hi FoldColumn   ctermfg=8       ctermbg=None    cterm=None
hi SignColumn   ctermfg=9       ctermbg=None    cterm=None
hi LineNr       ctermfg=8       ctermbg=None    cterm=Bold
hi CursorLineNr ctermfg=15      ctermbg=0       cterm=Bold
hi StatusLine   ctermfg=11      ctermbg=4       cterm=Bold
hi StatusLineNC ctermfg=12      ctermbg=7       cterm=none
hi VertSplit    ctermfg=4       ctermbg=4       cterm=None
hi TabLine      ctermfg=8       ctermbg=4       cterm=None
hi TabLineSel   ctermfg=12      ctermbg=0       cterm=None
hi TabLineFill  ctermfg=15      ctermbg=4       cterm=None

call plug#begin()

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()
