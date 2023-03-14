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
map global normal <s-n> :new-horizontal<ret>
map global normal <c-p> :kaktree-toggle<ret>

map global normal <c-left> :bp<ret>
map global normal <c-right> :bn<ret>

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

hook global WinSetOption filetype=yaml expandtab
hook global WinSetOption filetype=haskell expandtab
hook global WinSetOption filetype=elm expandtab

hook global BufSetOption filetype=go %{
  set-option buffer formatcmd 'gofmt'
  hook buffer BufWritePre .* %{format}
}

hook global WinSetOption filetype=elm %{
  set window formatcmd 'elm-format --stdin'
 
  hook buffer BufWritePre .* %{format}
}


# hook global BufCreate .*/garden-v2/.* %{
# 	hook global BufSetOption filetype=(javascript|typescript) %{
# 	  set-option buffer formatcmd "prettier --stdin-filepath=%val{buffile}"
# 	  hook buffer BufWritePre .* %{format}
# 	}
# }
# hook global BufCreate .*/dockertest/frontend-v2/.* %{
# 	hook global BufSetOption filetype=(javascript|typescript) %{
# 	  set-option buffer formatcmd "prettier --stdin-filepath=%val{buffile}"
# 	}
# }
hook global BufSetOption filetype=(javascript|typescript) %{
  set-option buffer formatcmd "prettier --stdin-filepath=%val{buffile}"
  hook buffer BufWritePre .* %{format}
}

#define-command -docstring "psql-enable" \
#psql-enable %{
  #declare-option -docstring "Postgres database" str postgres_database
  #declare-option -docstring "Postgres user" str postgres_user
  #declare-option -docstring "Postgres host" str postgres_host
  #declare-option -docstring "Postgres port" int postgres_port
  #declare-option -hidden str psql_tmpfile
  #set-option window postgres_database "vetpro"
  #set-option window postgres_user "postgres"
  #set-option window postgres_host "localhost"
  #set-option window postgres_port 5432
  #set-option window psql_tmpfile %sh{ mktemp /tmp/kakoune_psql.XXXX }
#
  #define-command -docstring "query-selection" \
  #query-selection %{
    #execute-keys -itersel -draft "<a-|>psql -A -d %opt{postgres_database} -U %opt{postgres_user} -h %opt{postgres_host} -p %opt{postgres_port} >> %opt{psql_tmpfile} 2>&1<ret>"
  #}
#
  #define-command -docstring "query-buffer" \
  #query-buffer %{
    #execute-keys -draft "%%: query-selection<ret>"
  #}
#
  ## tmux-terminal-horizontal kak -s "%val{session}-psql" -e "edit %opt{psql_tmpfile}; set-option window autoreload yes; nop %sh{ tmux select-pane -t .! }"
  #repl-new kak -s "%val{session}-psql" -e "edit %opt{psql_tmpfile}; set-option window autoreload yes"
#
  #hook window WinClose .* %{ psql-disable }
#}
#define-command -docstring "psql-disable" \
#psql-disable %{
  #unset-option window postgres_database
  #unset-option window postgres_user
  #unset-option window postgres_host
  #unset-option window postgres_port
  #unset-option window psql_tmpfile
  #nop %sh{
    #kak -c "${kak_session}-psql" -e "kill!"
    #rm -f "/tmp/$kak_opt_psql_tmpfile"
    #echo "$kak_opt_psql_tmpfile" > /tmp/foo
    #rm -f "/tmp/"
  #}
#}


define-command paste-and-edit -params 2 %{
		edit -scratch %arg{2}
		exec '%"@pd'
		set-option buffer filetype %arg{1}
}

define-command compare-master %{
		set-register arobase %sh{ git show master:$(realpath --relative-base=$(git rev-parse --show-toplevel) $kak_buffile)}
		set-register caret %opt{filetype}
		new-horizontal paste-and-edit
}

define-command compare \
-override \
-docstring "Compare to another git branch" \
-params 1 \
-shell-script-candidates %{git branch} \
		%{
		set-register arobase %sh{ git show $1:$(realpath --relative-base=$(git rev-parse --show-toplevel) $kak_buffile)}
		new-horizontal paste-and-edit %opt{filetype} %arg{1}
}

define-command eval-query \
 -override \
 -params 1 \
 -shell-script-candidates %{
		echo "\list" | psql "postgres://postgres:qwerty@localhost:6432?sslmode=disable" | tail -n +4 | head -n -8 | awk '{print $1}'
 } \
 %{
  info %sh{
		echo "${kak_selection}" | psql postgresql://postgres:qwerty@localhost:6432/$1 -e 2>&1
  }
 }

