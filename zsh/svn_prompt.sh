prompt_svn() {
    local rev branch
    if in_svn; then
        rev=$(svn_get_rev_nr | dos2unix)
        branch=$(svn_get_branch_name | dos2unix)
        if [[ $(svn_dirty_choose_pwd 1 0) -eq 1 ]]; then
            prompt_segment yellow black
            echo -n "Rev:$rev@$branch"
            echo -n "±"
        else
            prompt_segment green black
            echo -n "Rev:$rev@$branch"
        fi
    fi
}

build_prompt() {
    RETVAL=$?
    prompt_status
    prompt_context
    prompt_dir
    prompt_git
    prompt_svn
    prompt_end
}
