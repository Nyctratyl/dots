source "%val{config}/plugins/plug.kak/rc/plug.kak"
plug "andreyorst/plug.kak" noload
plug "andreyorst/smarttab.kak"
plug "andreyorst/fzf.kak"

set-option global tabstop 2
set-option global indentwidth 2

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

eval %sh{kak-lsp --kakoune -s $kak_session}  # Not needed if you load it with plug.kak.
lsp-enable
# lsp-auto-hover-enable
# lsp-auto-hover-insert-mode-disable
lsp-auto-signature-help-enable

add-highlighter global/ show-matching
add-highlighter global/ number-lines -relative

colorscheme mysticaltutor

hook global InsertCompletionShow .* %{ map window insert <tab> <c-n>; map window insert <s-tab> <c-p> }
hook global InsertCompletionHide .* %{ unmap window insert <tab> <c-n>; unmap window insert <s-tab> <c-p> }

map global normal <c-n> :new<ret>
map global normal <c-p> :kaktree-toggle<ret>

hook global WinCreate .* %{ git show-diff; smarttab}

hook global RegisterModified '"' %{ nop %sh{
	  printf %s "$kak_main_reg_dquote" | wl-copy > /dev/null 2>&1 &
}}

map global normal P '!wl-paste<ret>'

map global normal <c-h> ':lsp-hover<ret>'
map global normal <c-g> ':peneira-symbols<ret>'
map global normal <c-f> ':peneira-files<ret>'

plug "gustavo-hms/luar" %{
    require-module luar
    plug "gustavo-hms/peneira" %{
        require-module peneira
    }
}

hook global BufSetOption filetype=go %{
  set-option buffer formatcmd 'gofmt'
  hook buffer BufWritePre .* %{format}
}
