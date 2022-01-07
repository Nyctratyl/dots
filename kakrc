eval %sh{kak-lsp --kakoune -s $kak_session}  # Not needed if you load it with plug.kak.
lsp-enable
lsp-auto-hover-enable
lsp-auto-signature-help-enable
lsp-auto-hover-insert-mode-disable
git diff show-diff

source "%val{config}/plugins/plug.kak/rc/plug.kak"
plug "andreyorst/plug.kak" noload

plug "andreyorst/kaktree" config %{
    hook global WinSetOption filetype=kaktree %{
        remove-highlighter buffer/numbers
        remove-highlighter buffer/matching
        remove-highlighter buffer/wrap
        remove-highlighter buffer/show-whitespaces
	set-option kaktree_size '70'
    }
    kaktree-enable
}

add-highlighter global/ show-matching
add-highlighter global/ number-lines -relative

colorscheme mysticaltutor

hook global InsertCompletionShow .* %{ map window insert <tab> <c-n>; map window insert <s-tab> <c-p> }
hook global InsertCompletionHide .* %{ unmap window insert <tab> <c-n>; unmap window insert <s-tab> <c-p> }

map global normal <c-n> :new<ret>
map global normal <c-p> :kaktree-toggle<ret>

map global normal <c-h> 5h
map global normal <c-j> 5j
# map global normal <ret> 5j # this is pretty fucked up, but apparently these are equivalent when ran inside tmux
map global normal <c-k> 5k
map global normal <c-l> 5l

map global normal <c-d> 5j
map global normal <c-u> 5k
