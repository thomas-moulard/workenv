# -*- shell-script -*-
function update_workenv()
{
    pushd "$WORKENV_DIR" && \
    git fetch origin && \
    git merge --ff-only origin/master master
    popd
}
