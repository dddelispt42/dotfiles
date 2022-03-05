    lua require("init")
    "
" configure Firenvim
    let g:firenvim_config = {
        \ 'globalSettings': {
            \ 'alt': 'all',
        \  },
        \ 'localSettings': {
            \ '.*': {
                \ 'cmdline': 'neovim',
                \ 'content': 'text',
                \ 'priority': 0,
                \ 'selector': 'textarea',
                \ 'takeover': 'never',
            \ },
        \ }
    \ }
    let fc = g:firenvim_config['localSettings']
    " let fc['https?://[^/]+\.co\.uk/'] = { 'takeover': 'never', 'priority': 1 }
    " let fc['.*'] = { 'takeover': 'never' }

    augroup heiko
        au!
        au BufEnter github.com_*.txt set filetype=markdown
        au BufEnter jira.infi*.txt set filetype=markdown
        au BufEnter www.plantuml.com*.txt set filetype=plantuml
    augroup end

" Plantuml-syntax
    let g:plantuml_executable_script = "~/bin/plantUML.sh"
    let g:slumlord_plantuml_jar_path = '~/bin/plantuml.jar'
    noremap <leader>V :silent! !tmux split-window "/usr/bin/env zsh -c \"tmux resize-pane -y 3;source $HOME/.config/zsh/.zshrc; cd $HOME/klaut/PlantUML; ls *.uml \| entr -p ~/bin/plantUML.sh /_\""<CR>

" ----------------------
" TODO: move this to lua
" ----------------------
""" vimwiki
    " vimwiki with markdown support
    let wiki_1 = {}
    let wiki_1.path = '~/klaut/vimwiki/work/'
    let wiki_1.syntax = 'markdown'
    let wiki_1.ext = '.md'

    let wiki_2 = {}
    let wiki_2.path = '~/klaut/vimwiki/personal/'
    let wiki_2.syntax = 'markdown'
    let wiki_2.ext = '.md'

    let wiki_3 = {}
    let wiki_3.path = '~/klaut/vimwiki/recipes/'
    let wiki_3.syntax = 'markdown'
    let wiki_3.ext = '.md'

    let g:vimwiki_list = [wiki_1, wiki_2, wiki_3]
    let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
    " helppage -> :h vimwiki-syntax
    let g:vimwiki_table_mappings = 0
    let g:vimwiki_global_ext = 0
    let g:vimwiki_folding='expr'
    let g:vimwiki_table_auto_fmt=1
    " let l:vimwiki_header_type = '#'     " set to '=' for wiki syntax
    " au FileType vimwiki set syntax=markdown
    map <silent> <leader>wf :FZF ~/klaut/vimwiki<cr>
    autocmd BufNewFile,BufReadPost,BufWritePost,BufEnter ~/klaut/vimwiki/*.md set filetype=vimwiki
    autocmd BufNewFile,BufReadPost,BufWritePost,BufEnter ~/klaut/vimwiki/*.md silent! cd ~/klaut/vimwiki
    augroup VimWikiToDo
        autocmd!
        autocmd FileType vimwiki syntax match VimWikiToDoDone '^\v\s*-\s\[X\].*$'
        autocmd FileType vimwiki highlight link VimWikiToDoDone Comment
    augroup END

" start a pomodoro timer
    let g:pomoTimer = 0
    function! TogglePomodoroTimer()
        if g:pomoTimer == 0
            silent !tmux split-window "/usr/bin/env zsh -c \"tmux resize-pane -y 3;source ~/.config/zsh/.zshrc; cd ~/opt; gtd\""
            let g:pomoTimer = 1
        else
            silent !pkill -u $USER gtd
            let g:pomoTimer = 0
        endif

    endfunction
    noremap <leader>T :call TogglePomodoroTimer()<cr>
    noremap <leader>D :VimwikiToggleListItem<cr>ddGp<c-o>

" vim-open-url
    function! HandleURL()
        let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;\(\)]*')
        if s:uri != ""
            silent exec "!qutebrowser ".shellescape(s:uri, 1)." &"
            :redraw!
        else
            echo "No URI found in line."
        endif
    endfunction
    map <leader>u :call HandleURL()<cr>
    function! GetMDwebLinkFromURL()
        let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;\(\)]*')
        let s:title = system('get_webpage_title.sh '.shellescape(s:uri, 1))
        if s:uri != ""
            silent call setline(".", substitute(getline("."), '[a-z]*:\/\/[^ >,;\(\)]*', "[".s:title[:-2]."]"."(".s:uri.")", ""))
        else
            echo "No URI found in line."
        endif
    endfunction
    map <leader>U :call GetMDwebLinkFromURL()<cr>

" machakann/vim-highlightedyank
    let g:highlightedyank_highlight_duration = 500

" neotex
    let g:neotex_enabled = 1
    let g:neotex_latexdiff = 1
    let g:tex_flavor = 'pdflatex'
    let g:neotex_delay = 500

" terminal config
    if has("nvim")
        let g:floaterm_height = 0.8
        let g:floaterm_width = 0.8
        let g:floaterm_autoclose = 1
        nnoremap   <silent>   <F7>    :FloatermNew<CR>
        tnoremap   <silent>   <F7>    <C-\><C-n>:FloatermNew<CR>
        nnoremap   <silent>   <F8>    :FloatermPrev<CR>
        tnoremap   <silent>   <F8>    <C-\><C-n>:FloatermPrev<CR>
        nnoremap   <silent>   <F9>    :FloatermNext<CR>
        tnoremap   <silent>   <F9>    <C-\><C-n>:FloatermNext<CR>
        nnoremap   <silent>   <F12>   :FloatermToggle<CR>
        tnoremap   <silent>   <F12>   <C-\><C-n>:FloatermToggle<CR>
        nnoremap <silent> <leader>sh :terminal<CR>
        " nnoremap <silent> <Leader>ld :FloatermNew lazydocker<CR>
        " nnoremap <silent> <Leader>lg :FloatermNew lazygit<CR>
        " nnoremap <silent> <Leader>lf :FloatermNew lf<CR>
        " nnoremap <silent> <Leader>bt :FloatermNew bashtop<CR>
        nnoremap <silent> <Leader>hc :FloatermNew habitctl<CR>
        nnoremap <silent> <Leader>js :FloatermNew zsh -c "source .config/zsh/.config/zsh/.zshrc; fj"<CR>
    endif

" JIRA - editor in VIM ;-)
    function! OpenJiraIssue()
        if !exists("g:vira_serv")
            call vira#_menu('servers')
            echo "Connecting to a JIRA server first..."
        else
            let g:vira_active_issue = input("Enter issue.key: ")
            call vira#_menu('report')
        endif
    endfunction
    map <leader>jo :call OpenJiraIssue()<cr>
    let g:vira_browser = 'qutebrowser'
    " TODO: run queries and open issues from there

" Snipplets:
    let g:UltiSnipsSnippetsDir="~/dev/heiko/dotfiles/vim/UltiSnips"
    let g:UltiSnipsListSnippets="<s-tab>"
    let g:UltiSnipsExpandTrigger = "<tab>"
    let g:UltiSnipsJumpForwardTrigger = "<tab>"
    let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" PlantUML Syntax:
    au BufNewFile,BufRead *.uml set filetype=plantuml

    " comments in italic
    highlight Comment gui=italic
