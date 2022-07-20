
# install package from GitHub releases using GitHub's API

#### inspired by (but not used as reference): https://github.com/izirku/gitrel "GitHub binary manager - install and update single binary releases via GitHub API"


## json parse:

good to be used in win
https://github.com/vcheckzen/posix-awk-shell-jq

wget -O-  https://api.github.com/repos/zyedidia/micro/releases/latest  | ./jq.sh - name


<!-- or better  -->


https://gist.githubusercontent.com/redraw/13ff169741d502b6616dd05dccaa5554/raw/cf21da0da96843d0c70946d332d1c02b8e9c009a/github-install.sh




lazy (too lazy) aproahc: 
https://gist.github.com/steinwaywhw/a4cd19cda655b8249d908261a62687f8


lazy (mine) bugfree
wget -O-  https://api.github.com/repos/zyedidia/micro/releases/latest  | sed -ne '/^  "name":/ { s/"[^"]*$//; s/^.*"//; p; q; }'


in ideal world this detection should not be needed:
- GH to make it easy to always download the  latest with the same link
- devs to link it https://docs.github.com/en/repositories/releasing-projects-on-github/linking-to-releases


seems like simple (but not shellchecked):
https://gist.github.com/redraw/13ff169741d502b6616dd05dccaa5554



very fast very good working (requires just sed):
https://github.com/ryncsn/poorjson.sh/blob/main/poorjson.sh



and maybe search for more:
https://github.com/search?q=posix+json


----


