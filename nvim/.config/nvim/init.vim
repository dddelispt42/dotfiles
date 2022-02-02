    lua require("init")
    " Enable type inlay hints

    " Rust inline hints
    autocmd CursorHold,CursorHoldI *.rs :lua require'lsp_extensions'.inlay_hints{ only_current_line = true, prefix = '  » ', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"}}

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

"" ale
    let g:ale_linters = {
    \   'ansible': ['ansible_lint'],
    \   'asciidoc': ['textlint', 'writegood'],
    \   'asm': ['cpp'],
    \   'awk': ['gawk'],
    \   'bib': ['bibclean'],
    \   'c': ['clang', 'clangtidy', 'cppcheck', 'flawfinder', 'gcc'],
    \   'chef': ['cookstyle', 'foodcritic'],
    \   'cmake': ['cmakelint'],
    \   'cpp': ['clang', 'clangcheck', 'clangtidy', 'cppcheck', 'cpplint', 'flawfinder', 'gcc'],
    \   'css': ['csslint', 'fecs', 'stylelint'],
    \   'cucumber': ['cucumber'],
    \   'dockerfile': ['dockerfile_lint', 'hadolint'],
    \   'gitcommit': ['gitlint'],
    \   'go': ['gobuilt', 'gofmt', 'golint', 'langserver', 'staticcheck'],
    \   'help': ['proselint', 'writegood'],
    \   'html': ['fecs', 'htmllint', 'proselint', 'stylelint', 'tidy', 'writegood'],
    \   'java': ['checkstyle', 'javac'],
    \   'javascript': ['eslint', 'fecs', 'jshint', 'tsserver', 'xo'],
    \   'json': ['jsonlint'],
    \   'kotlin': ['kotlinc', 'ktlint', 'languageserver'],
    \   'less': ['stylelint'],
    \   'lua': ['luac', 'luacheck'],
    \   'make': ['checkmake'],
    \   'markdown': ['languagetool', 'markdownlint', 'proselint', 'textlint', 'writegood'],
    \   'matlab': ['mlint'],
    \   'proto': ['proto_gen_lint'],
    \   'python': ['pylint', 'flake8', 'pydocstyle', 'bandit'],
    \   'sh': ['shellcheck', 'shell', 'language_server'],
    \   'sql': ['sqlint'],
    \   'tex': ['chktex', 'lacheck', 'proselint', 'texlab', 'texlint', 'writegood'],
    \   'texinfo': ['proselint', 'writegood'],
    \   'text': ['languagetool', 'proselint', 'textlint', 'writegood'],
    \   'typescript': ['eslint', 'tslint', 'typecheck', 'tsserver', 'xo'],
    \   'vim': ['vint', 'ale_custom_linting_rules'],
    \   'xhtml': ['proselint', 'writegood'],
    \   'xml': ['xmllint'],
    \   'yaml': ['yamllint'],
    \   'yang': ['yang_lsp'],
    \}
    "   'python': ['bandit', 'flake8', 'mypy', 'pycodestyle', 'vulture', 'pydocstyle'],
    " \   'python': ['bandit', 'flake8', 'mypy', 'pylint', 'pycodestyle','pydocstyle'],
    " \   'rust': ['cargo', 'rls', 'rustc'],
    " \   'rust': ['cargo', 'rust-analyzer', 'rustc'],
    let g:ale_fixers = {
    \   '*': ['remove_trailing_lines', 'trim_whitespace'],
    \   'css': ['prettier'],
    \   'go': ['gofmt', 'goimports'],
    \   'html': ['prettier'],
    \   'javascript': ['prettier', 'eslint'],
    \   'less': ['prettier'],
    \   'lua': ['luafmt'],
    \   'python': ['black'],
    \   'rust': ['rustfmt'],
    \   'sh': ['shfmt'],
    \   'sql': ['sqlfmt'],
    \   'tex': ['latexindent'],
    \   'yaml': ['yamlfix'],
    \}
    " 'python': ['black', 'isort', 'docformatter', 'pyment'],
    let g:ale_linters_explicit = 1
    let g:ale_fix_on_save = 1
    let g:ale_javascript_prettier_options = '--single-quote --trailing-comma es5'
    " vim ale
    let g:ale_lint_on_text_changed = 'never'
    let g:ale_lint_on_enter = 1
    let g:ale_completion_enabled = 0
    let g:airline#extensions#ale#enabled = 0
    let g:ale_set_loclist = 0
    let g:ale_set_quickfix = 1
    let g:ale_open_list = 1
    " nmap gd :ALEGoToDefinition<CR>
    " nmap gr :ALEFindReferences<CR>
    " nmap K :ALEHover<CR>

" Vista
    " Declare the command including the executable and options used to generate ctags output
    " for some certain filetypes.The file path will be appened to your custom command.
    " For example:
    let g:vista_executive_for = {
        \ 'markdown': 'toc',
        \ 'vimwiki': 'markdown',
        \ 'python': 'lcn',
        \ 'rust': 'lcn',
        \ 'sh': 'lcn',
        \ }

    let g:vista_ctags_cmd = {
          \ 'haskell': 'hasktags -x -o - -c',
          \ 'java': 'ctags -f ./tags -R --exclude="*.js" --exclude="*.html" --tag-relative=yes .',
          \ 'python': 'ctags -f ./tags -R --exclude="*.js" --exclude="*.html" --tag-relative=yes .',
          \ 'rust': 'ctags -f ./tags -R --exclude="*.js" --exclude="*.html" --tag-relative=yes .',
          \ 'sh': 'ctags -f ./tags -R --exclude="*.js" --exclude="*.html" --tag-relative=yes .',
          \ }
    " To enable fzf's preview window set g:vista_fzf_preview.
    " The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
    " For example:
    let g:vista_fzf_preview = ['right:50%']
    " Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
    let g:vista#renderer#enable_icon = 1
    " The default icons can't be suitable for all the filetypes, you can extend it as you wish.
    let g:vista#renderer#icons = {
    \   "function": "\uf794",
    \   "variable": "\uf71b",
    \  }
    noremap <Leader>tb :Vista!!<CR>

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
            silent exec "!brave ".shellescape(s:uri, 1)." &"
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
    let g:vira_browser = 'brave'
    " TODO: run queries and open issues from there

" Snipplets:
    let g:UltiSnipsSnippetsDir="~/dev/heiko/dotfiles/vim/UltiSnips"
    let g:UltiSnipsListSnippets="<s-tab>"
    let g:UltiSnipsExpandTrigger = "<tab>"
    let g:UltiSnipsJumpForwardTrigger = "<tab>"
    let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
    " TODO: remove once nvim understands 3.10 > 3.3 (Ultisnip)
    if has('win64') || has('win32') || has('win16')
        let g:env = 'WINDOWS'
        let g:python3_host_prog = "C:\\Python39\\python.EXE"
    endif

" PlantUML Syntax:
    au BufNewFile,BufRead *.uml set filetype=plantuml

    " comments in italic
    highlight Comment gui=italic
