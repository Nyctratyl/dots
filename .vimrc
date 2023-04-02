set nocompatible
filetype off
set rtp +=~/.vim/bundle/Vundle.vim

syntax enable
set number relativenumber
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
autocmd BufRead,BufNewFile ~/Documents/GitHub/MuseScore/* setlocal tabstop=6 shiftwidth=6
autocmd BufRead,BufNewFile ~/Documents/kurser/kex/* setlocal tabstop=2 shiftwidth=2
autocmd BufRead,BufNewFile ~/kod/blaslagets_strecklista_public/* setlocal tabstop=2 shiftwidth=2
autocmd BufRead,BufNewFile /var/www/html* setlocal tabstop=4 shiftwidth=4 noautoindent noexpandtab
autocmd BufRead,BufNewFile ~/work/garden-v2 setlocal tabstop=4 shiftwidth=4 noautoindent noexpandtab
autocmd BufRead,BufNewFile *.md set tw=80 fo+=a
set foldmethod=syntax
set foldlevelstart=0
let javaScript_fold=1 " Javascript
"set viewoptions=cursor,folds,slash,unix
" let g:skipview_files = ['*\.vim']
set autoindent

nnoremap g, <C-o>
nnoremap g. <C-i>

nnoremap <SPACE> <Nop>
let mapleader=" "

" vimtex options
let g:vimtex_fold_enabled = 1
let g:vimtex_quickfix_enabled = 0
let g:vimtex_view_general_viewer = 'zathura'

" vim-markdown options
let g:vim_markdown_math = 1

"Remap basic navigation
noremap <Down> <C-e>
noremap <Up> <C-y>

"Remap split navigation
execute "set <M-h>=\eh"
execute "set <M-j>=\ej"
execute "set <M-k>=\ek"
execute "set <M-l>=\el"
nnoremap <M-h> <C-W><C-h>
nnoremap <M-j> <C-W><C-j>
nnoremap <M-k> <C-W><C-k>
nnoremap <M-l> <C-W><C-l>

"Remap tab movement

execute "set <M-1>=\e1"
execute "set <M-2>=\e2"
execute "set <M-3>=\e3"
execute "set <M-4>=\e4"
execute "set <M-5>=\e5"
execute "set <M-6>=\e6"
execute "set <M-7>=\e7"
execute "set <M-8>=\e8"
execute "set <M-9>=\e9"
execute "set <M-0>=\e0"
" Go to tab by number
noremap <M-1> 1gt
noremap <M-2> 2gt
noremap <M-3> 3gt
noremap <M-4> 4gt
noremap <M-5> 5gt
noremap <M-6> 6gt
noremap <M-7> 7gt
noremap <M-8> 8gt
noremap <M-9> 9gt
noremap <M-0> :tablast<cr>

noremap <C-m> :let @/=''<cr>

so ~/.vim/plugins.vim
map <C-o> :NERDTreeToggle<CR>
colorscheme codedark
"Split sizes equal after window resize
autocmd VimResized * wincmd =
"Escape to normal mode in terminal mode
tnoremap <Esc> <C-\><C-n>
"Normal mode cursor to underscore
set guicursor+=n:hor10-Cursor/lCursor

iabbrev @@ jacob.schoerner@gmail.com

"Distraction free, goyo
function! s:goyo_enter()
endfunction
function! s:goyo_enter()
    highlight! EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg
    let b:quitting = 0
    let b:quitting_bang = 0
    autocmd QuitPre <buffer> let b:quitting = 1
    cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
    set eventignore=FocusGained
endfunction

function! s:goyo_leave()
    " Quit Vim if this is the only remaining buffer
    if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
        if b:quitting_bang
            qa!
        else
            qa
        endif
    endif
endfunction

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()
autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd BufRead,BufNewFile ~/todos* Goyo

"Split hotkeys
nnoremap <C-t> :below sp \| res 20 \| startinsert \| term <cr>
nnoremap <C-i> :below sp<cr>
nnoremap <C-s> :vsp<cr>

"Copypaste from system clipboard
set clipboard=unnamedplus

"Don't show ---INSERT----, these are unnecessary because of our statusline
set noshowmode

"Buffer scrolling
nnoremap <silent> <Right> :bnext<CR>
nnoremap <silent> <Left> :bprev<CR>

"Remember folds on exit
augroup remember_folds
  autocmd!
  au BufWinLeave ?* mkview 1
  au BufWinEnter ?* silent! loadview 1
augroup END

let g:airline_extensions = ['branch']
let g:airline_theme='angr'
let g:airline#extensions#tabline#enabled = 1

let g:tagbar_type_python = {
    \ 'kinds' : [
        \ 'i:modules:1:0',
        \ 'c:classes',
        \ 'f:functions',
        \ 'm:members',
        \ 'v:variables:0:0',
        \ '?:unknown',
    \ ],
\ }

map <C-p> :TagbarToggle<CR>
let g:tagbar_use_cache = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

nnoremap <C-j> 5<C-e>
nnoremap <C-k> 5<C-y>

"CoC-config
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
"if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
"  set signcolumn=number
"else
"  set signcolumn=yes
"endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Use K to show documentation in preview window.
nmap <silent> <leader>k :call <SID>show_documentation()<CR>

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
"nmap <silent> <C-s> <Plug>(coc-range-select)
"xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
" We skip these for now as they interfere with stuff
"nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
" nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
" nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
" nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
" nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
" nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
" nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

let g:go_doc_keywordprg_enabled = 0
if exists('g:loaded_polyglot')
    let g:polyglot_disabled = ['go']
endif

" Autoformatting on save disabled because it fucks with folds
let g:go_fmt_autosave = 0

nnoremap <C-b> :Buffers<CR>

"Disable Session prompt for logins
let g:session_autoload = 'no'

set cmdheight=1
