#!/bin/bash
set -e

# List of Repos
repos=("
# LIST OF REPOS
"
)

# For loop to create repos
for i in ${repos}; do 
    echo $i

    gh api \
    --method POST \
    -H "Accept: application/vnd.github+json" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    /orgs/<ORGNAME>/repos \
    -f name="server02/${i}" \
    -F private=true \

 done
