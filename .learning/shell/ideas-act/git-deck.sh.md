

## Demo



### Help

#### `help gd`

~~~ sh
git-deck help
~~~

~~~~ text
sub command(s) here:
- bare-play: means 'bare_play'.
- bp: means 'bare_play'.
- clone-play: means 'clone_play'.
- cp: means 'clone_play'.
- rc: means 'repo_chk'.
- repo-check: means 'repo_chk'.
- repo-chk: means 'repo_chk'.
- sp: means 'sync_play'.
- sub-help: means 'aliases'.
- sync-play: means 'sync_play'.
~~~~

~~~ sh
gd help
~~~

~~~~ text
sub command(s) here:
- bare-play: means 'bare_play'.
- bp: means 'bare_play'.
- clone-play: means 'clone_play'.
- cp: means 'clone_play'.
- rc: means 'repo_chk'.
- repo-check: means 'repo_chk'.
- repo-chk: means 'repo_chk'.
- sp: means 'sync_play'.
- sub-help: means 'aliases'.
- sync-play: means 'sync_play'.
~~~~

~~~ sh
git-deck help git-deck
~~~

~~~~ text
sub command(s) here:
- bare-play: means 'bare_play'.
- bp: means 'bare_play'.
- clone-play: means 'clone_play'.
- cp: means 'clone_play'.
- rc: means 'repo_chk'.
- repo-check: means 'repo_chk'.
- repo-chk: means 'repo_chk'.
- sp: means 'sync_play'.
- sub-help: means 'aliases'.
- sync-play: means 'sync_play'.

your command: git-deck

The *Git Deck Aides* is an assistant for git to give levers/wheels with its helpdocs
 It's also a demo for `Subs` frame which is a simple helper frame in shell (tested in bash & brush) that can trans alias names
 as function with a helpdocs feature supported.

See help:
- git-deck help
- git-deck help git-deck
- git-deck help gd
- help git-deck
- help gd

~~~~

~~~ sh
help git-deck
~~~

~~~~ text
sub command(s) here:
- gd: means 'git_decks'.
- git-deck: means 'git_decks'.
- git-decks: means 'git_decks'.

your command: git-deck

The *Git Deck Aides* is an assistant for git to give levers/wheels with its helpdocs
 It's also a demo for `Subs` frame which is a simple helper frame in shell (tested in bash & brush) that can trans alias names
 as function with a helpdocs feature supported.

See help:
- git-deck help
- git-deck help git-deck
- git-deck help gd
- help git-deck
- help gd

~~~~

~~~ sh
help gd
~~~

~~~~ text
sub command(s) here:
- gd: means 'git_decks'.
- git-deck: means 'git_decks'.
- git-decks: means 'git_decks'.

your command: gd

The *Git Deck Aides* is an assistant for git to give levers/wheels with its helpdocs
 It's also a demo for `Subs` frame which is a simple helper frame in shell (tested in bash & brush) that can trans alias names
 as function with a helpdocs feature supported.

See help:
- git-deck help
- git-deck help git-deck
- git-deck help gd
- help git-deck
- help gd

~~~~

~~~ sh
. ~/git-deck.sh ; help git-deck
~~~

~~~~ text
sub command(s) here:
- gd: means 'git_decks'.
- git-deck: means 'git_decks'.
- git-decks: means 'git_decks'.

your command: git-deck

The *Git Deck Aides* is an assistant for git to give levers/wheels with its helpdocs.
 It's also a demo for `Subs` frame which is a simple helper frame in shell (tested in bash & brush) that can trans alias names
 as function with a helpdocs feature supported.

See help:
- git-deck help
- git-deck help git-deck
- git-deck help gd
- help git-deck
- help gd

~~~~

#### `help : true false`

~~~ sh
. ~/git-deck.sh && help :
~~~

~~~~ text
:: :
	Null command.
	
	No effect; the command does nothing.
	
	Exit Status:
	Always succeeds.
~~~~

~~~ sh
. ~/git-deck.sh ; help true ; help false
~~~

~~~~ text
true: true
	Return a successful result.
	
	Exit Status:
	Always succeeds.
false: false
	Return an unsuccessful result.
	
	Exit Status:
	Always fails.
~~~~

#### `help cp ac`

~~~ sh
git-deck help cp ac
~~~

~~~~ text
sub command(s) here:
- bare-play: means 'bare_play'.
- bp: means 'bare_play'.
- clone-play: means 'clone_play'.
- cp: means 'clone_play'.
- rc: means 'repo_chk'.
- repo-check: means 'repo_chk'.
- repo-chk: means 'repo_chk'.
- sp: means 'sync_play'.
- sub-help: means 'aliases'.
- sync-play: means 'sync_play'.

your command: cp ac

Usage:
	 git-deck cp auto-clone [<git-clone-options>] -- <remote-link> [<aim-path>]

This tool is for when you having a bad internet to your
 remote repo. It will making a depth=1 shallow clone at the
 first and then unshallow it, also at the end update it once
 to make your local repo sync the newest records as far as it could.
 All of the downloading works can auto-retry while it failed.

Demo:
- git-deck cp auto-clone https://github.com/LibreService/my_rime.git --mirror
- git-deck cp auto-clone https://github.com/gurecn/YuyanIme.git --mirror
- git-deck cp auto-clone --mirror -- https://github.com/gurecn/YuyanIme.git yuyan.git
- git-deck cp auto-clone --mirror -- https://github.com/crynta/terax-ai.git
- git-deck cp auto-clone -- https://github.com/gopasspw/git-credential-gopass.git ~/gopass-src/git-credential-gopass

See help:
- git-deck help cp auto-clone
- git-deck help cp ac
- git-deck cp help ac

~~~~

#### `help bp up`

~~~ sh
git-deck help bare-play up
~~~

~~~~ text
sub command(s) here:
- bare-play: means 'bare_play'.
- bp: means 'bare_play'.
- clone-play: means 'clone_play'.
- cp: means 'clone_play'.
- rc: means 'repo_chk'.
- repo-check: means 'repo_chk'.
- repo-chk: means 'repo_chk'.
- sp: means 'sync_play'.
- sub-help: means 'aliases'.
- sync-play: means 'sync_play'.

your command: bare-play up
repochk: `/mnt/e/gopass.passwd-srcs/cli/gopass.git` is bare repository ~ true

Using for update bare repo. It will detach worktree dir(s)
 which by branch(es), then remote update in automatically retrying,
 then checkout these worktree dir(s) backing to their branch(es)

Bare dir here MUST in a special named dir like: 'name.comments-src'. And:
- path of worktree dir from branch must be like: 'name.comments-src/tree/<branch-name>'
- path of worktree dir from tag must be like: 'name.comments-src/tags/<tag-name>'

Demo:
- git-deck bare-play up
- git-deck bare-play up origin
- git-deck bare-play up github
- git-deck bare-play up disroot

See help:
- git-deck help bare-play update
- git-deck help bare-play up
- git-deck help bp up
- git-deck bp help up

~~~~

~~~ sh
git-deck help bp up
~~~

~~~~ text
sub command(s) here:
- bare-play: means 'bare_play'.
- bp: means 'bare_play'.
- clone-play: means 'clone_play'.
- cp: means 'clone_play'.
- rc: means 'repo_chk'.
- repo-check: means 'repo_chk'.
- repo-chk: means 'repo_chk'.
- sp: means 'sync_play'.
- sub-help: means 'aliases'.
- sync-play: means 'sync_play'.

your command: bp up
repochk: `/mnt/e/gopass.passwd-srcs/cli/gopass.git` is bare repository ~ true

Using for update bare repo. It will detach worktree dir(s)
 which by branch(es), then remote update in automatically retrying,
 then checkout these worktree dir(s) backing to their branch(es)

Bare dir here MUST in a special named dir like: 'name.comments-src'. And:
- path of worktree dir from branch must be like: 'name.comments-src/tree/<branch-name>'
- path of worktree dir from tag must be like: 'name.comments-src/tags/<tag-name>'

Demo:
- git-deck bare-play up
- git-deck bare-play up origin
- git-deck bare-play up github
- git-deck bare-play up disroot

See help:
- git-deck help bare-play update
- git-deck help bare-play up
- git-deck help bp up
- git-deck bp help up

~~~~

#### `help bp wt`

~~~ sh
git-deck help bp wt
~~~

~~~~ text
sub command(s) here:
- bare-play: means 'bare_play'.
- bp: means 'bare_play'.
- clone-play: means 'clone_play'.
- cp: means 'clone_play'.
- rc: means 'repo_chk'.
- repo-check: means 'repo_chk'.
- repo-chk: means 'repo_chk'.
- sp: means 'sync_play'.
- sub-help: means 'aliases'.
- sync-play: means 'sync_play'.

your command: bp wt
repochk: `/mnt/e/gopass.passwd-srcs/cli/gopass.git` is bare repository ~ true

Using for create/delete worktree(s) of bare repo. It will
 search from branches/tags then run worktree add/remove to those object(s)

Bare dir here MUST in a special named dir like: 'name.comments-src', then:
- the path of worktree dir from branch will be like: 'name.comments-src/tree/<branch-name>'
- the path of worktree dir from tag will be like: 'name.comments-src/tags/<tag-name>'

Demo:
- git-deck bare-play worktree add tree master
- git-deck bare-play worktree rm tree master
- git-deck bare-play worktree add tags v1.0.1
- git-deck bare-play worktree rm tags v1.0.1
- git-deck bare-play wt a tags v1.16.1
- git-deck bare-play wt a tree master

See help:
- git-deck help bare-play worktree
- git-deck help bare-play wt
- git-deck help bp wt
- git-deck bp help wt

~~~~



### Bare

#### `bp up rufus`

~~~ sh
git-deck bare-play up
~~~

~~~~ text
repochk: `/mnt/e/rufus.usbfldr-src/rufus.git` is bare repository ~ true
:: executing: `checkout --detach` in '../tree/master' ::
HEAD is now at eedeaea7 [misc] fix multiple small issues
upper: detached ../tree/master
:: executing: remote update ::
fatal: unable to access 'https://github.com/pbatard/rufus.git/': Recv failure: Connection was reset
tried: 1 for remote update
fatal: unable to access 'https://github.com/pbatard/rufus.git/': Recv failure: Connection was reset
tried: 2 for remote update
fatal: unable to access 'https://github.com/pbatard/rufus.git/': Failed to connect to github.com port 44
3 after 21298 ms: Could not connect to server
tried: 3 for remote update
fatal: unable to access 'https://github.com/pbatard/rufus.git/': Recv failure: Connection was reset
tried: 4 for remote update
fatal: unable to access 'https://github.com/pbatard/rufus.git/': Failed to connect to github.com port 44
3 after 21361 ms: Could not connect to server
tried: 5 for remote update
fatal: unable to access 'https://github.com/pbatard/rufus.git/': Failed to connect to github.com port 44
3 after 21605 ms: Could not connect to server
tried: 6 for remote update
fatal: unable to access 'https://github.com/pbatard/rufus.git/': Recv failure: Connection was reset
tried: 7 for remote update
fatal: unable to access 'https://github.com/pbatard/rufus.git/': Failed to connect to github.com port 44
3 after 21470 ms: Could not connect to server
tried: 8 for remote update
fatal: unable to access 'https://github.com/pbatard/rufus.git/': Failed to connect to github.com port 44
3 after 21588 ms: Could not connect to server
tried: 9 for remote update
fatal: unable to access 'https://github.com/pbatard/rufus.git/': Failed to connect to github.com port 44
3 after 21308 ms: Could not connect to server
tried: 10 for remote update
fatal: unable to access 'https://github.com/pbatard/rufus.git/': Failed to connect to github.com port 44
3 after 21336 ms: Could not connect to server
tried: 11 for remote update
upper: updated in '.../rufus.usbfldr-src/rufus.git' for remote(s)
:: executing: `checkout master` in '../tree/master' ::
Switched to branch 'master'
upper: checkouted ../tree/master as master
~~~~

#### `bp wt gopass`

~~~ sh
git-deck bp wt a tags v1.61.1
~~~

~~~~ text
repochk: `/mnt/e/gopass.passwd-srcs/cli/gopass.git` is bare repository ~ true
Contained tags:
error: malformed object name v1.61.1
$ echo $?
129
~~~~

~~~ sh
CHOOSE_MODE=All git-deck bp wt a tags v1.16.1
#|	repochk: `/mnt/e/gopass.passwd-srcs/cli/gopass.git` is bare repository ~ true
#|	Contained tags:
#|	-	v1.16.1
#|	-	v1.17.0-rc.1
#|	-	v1.17.0-rc.2
#|	Choosed branches (choose mode: All):
#|	-	v1.16.1
#|	-	v1.17.0-rc.1
#|	-	v1.17.0-rc.2
#|	:: executing: worktree add ../tags/v1.16.1 v1.16.1 ::
#|	Preparing worktree (detached HEAD f4bb1ded)
#|	Updating files: 100% (652/652), done.
#|	HEAD is now at f4bb1ded Tag v1.16.1 (#3304)
#|	../tags/v1.16.1/
#|	:: executing: worktree add ../tags/v1.17.0-rc.1 v1.17.0-rc.1 ::
#|	Preparing worktree (detached HEAD bacb2454)
#|	Updating files: 100% (687/687), done.
#|	HEAD is now at bacb2454 Tag v1.17.0-rc.1
#|	../tags/v1.16.1/
#|	../tags/v1.17.0-rc.1/
#|	:: executing: worktree add ../tags/v1.17.0-rc.2 v1.17.0-rc.2 ::
#|	Preparing worktree (detached HEAD d28b405b)
#|	Updating files: 100% (697/697), done.
#|	HEAD is now at d28b405b Tag v1.17.0-rc.2
#|	../tags/v1.16.1/
#|	../tags/v1.17.0-rc.1/
#|	../tags/v1.17.0-rc.2/

CHOOSE_MODE=All git-deck bp wt x tags v1.16.1
#|	repochk: `/mnt/e/gopass.passwd-srcs/cli/gopass.git` is bare repository ~ true
#|	Contained tags:
#|	-	v1.16.1
#|	-	v1.17.0-rc.1
#|	-	v1.17.0-rc.2
#|	Choosed tags (choose mode: All):
#|	-	v1.16.1
#|	-	v1.17.0-rc.1
#|	-	v1.17.0-rc.2
#|	:: executing: worktree remove ../tags/v1.16.1 ::
#|	../tags/v1.17.0-rc.1/
#|	../tags/v1.17.0-rc.2/
#|	:: executing: worktree remove ../tags/v1.17.0-rc.1 ::
#|	../tags/v1.17.0-rc.2/
#|	:: executing: worktree remove ../tags/v1.17.0-rc.2 ::
#|	ls: cannot access '../tags/*': No such file or directory
~~~

~~~ sh
CHOOSE_MODE=Only git-deck bp wt a tags v1.16.1
#|	repochk: `/mnt/e/gopass.passwd-srcs/cli/gopass.git` is bare repository ~ true
#|	Contained tags:
#|	-	v1.16.1
#|	-	v1.17.0-rc.1
#|	-	v1.17.0-rc.2
#|	Choosed tags (choose mode: Only):
#|	-	v1.16.1
#|	:: executing: worktree add ../tags/v1.16.1 v1.16.1 ::
#|	Preparing worktree (detached HEAD f4bb1ded)
#|	Updating files: 100% (652/652), done.
#|	HEAD is now at f4bb1ded Tag v1.16.1 (#3304)
#|	../tags/v1.16.1/

git-deck bp wt a tree master
#|	repochk: `/mnt/e/gopass.passwd-srcs/cli/gopass.git` is bare repository ~ true
#|	Contained branches:
#|	-	master
#|	:: executing: worktree add ../tree/master master ::
#|	Preparing worktree (checking out 'master')
#|	Updating files: 100% (697/697), done.
#|	HEAD is now at f25fc7b4 fix: restore clip flag through fuzzy search in show command (#3466)
#|	../tree/master/
~~~

#### `bp help wt`

~~~ sh
git-deck bp help wt
~~~

~~~~ text
repochk: `/mnt/e/gopass.passwd-srcs/cli/gopass.git` is bare repository ~ true
sub command(s) here:
- sub-help: means 'aliases'.
- up: means 'update'.
- wt: means 'worktree'.

your command: wt

Using for create/delete worktree(s) of bare repo. It will
 search from branches/tags then run worktree add/remove to those object(s)

Bare dir here MUST in a special named dir like: 'name.comments-src', then:
- the path of worktree dir from branch will be like: 'name.comments-src/tree/<branch-name>'
- the path of worktree dir from tag will be like: 'name.comments-src/tags/<tag-name>'

Demo:
- git-deck bare-play worktree add tree master
- git-deck bare-play worktree rm tree master
- git-deck bare-play worktree add tags v1.0.1
- git-deck bare-play worktree rm tags v1.0.1
- git-deck bare-play wt a tags v1.16.1
- git-deck bare-play wt a tree master

See help:
- git-deck help bare-play worktree
- git-deck help bare-play wt
- git-deck help bp wt
- git-deck bp help wt

~~~~

#### `bp wt gopassbridge`

~~~ sh
git-deck bp wt a tree master
~~~

~~~~ text
repochk: `/mnt/e/gopass.passwd-srcs/browser-ext/gopassbridge.git` is bare repository ~ true
Contained branches:
-	dependabot/github_actions/actions/checkout-7
-	dependabot/github_actions/codecov/codecov-action-7
-	dependabot/tools-e50eacec07
-	master
Choosed branches (choose mode: Only):
-	master
:: executing: worktree add ../tree/master master ::
Preparing worktree (checking out 'master')
Updating files: 100% (91/91), done.
HEAD is now at 5da4522 Merge pull request #342 from gopasspw/dependabot/tools-48090d0390
../tree/master/
~~~~

#### `bp wt Xed-Editor`

~~~ sh
git-deck bp wt a tags v3.1.5
~~~

~~~~ text
repochk: `/mnt/e/xed.repoctl.editor.android-src/Xed-Editor.git` is bare repository ~ true
Contained tags:
-	sdk-latest
-	v3.1.5
-	v3.1.7
-	v3.1.8
-	v3.1.9
-	v3.2.1
-	v3.2.3
-	v3.2.4
-	v3.2.5
-	v3.2.6
-	v3.2.7
-	v3.2.9
-	v3.3.1
-	v3.3.2
-	v3.3.3
-	v3.3.4
Choosed tags (choose mode: Only):
-	v3.1.5
:: executing: worktree add ../tags/v3.1.5 v3.1.5 ::
Preparing worktree (detached HEAD 3dd223437)
Updating files: 100% (715/715), done.
HEAD is now at 3dd223437 Update network_security_config.xml
../tags/v3.1.5/
~~~~



### Clone

#### `cp a my_rime`

~~~ sh
git-deck cp auto-clone https://github.com/LibreService/my_rime.git --mirror
~~~

~~~~ text
:: git cloning in shallow (depth 1) mode ::
Cloning into bare repository 'my_rime.git'...
fatal: unable to access 'https://github.com/LibreService/my_rime.git/': Recv failure: Connection was reset
tried: 1 for clone
Cloning into bare repository 'my_rime.git'...
fatal: unable to access 'https://github.com/LibreService/my_rime.git/': Failed to connect to github.com port 443 after 21286 ms: Could not connect to server
tried: 2 for clone
Cloning into bare repository 'my_rime.git'...
fatal: unable to access 'https://github.com/LibreService/my_rime.git/': Failed to connect to github.com port 443 after 21287 ms: Could not connect to server
tried: 3 for clone
Cloning into bare repository 'my_rime.git'...
fatal: unable to access 'https://github.com/LibreService/my_rime.git/': Recv failure: Connection was reset
tried: 4 for clone
Cloning into bare repository 'my_rime.git'...
fatal: unable to access 'https://github.com/LibreService/my_rime.git/': Failed to connect to github.com port 443 after 21308 ms: Could not connect to server
tried: 5 for clone
Cloning into bare repository 'my_rime.git'...
remote: Enumerating objects: 589, done.
remote: Counting objects: 100% (589/589), done.
remote: Compressing objects: 100% (433/433), done.
remote: Total 589 (delta 272), reused 314 (delta 124), pack-reused 0 (from 0)
Receiving objects: 100% (589/589), 63.24 MiB | 9.70 MiB/s, done.
Resolving deltas: 100% (272/272), done.
:: change workdir to `my_rime.git` from `/mnt/e/rimeweb.pwa-src` to unshallow fetch ::
repochk: `/mnt/e/rimeweb.pwa-src/my_rime.git` is shallow repository ~ true
fatal: unable to access 'https://github.com/LibreService/my_rime.git/': Failed to connect to github.com port 443 after 21329 ms: Could not connect to server
tried: 1 for unshallow
fatal: unable to access 'https://github.com/LibreService/my_rime.git/': Failed to connect to github.com port 443 after 21321 ms: Could not connect to server
tried: 2 for unshallow
fatal: unable to access 'https://github.com/LibreService/my_rime.git/': Failed to connect to github.com port 443 after 21291 ms: Could not connect to server
tried: 3 for unshallow
fatal: unable to access 'https://github.com/LibreService/my_rime.git/': Failed to connect to github.com port 443 after 21287 ms: Could not connect to server
tried: 4 for unshallow
fatal: unable to access 'https://github.com/LibreService/my_rime.git/': Failed to connect to github.com port 443 after 21334 ms: Could not connect to server
tried: 5 for unshallow
remote: Enumerating objects: 2436, done.
remote: Counting objects: 100% (1850/1850), done.
remote: Compressing objects: 100% (435/435), done.
remote: Total 1573 (delta 1162), reused 1381 (delta 1058), pack-reused 0 (from 0)
Receiving objects: 100% (1573/1573), 1.58 MiB | 1.31 MiB/s, done.
Resolving deltas: 100% (1162/1162), completed with 122 local objects.
:: updating in `/mnt/e/rimeweb.pwa-src/my_rime.git` ::
:: done for repo `my_rime.git`. ::
~~~~

#### `cp a YuyanIme`

~~~ sh
git-deck cp auto-clone https://github.com/gurecn/YuyanIme.git --mirror
~~~

~~~~ text
:: git cloning in shallow (depth 1) mode ::
Cloning into bare repository 'YuyanIme.git'...
remote: Enumerating objects: 295, done.
remote: Counting objects: 100% (295/295), done.
remote: Compressing objects: 100% (220/220), done.
remote: Total 295 (delta 121), reused 210 (delta 45), pack-reused 0 (from 0)
Receiving objects: 100% (295/295), 1.47 MiB | 18.00 KiB/s, done.
Resolving deltas: 100% (121/121), done.
:: change workdir to `YuyanIme.git` from `/mnt/e/yuyanime.hanzi-src` to unshallow fetch ::
:: unshallowing in `/mnt/e/yuyanime.hanzi-src/YuyanIme.git` ::
repochk: `/mnt/e/yuyanime.hanzi-src/YuyanIme.git` is shallow repository ~ true
remote: Enumerating objects: 1514, done.
remote: Counting objects: 100% (1429/1429), done.
remote: Compressing objects: 100% (777/777), done.
Rremote: Total 1386 (delta 707), reused 1236 (delta 601), pack-reused 0 (from 0)
Receiving objects: 100% (1386/1386), 169.91 KiB | 135.00 KiB/s, done.
Resolving deltas: 100% (707/707), completed with 21 local objects.
:: updating in `/mnt/e/yuyanime.hanzi-src/YuyanIme.git` ::
:: done for repo `YuyanIme.git`. ::
~~~~

#### `cp m`

~~~ sh
. ~/git-deck.sh && OPTS_CLONE=--bare git-deck cp m . mabin.sp-src/mabynogion.spells.git:https://github.com/pure-symbols/mabynogion.spells.git pure.lexi-src/pure.lexicals.git:https://github.com/pure-symbols/pure.lexicals.git :https://github.com/yhm-amber/lang-note.git
~~~

~~~~ text
:: executing: `.decks cp auto-clone --bare -- 'https://github.com/pure-symbols/mabynogion.spells.git' mabin.sp-src/mabynogion.spells.git` in '/mnt/e/repos' ::
:: git cloning in shallow (depth 1) mode ::
Cloning into bare repository 'mabin.sp-src/mabynogion.spells.git'...
remote: Enumerating objects: 80, done.
remote: Counting objects: 100% (80/80), done.
remote: Compressing objects: 100% (73/73), done.
remote: Total 80 (delta 0), reused 38 (delta 0), pack-reused 0 (from 0)
Receiving objects: 100% (80/80), 68.97 KiB | 105.00 KiB/s, done.
:: change workdir to `mabin.sp-src/mabynogion.spells.git` from `/mnt/e/repos` to unshallow fetch ::
:: unshallowing in `/mnt/e/repos/mabin.sp-src/mabynogion.spells.git` ::
repochk: `/mnt/e/repos/mabin.sp-src/mabynogion.spells.git` is shallow repository ~ true
fatal: unable to access 'https://github.com/pure-symbols/mabynogion.spells.git/': Failed to connect to github.com port 443 after 21342 ms: Could not connect to server
tried: 1 for unshallow
remote: Enumerating objects: 710, done.
remote: Counting objects: 100% (710/710), done.
remote: Compressing objects: 100% (387/387), done.
remote: Total 645 (delta 381), reused 455 (delta 248), pack-reused 0 (from 0)
Receiving objects: 100% (645/645), 171.43 KiB | 816.00 KiB/s, done.
Resolving deltas: 100% (381/381), completed with 54 local objects.
From https://github.com/pure-symbols/mabynogion.spells
 * branch            HEAD       -> FETCH_HEAD
:: updating in `/mnt/e/repos/mabin.sp-src/mabynogion.spells.git` ::
repochk: `/mnt/e/repos/mabin.sp-src/mabynogion.spells.git` is inside worktree ~ false
repochk: `/mnt/e/repos/mabin.sp-src/mabynogion.spells.git` is inside gitdir ~ true
repochk: `/mnt/e/repos/mabin.sp-src/mabynogion.spells.git` is bare repository ~ true
base_up: update from remote for '.'
repochk: `/mnt/e/repos/mabin.sp-src/mabynogion.spells.git` is bare repository ~ true
:: executing: remote update ::
From https://github.com/pure-symbols/mabynogion.spells
 * branch            HEAD       -> FETCH_HEAD
upper: updated in '.../mabin.sp-src/mabynogion.spells.git' for remote(s)
base_up: updated in '.'
:: done for repo `mabin.sp-src/mabynogion.spells.git`. ::
:: executing: `.decks cp auto-clone --bare -- 'https://github.com/pure-symbols/pure.lexicals.git' pure.lexi-src/pure.lexicals.git` in '/mnt/e/repos' ::
:: git cloning in shallow (depth 1) mode ::
Cloning into bare repository 'pure.lexi-src/pure.lexicals.git'...
remote: Enumerating objects: 972, done.
remote: Counting objects: 100% (972/972), done.
remote: Compressing objects: 100% (728/728), done.
remote: Total 972 (delta 11), reused 904 (delta 9), pack-reused 0 (from 0)
Receiving objects: 100% (972/972), 50.83 MiB | 104.00 KiB/s, done.
Resolving deltas: 100% (11/11), done.
:: change workdir to `pure.lexi-src/pure.lexicals.git` from `/mnt/e/repos` to unshallow fetch ::
:: unshallowing in `/mnt/e/repos/pure.lexi-src/pure.lexicals.git` ::
repochk: `/mnt/e/repos/pure.lexi-src/pure.lexicals.git` is shallow repository ~ true
remote: Enumerating objects: 13742, done.
remote: Counting objects: 100% (13742/13742), done.
remote: Compressing objects: 100% (4297/4297), done.
remote: Total 13370 (delta 8513), reused 13080 (delta 8304), pack-reused 0 (from 0)
Receiving objects: 100% (13370/13370), 10.43 MiB | 2.63 MiB/s, done.
Resolving deltas: 100% (8513/8513), completed with 182 local objects.
From https://github.com/pure-symbols/pure.lexicals
 * branch            HEAD       -> FETCH_HEAD
:: updating in `/mnt/e/repos/pure.lexi-src/pure.lexicals.git` ::
repochk: `/mnt/e/repos/pure.lexi-src/pure.lexicals.git` is inside worktree ~ false
repochk: `/mnt/e/repos/pure.lexi-src/pure.lexicals.git` is inside gitdir ~ true
repochk: `/mnt/e/repos/pure.lexi-src/pure.lexicals.git` is bare repository ~ true
base_up: update from remote for '.'
repochk: `/mnt/e/repos/pure.lexi-src/pure.lexicals.git` is bare repository ~ true
:: executing: remote update ::
From https://github.com/pure-symbols/pure.lexicals
 * branch            HEAD       -> FETCH_HEAD
upper: updated in '.../pure.lexi-src/pure.lexicals.git' for remote(s)
base_up: updated in '.'
:: done for repo `pure.lexi-src/pure.lexicals.git`. ::
:: executing: `.decks cp auto-clone --bare -- 'https://github.com/yhm-amber/lang-note.git' ` in '/mnt/e/repos' ::
:: git cloning in shallow (depth 1) mode ::
Cloning into bare repository 'lang-note.git'...
remote: Enumerating objects: 279, done.
remote: Counting objects: 100% (279/279), done.
remote: Compressing objects: 100% (215/215), done.
remote: Total 279 (delta 8), reused 239 (delta 4), pack-reused 0 (from 0)
Receiving objects: 100% (279/279), 838.62 KiB | 149.00 KiB/s, done.
Resolving deltas: 100% (8/8), done.
:: change workdir to `lang-note.git` from `/mnt/e/repos` to unshallow fetch ::
:: unshallowing in `/mnt/e/repos/lang-note.git` ::
repochk: `/mnt/e/repos/lang-note.git` is shallow repository ~ true
remote: Enumerating objects: 4105, done.
remote: Counting objects: 100% (4105/4105), done.
remote: Compressing objects: 100% (1590/1590), done.
Rremote: Total 3950 (delta 2295), reused 3772 (delta 2184), pack-reused 0 (from 0)
Receiving objects: 100% (3950/3950), 732.22 KiB | 616.00 KiB/s, done.
Resolving deltas: 100% (2295/2295), completed with 102 local objects.
From https://github.com/yhm-amber/lang-note
 * branch            HEAD       -> FETCH_HEAD
:: updating in `/mnt/e/repos/lang-note.git` ::
repochk: `/mnt/e/repos/lang-note.git` is inside worktree ~ false
repochk: `/mnt/e/repos/lang-note.git` is inside gitdir ~ true
repochk: `/mnt/e/repos/lang-note.git` is bare repository ~ true
base_up: update from remote for '.'
repochk: `/mnt/e/repos/lang-note.git` is bare repository ~ true
:: executing: remote update ::
From https://github.com/yhm-amber/lang-note
 * branch            HEAD       -> FETCH_HEAD
upper: updated in '.../test/lang-note.git' for remote(s)
base_up: updated in '.'
:: done for repo `lang-note.git`. ::
~~~~



### Sync

#### `sp all`

~~~ sh
. ~/git-deck.sh && git-deck sp all-sync
~~~

~~~~ text
:: pulling from origin and all remotes in: ./pure.lexicals/ ::
repochk: `/mnt/e/repos-testing/pure.lexicals` is inside worktree ~ true
repochk: `/mnt/e/repos-testing/pure.lexicals` is bare repository ~ false
base_up: update from remote for './pure.lexicals/'
remote: Enumerating objects: 39, done.
remote: Counting objects: 100% (39/39), done.
remote: Compressing objects: 100% (28/28), done.
remote: Total 28 (delta 18), reused 0 (delta 0), pack-reused 0 (from 0)
Unpacking objects: 100% (28/28), 6.46 KiB | 2.00 KiB/s, done.
From https://github.com/pure-symbols/pure.lexicals
   d536247..8fbcd08  main       -> origin/main
Updating d536247..8fbcd08
Fast-forward
 .notes/sh3rrs/Subs/.demo/git-deck.sh               | 90 ++++++++++++++--------
 .../readme"                                        | 16 +++-
 2 files changed, 75 insertions(+), 31 deletions(-)
base_up: updated in './pure.lexicals/'
:: pulling all remotes in './pure.lexicals/' ::
working: pull from remote 'disroot' for './pure.lexicals/'
POST git-upload-pack (165 bytes)
working: pull from remote 'origin' for './pure.lexicals/'
POST git-upload-pack (165 bytes)
:: pulled all remotes in './pure.lexicals/' ::

:: pushing origin to all remotes in: ./pure.lexicals/ ::
repochk: `/mnt/e/repos-testing/pure.lexicals` is inside worktree ~ true
repochk: `/mnt/e/repos-testing/pure.lexicals` is bare repository ~ false
base_up: update from remote for './pure.lexicals/'
Already up to date.
base_up: updated in './pure.lexicals/'
:: pushing all remotes in './pure.lexicals/' ::
working: push to remote 'disroot' for './pure.lexicals/'
Pushing to https://git.disroot.org/pure.symbols/pure.lexicals.git
Enumerating objects: 468, done.
Counting objects: 100% (468/468), done.
Delta compression using up to 16 threads
Compressing objects: 100% (191/191), done.
Writing objects: 100% (453/453), 132.51 KiB | 2.28 MiB/s, done.
Total 453 (delta 306), reused 398 (delta 261), pack-reused 0 (from 0)
POST git-receive-pack (135873 bytes)
remote: Resolving deltas: 100% (306/306), completed with 11 local objects.
remote: Checking connectivity: 453, done.
To https://git.disroot.org/pure.symbols/pure.lexicals.git
   d89077d..8fbcd08  main -> main
updating local tracking ref 'refs/remotes/disroot/main'
working: push to remote 'origin' for './pure.lexicals/'
Pushing to https://github.com/pure-symbols/pure.lexicals.git
To https://github.com/pure-symbols/pure.lexicals.git
 = [up to date]      main -> main
updating local tracking ref 'refs/remotes/origin/main'
Everything up-to-date
:: pushed all remotes in './pure.lexicals/' ::

:: pulling from origin and all remotes in: ./pure.lexicals.git/ ::
repochk: `/mnt/e/repos-testing/pure.lexicals.git` is inside worktree ~ false
repochk: `/mnt/e/repos-testing/pure.lexicals.git` is inside gitdir ~ true
repochk: `/mnt/e/repos-testing/pure.lexicals.git` is bare repository ~ true
base_up: update from remote for './pure.lexicals.git/'
Fetching origin
remote: Enumerating objects: 32, done.
remote: Counting objects: 100% (32/32), done.
remote: Compressing objects: 100% (21/21), done.
remote: Total 21 (delta 14), reused 0 (delta 0), pack-reused 0 (from 0)
Unpacking objects: 100% (21/21), 4.87 KiB | 2.00 KiB/s, done.
From https://github.com/pure-symbols/pure.lexicals
   1f2f05a..8fbcd08  main       -> main
Fetching disroot
From https://git.disroot.org/pure.symbols/pure.lexicals
   d89077d..8fbcd08  main       -> disroot/main
Fetching dr
From https://git.disroot.org/pure.symbols/pure.lexicals
   d89077d..8fbcd08  main       -> dr/main
base_up: updated in './pure.lexicals.git/'
:: pulling all remotes in './pure.lexicals.git/' ::
working: pull from remote 'disroot' for './pure.lexicals.git/'
POST git-upload-pack (165 bytes)
From https://git.disroot.org/pure.symbols/pure.lexicals
 = [up to date]      main       -> main
 = [up to date]      main       -> disroot/main
working: pull from remote 'dr' for './pure.lexicals.git/'
POST git-upload-pack (165 bytes)
From https://git.disroot.org/pure.symbols/pure.lexicals
 = [up to date]      main       -> main
 = [up to date]      main       -> dr/main
working: pull from remote 'origin' for './pure.lexicals.git/'
POST git-upload-pack (165 bytes)
From https://github.com/pure-symbols/pure.lexicals
 = [up to date]      main       -> main
:: pulled all remotes in './pure.lexicals.git/' ::

:: pushing origin to all remotes in: ./pure.lexicals.git/ ::
repochk: `/mnt/e/repos-testing/pure.lexicals.git` is inside worktree ~ false
repochk: `/mnt/e/repos-testing/pure.lexicals.git` is inside gitdir ~ true
repochk: `/mnt/e/repos-testing/pure.lexicals.git` is bare repository ~ true
base_up: update from remote for './pure.lexicals.git/'
Fetching origin
From https://github.com/pure-symbols/pure.lexicals
 + 8fbcd08...d89077d disroot/main -> disroot/main  (forced update)
Fetching disroot
From https://git.disroot.org/pure.symbols/pure.lexicals
   d89077d..8fbcd08  main       -> disroot/main
Fetching dr
base_up: updated in './pure.lexicals.git/'
:: pushing all remotes in './pure.lexicals.git/' ::
working: push to remote 'disroot' for './pure.lexicals.git/'
Pushing to https://git.disroot.org/pure.symbols/pure.lexicals.git
To https://git.disroot.org/pure.symbols/pure.lexicals.git
 = [up to date]      main -> main
updating local tracking ref 'refs/remotes/disroot/main'
Everything up-to-date
working: push to remote 'dr' for './pure.lexicals.git/'
Pushing to https://git.disroot.org/pure.symbols/pure.lexicals.git
To https://git.disroot.org/pure.symbols/pure.lexicals.git
 = [up to date]      main -> main
updating local tracking ref 'refs/remotes/dr/main'
Everything up-to-date
working: push to remote 'origin' for './pure.lexicals.git/'
fatal: --mirror can't be combined with refspecs
tried: 1 for `git push -v -- origin 'refs/heads/*:refs/heads/*'` in './pure.lexicals.git/'
:: try-asking: How many times you want to retry then ? :: 0
:: try-asking: you inputed '0' as 0.
:: try-asking: rested times of that trying: -1.
:: try-asking: Break.
:: pushed all remotes in './pure.lexicals.git/' ::

~~~~

#### `:flow dbx`

~~~ sh
git-deck cp a https://github.com/t8y2/dbx.git --mirror
#|	:: git cloning in shallow (depth 1) mode ::
#|	Cloning into bare repository 'dbx.git'...
#|	remote: Enumerating objects: 24035, done.
#|	remote: Counting objects: 100% (24035/24035), done.
#|	remote: Compressing objects: 100% (11838/11838), done.
#|	remote: Total 24035 (delta 15543), reused 18741 (delta 10815), pack-reused 0 (from 0)
#|	Receiving objects: 100% (24035/24035), 31.32 MiB | 47.00 KiB/s, done.
#|	Resolving deltas: 100% (15543/15543), done.
#|	:: change workdir to `dbx.git` from `/mnt/e/dbx.sqlclient.ai-src` to unshallow fetch ::
#|	:: unshallowing in `/mnt/e/dbx.sqlclient.ai-src/dbx.git` ::
#|	repochk: `/mnt/e/dbx.sqlclient.ai-src/dbx.git` is shallow repository ~ true
#|	fatal: unable to access 'https://github.com/t8y2/dbx.git/': Recv failure: Connection was reset
#|	tried: 1 for unshallow
#|	remote: Enumerating objects: 29539, done.
#|	remote: Counting objects: 100% (25803/25803), done.
#|	remote: Compressing objects: 100% (14807/14807), done.
#|	error: RPC failed; curl 56 Recv failure: Connection was reset
#|	error: 4027 bytes of body are still expected
#|	fetch-pack: unexpected disconnect while reading sideband packet
#|	fatal: early EOF
#|	fatal: fetch-pack: invalid index-pack output
#|	tried: 2 for unshallow
#|	remote: Enumerating objects: 29558, done.
#|	remote: Counting objects: 100% (25875/25875), done.
#|	remote: Compressing objects: 100% (14815/14815), done.
#|	error: RPC failed; curl 18 transfer closed with outstanding read data remaining
#|	error: 2977 bytes of body are still expected
#|	fetch-pack: unexpected disconnect while reading sideband packet
#|	fatal: early EOF
#|	fatal: fetch-pack: invalid index-pack output
#|	tried: 3 for unshallow
#|	remote: Enumerating objects: 29579, done.
#|	remote: Counting objects: 100% (25887/25887), done.
#|	remote: Compressing objects: 100% (14828/14828), done.
#|	remote: Total 24629 (delta 14265), reused 19298 (delta 9413), pack-reused 0 (from 0)
#|	Receiving objects: 100% (24629/24629), 254.68 MiB | 77.00 KiB/s, done.
#|	Resolving deltas: 100% (14265/14265), completed with 571 local objects.
#|	From https://github.com/t8y2/dbx
#|	 * [new ref]           refs/pull/2155/head  -> refs/pull/2155/head
#|	 * [new ref]           refs/pull/2155/merge -> refs/pull/2155/merge
#|	 * [new ref]           refs/pull/2156/head  -> refs/pull/2156/head
#|	 * [new ref]           refs/pull/2156/merge -> refs/pull/2156/merge
#|	:: updating in `/mnt/e/dbx.sqlclient.ai-src/dbx.git` ::
#|	fatal: unable to access 'https://github.com/t8y2/dbx.git/': Failed to connect to github.com port 443 after 21398 ms: Could not connect to server
#|	tried: 1 for remote update
#|	remote: Enumerating objects: 25, done.
#|	remote: Counting objects: 100% (21/21), done.
#|	remote: Compressing objects: 100% (10/10), done.
#|	remote: Total 25 (delta 12), reused 11 (delta 11), pack-reused 4 (from 1)
#|	Unpacking objects: 100% (25/25), 26.46 KiB | 13.00 KiB/s, done.
#|	From https://github.com/t8y2/dbx
#|	   b951d3a5..7a21f258  main       -> main
#|	:: done for repo `dbx.git`. ::

git-deck bp wt a tags v0.5.41
#|	repochk: `/mnt/e/dbx.sqlclient.ai-src/dbx.git` is bare repository ~ true
#|	Contained tags:
#|	-	agents-latest
#|	-	agents-v0.2.39
#|	-	packages-v0.4.17
#|	-	v0.5.41
#|	Choosed tags (choose mode: Only):
#|	-	v0.5.41
#|	:: executing: worktree add ../tags/v0.5.41 v0.5.41 ::
#|	Preparing worktree (detached HEAD ba872303)
#|	Updating files: 100% (1656/1656), done.
#|	HEAD is now at ba872303 feat(release): bump app version to 0.5.41
#|	../tags/v0.5.41/

git-deck bp wt a tree main
#|	repochk: `/mnt/e/dbx.sqlclient.ai-src/dbx.git` is bare repository ~ true
#|	Contained branches:
#|	-	main
#|	Choosed branches (choose mode: Only):
#|	-	main
#|	:: executing: worktree add ../tree/main main ::
#|	Preparing worktree (checking out 'main')
#|	Updating files: 100% (1656/1656), done.
#|	HEAD is now at 7a21f258 feat(sqlCompletion): support SELECT list expand-all-fields completion (#2155)
#|	../tree/main/

git-deck bp wt x tree main
#|	repochk: `/mnt/e/dbx.sqlclient.ai-src/dbx.git` is bare repository ~ true
#|	Contained branches:
#|	-	main
#|	Choosed branches (choose mode: Only):
#|	-	main
#|	:: executing: worktree remove ../tree/main ::
#|	ls: cannot access '../tree/*': No such file or directory
~~~

#### `:flow deno`

~~~ sh
MAXTRY_ASKING=999 git-deck cp a https://github.com/denoland/deno.git --mirror
#|	:: git cloning in shallow (depth 1) mode ::
#|	Cloning into bare repository 'deno.git'...
#|	remote: Enumerating objects: 307976, done.
#|	remote: Counting objects: 100% (307976/307976), done.
#|	remote: Compressing objects: 100% (107364/107364), done.
#|	remote: Total 307976 (delta 235908), reused 263503 (delta 195704), pack-reused 0 (from 0)
#|	Receiving objects: 100% (307976/307976), 276.69 MiB | 7.17 MiB/s, done.
#|	Resolving deltas: 100% (235908/235908), done.
#|	Checking connectivity: 307976, done.
#|	:: change workdir to `deno.git` from `/mnt/e/deno.denoland.esrt-src` to unshallow fetch ::
#|	:: unshallowing in `/mnt/e/deno.denoland.esrt-src/deno.git` ::
#|	repochk: `/mnt/e/deno.denoland.esrt-src/deno.git` is shallow repository ~ true
#|	remote: Enumerating objects: 460792, done.
#|	remote: Counting objects: 100% (428882/428882), done.
#|	remote: Compressing objects: 100% (234923/234923), done.
#|	remote: Total 422883 (delta 312266), reused 285553 (delta 185975), pack-reused 0 (from 0)
#|	Receiving objects: 100% (422883/422883), 162.64 MiB | 5.07 MiB/s, done.
#|	Resolving deltas: 100% (312266/312266), completed with 3367 local objects.
#|	:: updating in `/mnt/e/deno.denoland.esrt-src/deno.git` ::
#|	repochk: `/mnt/e/deno.denoland.esrt-src/deno.git` is inside worktree ~ false
#|	repochk: `/mnt/e/deno.denoland.esrt-src/deno.git` is inside gitdir ~ true
#|	repochk: `/mnt/e/deno.denoland.esrt-src/deno.git` is bare repository ~ true
#|	base_upgrade: update from remote for '.'
#|	repochk: `/mnt/e/deno.denoland.esrt-src/deno.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	error: RPC failed; curl 56 Recv failure: Connection was reset
#|	error: 19 bytes of body are still expected
#|	fatal: expected flush after ref listing
#|	tried: 1 for remote update
#|	upper: updated in '.../deno.denoland.esrt-src/deno.git' for remote(s)
#|	base_upgrade: updated in '.'
#|	:: done for repo `deno.git`. ::

(cd deno.git && git-deck bp wts i tree:main tags:v2.9.2)
#|	repochk: `/mnt/e/deno.denoland.esrt-src/deno.git` is bare repository ~ true
#|	:: executing: `CHOOSE_MODE='Only' .decks bp worktree add tree main` at '/mnt/e/deno.denoland.esrt-src/deno.git' ::
#|	Contained branches:
#|	-	feat/check-native-tsc
#|	-	feat/graph-aware-lint
#|	-	feat/read-confine-default
#|	-	feat/write-confine-default
#|	-	main
#|	-	prototype/resource-limit-flags
#|	Choosed branches (choose mode: Only):
#|	-	main
#|	:: executing: worktree add ../tree/main main ::
#|	Preparing worktree (checking out 'main')
#|	Updating files: 100% (14505/14505), done.
#|	HEAD is now at 786457cc2b feat: support sync-types without node_modules (#35966)
#|	../tree/main/
#|	:: executing: `CHOOSE_MODE='Only' .decks bp worktree add tags v2.9.2` at '/mnt/e/deno.denoland.esrt-src/deno.git' ::
#|	Contained tags:
#|	-	v2.9.2
#|	Choosed tags (choose mode: Only):
#|	-	v2.9.2
#|	:: executing: worktree add ../tags/v2.9.2 v2.9.2 ::
#|	Preparing worktree (detached HEAD 356c132ed6)
#|	Updating files: 100% (14484/14484), done.
#|	HEAD is now at 356c132ed6 2.9.2 (#35865)
#|	../tags/v2.9.2/
~~~

#### `:flow osquery`

~~~ sh
MAXTRY_ASKING=999 git-deck cp a https://github.com/osquery/osquery.git --mirror
#|	:: git cloning in shallow (depth 1) mode ::
#|	Cloning into bare repository 'osquery.git'...
#|	fatal: unable to access 'https://github.com/osquery/osquery.git/': Recv failure: Connection was reset
#|	tried: 1 for clone
#|	:: try-asking: rested times of that trying: 999.
#|	:: try-asking: Then: 998
#|	Cloning into bare repository 'osquery.git'...
#|	remote: Enumerating objects: 81081, done.
#|	remote: Counting objects: 100% (81081/81081), done.
#|	remote: Compressing objects: 100% (28884/28884), done.
#|	remote: Total 81081 (delta 58491), reused 70239 (delta 49348), pack-reused 0 (from 0)
#|	Receiving objects: 100% (81081/81081), 31.19 MiB | 54.00 KiB/s, done.
#|	Resolving deltas: 100% (58491/58491), done.
#|	:: change workdir to `osquery.git` from `/mnt/e/osquery.sqlsys-src` to unshallow fetch ::
#|	:: unshallowing in `/mnt/e/osquery.sqlsys-src/osquery.git` ::
#|	repochk: `/mnt/e/osquery.sqlsys-src/osquery.git` is shallow repository ~ true
#|	remote: Enumerating objects: 77356, done.
#|	remote: Counting objects: 100% (67172/67172), done.
#|	remote: Compressing objects: 100% (36521/36521), done.
#|	remote: Total 65379 (delta 45613), reused 44511 (delta 27465), pack-reused 0 (from 0)
#|	Receiving objects: 100% (65379/65379), 12.23 MiB | 2.53 MiB/s, done.
#|	Resolving deltas: 100% (45613/45613), completed with 1095 local objects.
#|	:: updating in `/mnt/e/osquery.sqlsys-src/osquery.git` ::
#|	repochk: `/mnt/e/osquery.sqlsys-src/osquery.git` is inside worktree ~ false
#|	repochk: `/mnt/e/osquery.sqlsys-src/osquery.git` is inside gitdir ~ true
#|	repochk: `/mnt/e/osquery.sqlsys-src/osquery.git` is bare repository ~ true
#|	base_up: update from remote for '.'
#|	repochk: `/mnt/e/osquery.sqlsys-src/osquery.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	upper: updated in '.../osquery.sqlsys-src/osquery.git' for remote(s)
#|	base_up: updated in '.'
#|	:: done for repo `osquery.git`. ::

(cd osquery.git && git-deck bp wts i tree:master tags:5.23.1)
#|	repochk: `/mnt/e/osquery.sqlsys-src/osquery.git` is bare repository ~ true
#|	:: executing: `CHOOSE_MODE='Only' .decks bp worktree add tree master` at '/mnt/e/osquery.sqlsys-src/osquery.git' ::
#|	Contained branches:
#|	-	master
#|	Choosed branches (choose mode: Only):
#|	-	master
#|	:: executing: worktree add ../tree/master master ::
#|	Preparing worktree (checking out 'master')
#|	Updating files: 100% (2602/2602), done.
#|	HEAD is now at bf007af07 Update GitHub Actions caching strategy (#8866)
#|	../tree/master/
#|	:: executing: `CHOOSE_MODE='Only' .decks bp worktree add tags 5.23.1` at '/mnt/e/osquery.sqlsys-src/osquery.git' ::
#|	Contained tags:
#|	-	5.23.1
#|	Choosed tags (choose mode: Only):
#|	-	5.23.1
#|	:: executing: worktree add ../tags/5.23.1 5.23.1 ::
#|	Preparing worktree (detached HEAD b7538338f)
#|	Updating files: 100% (2651/2651), done.
#|	HEAD is now at b7538338f Preserve object identifiers in Windows certificates table via subject2/issuer2 (#8963)
#|	../tags/5.23.1/
~~~

#### `:flow .sync`

##### clone

~~~ sh
cd -- /mnt/repos/.syncing
ASKING_MAXTRY=9999 OPTS_CLONE=--bare git-deck cp m . \
	mabin.ls-src/mabynogion.spells.git:https://github.com/pure-symbols/mabynogion.spells.git \
	pure.yph-src/pure.lexicals.git:https://github.com/pure-symbols/pure.lexicals.git \
	pure.symb-grp/pure-symbols.git:https://github.com/pure-symbols/.github.git \
	contain.note-src/container-note.git:https://github.com/yhm-amber/container-note.git \
	lang.note-src/lang-note.git:https://github.com/yhm-amber/lang-note.git \
	sh3rr.sh-src/sh3rr.git:https://github.com/yhm-amber/sh3rr.git \
	yph.m-grp/yhm-amber.git:https://github.com/yhm-amber/yhm-amber.git

#|	:: executing: `.decks cp auto-clone --bare -- 'https://github.com/pure-symbols/mabynogion.spells.git' mabin.ls-src/mabynogion.spells.git` at '/mnt/repos/.syncing' ::
#|	:: git cloning in shallow (depth 1) mode ::
#|	Cloning into bare repository 'mabin.ls-src/mabynogion.spells.git'...
#|	fatal: unable to access 'https://github.com/pure-symbols/mabynogion.spells.git/': Recv failure: Connection was reset
#|	tried: 1 for clone
#|	:: try-asking: rested times of that trying: 9999.
#|	:: try-asking: Then: 9998
#|	Cloning into bare repository 'mabin.ls-src/mabynogion.spells.git'...
#|	fatal: unable to access 'https://github.com/pure-symbols/mabynogion.spells.git/': Recv failure: Connection was reset
#|	tried: 2 for clone
#|	:: try-asking: rested times of that trying: 9998.
#|	:: try-asking: Then: 9997
#|	Cloning into bare repository 'mabin.ls-src/mabynogion.spells.git'...
#|	fatal: unable to access 'https://github.com/pure-symbols/mabynogion.spells.git/': Recv failure: Connection was reset
#|	tried: 3 for clone
#|	:: try-asking: rested times of that trying: 9997.
#|	:: try-asking: Then: 9996
#|	Cloning into bare repository 'mabin.ls-src/mabynogion.spells.git'...
#|	fatal: unable to access 'https://github.com/pure-symbols/mabynogion.spells.git/': Recv failure: Connection was reset
#|	tried: 4 for clone
#|	:: try-asking: rested times of that trying: 9996.
#|	:: try-asking: Then: 9995
#|	Cloning into bare repository 'mabin.ls-src/mabynogion.spells.git'...
#|	fatal: unable to access 'https://github.com/pure-symbols/mabynogion.spells.git/': Failed to connect to github.com port 443 after 21328 ms: Could not connect to server
#|	tried: 5 for clone
#|	:: try-asking: rested times of that trying: 9995.
#|	:: try-asking: Then: 9994
#|	Cloning into bare repository 'mabin.ls-src/mabynogion.spells.git'...
#|	fatal: unable to access 'https://github.com/pure-symbols/mabynogion.spells.git/': Failed to connect to github.com port 443 after 21298 ms: Could not connect to server
#|	tried: 6 for clone
#|	:: try-asking: rested times of that trying: 9994.
#|	:: try-asking: Then: 9993
#|	Cloning into bare repository 'mabin.ls-src/mabynogion.spells.git'...
#|	remote: Enumerating objects: 80, done.
#|	remote: Counting objects: 100% (80/80), done.
#|	remote: Compressing objects: 100% (73/73), done.
#|	remote: Total 80 (delta 0), reused 38 (delta 0), pack-reused 0 (from 0)
#|	Receiving objects: 100% (80/80), 68.97 KiB | 140.00 KiB/s, done.
#|	:: change workdir to `mabin.ls-src/mabynogion.spells.git` from `/mnt/repos/.syncing` to unshallow fetch ::
#|	:: unshallowing in `/mnt/repos/.syncing/mabin.ls-src/mabynogion.spells.git` ::
#|	repochk: `/mnt/repos/.syncing/mabin.ls-src/mabynogion.spells.git` is shallow repository ~ true
#|	remote: Enumerating objects: 710, done.
#|	remote: Counting objects: 100% (710/710), done.
#|	remote: Compressing objects: 100% (387/387), done.
#|	remote: Total 645 (delta 381), reused 455 (delta 248), pack-reused 0 (from 0)
#|	Receiving objects: 100% (645/645), 171.43 KiB | 62.00 KiB/s, done.
#|	Resolving deltas: 100% (381/381), completed with 54 local objects.
#|	From https://github.com/pure-symbols/mabynogion.spells
#|	 * branch            HEAD       -> FETCH_HEAD
#|	:: updating in `/mnt/repos/.syncing/mabin.ls-src/mabynogion.spells.git` ::
#|	repochk: `/mnt/repos/.syncing/mabin.ls-src/mabynogion.spells.git` is inside worktree ~ false
#|	repochk: `/mnt/repos/.syncing/mabin.ls-src/mabynogion.spells.git` is inside gitdir ~ true
#|	repochk: `/mnt/repos/.syncing/mabin.ls-src/mabynogion.spells.git` is bare repository ~ true
#|	base_up: update from remote for '.'
#|	repochk: `/mnt/repos/.syncing/mabin.ls-src/mabynogion.spells.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	From https://github.com/pure-symbols/mabynogion.spells
#|	 * branch            HEAD       -> FETCH_HEAD
#|	upper: updated in '.../mabin.ls-src/mabynogion.spells.git' for remote(s)
#|	base_up: updated in '.'
#|	:: done for repo `mabin.ls-src/mabynogion.spells.git`. ::
#|	
#|	:: executing: `.decks cp auto-clone --bare -- 'https://github.com/pure-symbols/pure.lexicals.git' pure.yph-src/pure.lexicals.git` at '/mnt/repos/.syncing' ::
#|	:: git cloning in shallow (depth 1) mode ::
#|	Cloning into bare repository 'pure.yph-src/pure.lexicals.git'...
#|	remote: Enumerating objects: 972, done.
#|	remote: Counting objects: 100% (972/972), done.
#|	remote: Compressing objects: 100% (728/728), done.
#|	remote: Total 972 (delta 11), reused 904 (delta 9), pack-reused 0 (from 0)
#|	Receiving objects: 100% (972/972), 50.83 MiB | 326.00 KiB/s, done.
#|	Resolving deltas: 100% (11/11), done.
#|	:: change workdir to `pure.yph-src/pure.lexicals.git` from `/mnt/repos/.syncing` to unshallow fetch ::
#|	:: unshallowing in `/mnt/repos/.syncing/pure.yph-src/pure.lexicals.git` ::
#|	repochk: `/mnt/repos/.syncing/pure.yph-src/pure.lexicals.git` is shallow repository ~ true
#|	remote: Enumerating objects: 13770, done.
#|	remote: Counting objects: 100% (13770/13770), done.
#|	remote: Compressing objects: 100% (4325/4325), done.
#|	remote: Total 13398 (delta 8528), reused 13080 (delta 8304), pack-reused 0 (from 0)
#|	Receiving objects: 100% (13398/13398), 10.45 MiB | 4.16 MiB/s, done.
#|	Resolving deltas: 100% (8528/8528), completed with 182 local objects.
#|	From https://github.com/pure-symbols/pure.lexicals
#|	 * branch            HEAD       -> FETCH_HEAD
#|	:: updating in `/mnt/repos/.syncing/pure.yph-src/pure.lexicals.git` ::
#|	repochk: `/mnt/repos/.syncing/pure.yph-src/pure.lexicals.git` is inside worktree ~ false
#|	repochk: `/mnt/repos/.syncing/pure.yph-src/pure.lexicals.git` is inside gitdir ~ true
#|	repochk: `/mnt/repos/.syncing/pure.yph-src/pure.lexicals.git` is bare repository ~ true
#|	base_up: update from remote for '.'
#|	repochk: `/mnt/repos/.syncing/pure.yph-src/pure.lexicals.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	fatal: unable to access 'https://github.com/pure-symbols/pure.lexicals.git/': Failed to connect to github.com port 443 after 22344 ms: Could not connect to server
#|	tried: 1 for remote update
#|	From https://github.com/pure-symbols/pure.lexicals
#|	 * branch            HEAD       -> FETCH_HEAD
#|	upper: updated in '.../pure.yph-src/pure.lexicals.git' for remote(s)
#|	base_up: updated in '.'
#|	:: done for repo `pure.yph-src/pure.lexicals.git`. ::
#|	
#|	:: executing: `.decks cp auto-clone --bare -- 'https://github.com/pure-symbols/.github.git' pure.symb-grp/pure-symbols.git` at '/mnt/repos/.syncing' ::
#|	:: git cloning in shallow (depth 1) mode ::
#|	Cloning into bare repository 'pure.symb-grp/pure-symbols.git'...
#|	remote: Enumerating objects: 87, done.
#|	remote: Counting objects: 100% (87/87), done.
#|	remote: Compressing objects: 100% (75/75), done.
#|	remote: Total 87 (delta 1), reused 53 (delta 1), pack-reused 0 (from 0)
#|	Receiving objects: 100% (87/87), 239.55 KiB | 45.00 KiB/s, done.
#|	Resolving deltas: 100% (1/1), done.
#|	:: change workdir to `pure.symb-grp/pure-symbols.git` from `/mnt/repos/.syncing` to unshallow fetch ::
#|	:: unshallowing in `/mnt/repos/.syncing/pure.symb-grp/pure-symbols.git` ::
#|	repochk: `/mnt/repos/.syncing/pure.symb-grp/pure-symbols.git` is shallow repository ~ true
#|	remote: Enumerating objects: 487, done.
#|	remote: Counting objects: 100% (487/487), done.
#|	remote: Compressing objects: 100% (350/350), done.
#|	remote: Total 466 (delta 162), reused 324 (delta 99), pack-reused 0 (from 0)
#|	Receiving objects: 100% (466/466), 95.89 KiB | 40.00 KiB/s, done.
#|	Resolving deltas: 100% (162/162), completed with 9 local objects.
#|	From https://github.com/pure-symbols/.github
#|	 * branch            HEAD       -> FETCH_HEAD
#|	:: updating in `/mnt/repos/.syncing/pure.symb-grp/pure-symbols.git` ::
#|	repochk: `/mnt/repos/.syncing/pure.symb-grp/pure-symbols.git` is inside worktree ~ false
#|	repochk: `/mnt/repos/.syncing/pure.symb-grp/pure-symbols.git` is inside gitdir ~ true
#|	repochk: `/mnt/repos/.syncing/pure.symb-grp/pure-symbols.git` is bare repository ~ true
#|	base_up: update from remote for '.'
#|	repochk: `/mnt/repos/.syncing/pure.symb-grp/pure-symbols.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	fatal: unable to access 'https://github.com/pure-symbols/.github.git/': Recv failure: Connection was reset
#|	tried: 1 for remote update
#|	From https://github.com/pure-symbols/.github
#|	 * branch            HEAD       -> FETCH_HEAD
#|	upper: updated in '.../pure.symb-grp/pure-symbols.git' for remote(s)
#|	base_up: updated in '.'
#|	:: done for repo `pure.symb-grp/pure-symbols.git`. ::
#|	
#|	:: executing: `.decks cp auto-clone --bare -- 'https://github.com/yhm-amber/container-note.git' contain.note-src/container-note.git` at '/mnt/repos/.syncing' ::
#|	:: git cloning in shallow (depth 1) mode ::
#|	Cloning into bare repository 'contain.note-src/container-note.git'...
#|	remote: Enumerating objects: 5289, done.
#|	remote: Counting objects: 100% (5289/5289), done.
#|	remote: Compressing objects: 100% (2879/2879), done.
#|	remote: Total 5289 (delta 496), reused 5053 (delta 480), pack-reused 0 (from 0)
#|	Receiving objects: 100% (5289/5289), 433.33 MiB | 3.72 MiB/s, done.
#|	Resolving deltas: 100% (496/496), done.
#|	:: change workdir to `contain.note-src/container-note.git` from `/mnt/repos/.syncing` to unshallow fetch ::
#|	:: unshallowing in `/mnt/repos/.syncing/contain.note-src/container-note.git` ::
#|	repochk: `/mnt/repos/.syncing/contain.note-src/container-note.git` is shallow repository ~ true
#|	fatal: unable to access 'https://github.com/yhm-amber/container-note.git/': Recv failure: Connection was reset
#|	tried: 1 for unshallow
#|	fatal: unable to access 'https://github.com/yhm-amber/container-note.git/': Failed to connect to github.com port 443 after 21398 ms: Could not connect to server
#|	tried: 2 for unshallow
#|	fatal: unable to access 'https://github.com/yhm-amber/container-note.git/': Failed to connect to github.com port 443 after 21288 ms: Could not connect to server
#|	tried: 3 for unshallow
#|	fatal: unable to access 'https://github.com/yhm-amber/container-note.git/': Failed to connect to github.com port 443 after 21389 ms: Could not connect to server
#|	tried: 4 for unshallow
#|	remote: Enumerating objects: 25048, done.
#|	remote: Counting objects: 100% (24991/24991), done.
#|	remote: Compressing objects: 100% (9032/9032), done.
#|	remote: Total 24321 (delta 13392), reused 23417 (delta 13056), pack-reused 0 (from 0)
#|	Receiving objects: 100% (24321/24321), 33.07 MiB | 69.00 KiB/s, done.
#|	Resolving deltas: 100% (13392/13392), completed with 163 local objects.
#|	From https://github.com/yhm-amber/container-note
#|	 * branch              HEAD       -> FETCH_HEAD
#|	:: updating in `/mnt/repos/.syncing/contain.note-src/container-note.git` ::
#|	repochk: `/mnt/repos/.syncing/contain.note-src/container-note.git` is inside worktree ~ false
#|	repochk: `/mnt/repos/.syncing/contain.note-src/container-note.git` is inside gitdir ~ true
#|	repochk: `/mnt/repos/.syncing/contain.note-src/container-note.git` is bare repository ~ true
#|	base_up: update from remote for '.'
#|	repochk: `/mnt/repos/.syncing/contain.note-src/container-note.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	fatal: unable to access 'https://github.com/yhm-amber/container-note.git/': Empty reply from server
#|	tried: 1 for remote update
#|	fatal: unable to access 'https://github.com/yhm-amber/container-note.git/': Failed to connect to github.com port 443 after 21338 ms: Could not connect to server
#|	tried: 2 for remote update
#|	fatal: unable to access 'https://github.com/yhm-amber/container-note.git/': Failed to connect to github.com port 443 after 21581 ms: Could not connect to server
#|	tried: 3 for remote update
#|	fatal: unable to access 'https://github.com/yhm-amber/container-note.git/': Recv failure: Connection was reset
#|	tried: 4 for remote update
#|	fatal: unable to access 'https://github.com/yhm-amber/container-note.git/': Recv failure: Connection was reset
#|	tried: 5 for remote update
#|	fatal: unable to access 'https://github.com/yhm-amber/container-note.git/': Failed to connect to github.com port 443 after 21384 ms: Could not connect to server
#|	tried: 6 for remote update
#|	fatal: unable to access 'https://github.com/yhm-amber/container-note.git/': Recv failure: Connection was reset
#|	tried: 7 for remote update
#|	From https://github.com/yhm-amber/container-note
#|	 * branch              HEAD       -> FETCH_HEAD
#|	upper: updated in '.../contain.note-src/container-note.git' for remote(s)
#|	base_up: updated in '.'
#|	:: done for repo `contain.note-src/container-note.git`. ::
#|	
#|	:: executing: `.decks cp auto-clone --bare -- 'https://github.com/yhm-amber/lang-note.git' lang.note-src/lang-note.git` at '/mnt/repos/.syncing' ::
#|	:: git cloning in shallow (depth 1) mode ::
#|	Cloning into bare repository 'lang.note-src/lang-note.git'...
#|	fatal: unable to access 'https://github.com/yhm-amber/lang-note.git/': Failed to connect to github.com port 443 after 21339 ms: Could not connect to server
#|	tried: 1 for clone
#|	:: try-asking: rested times of that trying: 9999.
#|	:: try-asking: Then: 9998
#|	Cloning into bare repository 'lang.note-src/lang-note.git'...
#|	fatal: unable to access 'https://github.com/yhm-amber/lang-note.git/': Failed to connect to github.com port 443 after 21365 ms: Could not connect to server
#|	tried: 2 for clone
#|	:: try-asking: rested times of that trying: 9998.
#|	:: try-asking: Then: 9997
#|	Cloning into bare repository 'lang.note-src/lang-note.git'...
#|	remote: Enumerating objects: 279, done.
#|	remote: Counting objects: 100% (279/279), done.
#|	remote: Compressing objects: 100% (215/215), done.
#|	remote: Total 279 (delta 8), reused 239 (delta 4), pack-reused 0 (from 0)
#|	Receiving objects: 100% (279/279), 839.97 KiB | 360.00 KiB/s, done.
#|	Resolving deltas: 100% (8/8), done.
#|	:: change workdir to `lang.note-src/lang-note.git` from `/mnt/repos/.syncing` to unshallow fetch ::
#|	:: unshallowing in `/mnt/repos/.syncing/lang.note-src/lang-note.git` ::
#|	repochk: `/mnt/repos/.syncing/lang.note-src/lang-note.git` is shallow repository ~ true
#|	fatal: unable to access 'https://github.com/yhm-amber/lang-note.git/': Empty reply from server
#|	tried: 1 for unshallow
#|	remote: Enumerating objects: 4129, done.
#|	remote: Counting objects: 100% (4129/4129), done.
#|	remote: Compressing objects: 100% (1614/1614), done.
#|	remote: Total 3974 (delta 2306), reused 3772 (delta 2184), pack-reused 0 (from 0)
#|	Receiving objects: 100% (3974/3974), 750.11 KiB | 1004.00 KiB/s, done.
#|	Resolving deltas: 100% (2306/2306), completed with 102 local objects.
#|	From https://github.com/yhm-amber/lang-note
#|	 * branch            HEAD       -> FETCH_HEAD
#|	:: updating in `/mnt/repos/.syncing/lang.note-src/lang-note.git` ::
#|	repochk: `/mnt/repos/.syncing/lang.note-src/lang-note.git` is inside worktree ~ false
#|	repochk: `/mnt/repos/.syncing/lang.note-src/lang-note.git` is inside gitdir ~ true
#|	repochk: `/mnt/repos/.syncing/lang.note-src/lang-note.git` is bare repository ~ true
#|	base_up: update from remote for '.'
#|	repochk: `/mnt/repos/.syncing/lang.note-src/lang-note.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	From https://github.com/yhm-amber/lang-note
#|	 * branch            HEAD       -> FETCH_HEAD
#|	upper: updated in '.../lang.note-src/lang-note.git' for remote(s)
#|	base_up: updated in '.'
#|	:: done for repo `lang.note-src/lang-note.git`. ::
#|	
#|	:: executing: `.decks cp auto-clone --bare -- 'https://github.com/yhm-amber/sh3rr.git' sh3rr.sh-src/sh3rr.git` at '/mnt/repos/.syncing' ::
#|	:: git cloning in shallow (depth 1) mode ::
#|	Cloning into bare repository 'sh3rr.sh-src/sh3rr.git'...
#|	fatal: unable to access 'https://github.com/yhm-amber/sh3rr.git/': Failed to connect to github.com port 443 after 21353 ms: Could not connect to server
#|	tried: 1 for clone
#|	:: try-asking: rested times of that trying: 9999.
#|	:: try-asking: Then: 9998
#|	Cloning into bare repository 'sh3rr.sh-src/sh3rr.git'...
#|	fatal: unable to access 'https://github.com/yhm-amber/sh3rr.git/': Failed to connect to github.com port 443 after 21335 ms: Could not connect to server
#|	tried: 2 for clone
#|	:: try-asking: rested times of that trying: 9998.
#|	:: try-asking: Then: 9997
#|	Cloning into bare repository 'sh3rr.sh-src/sh3rr.git'...
#|	fatal: unable to access 'https://github.com/yhm-amber/sh3rr.git/': Failed to connect to github.com port 443 after 21329 ms: Could not connect to server
#|	tried: 3 for clone
#|	:: try-asking: rested times of that trying: 9997.
#|	:: try-asking: Then: 9996
#|	Cloning into bare repository 'sh3rr.sh-src/sh3rr.git'...
#|	fatal: unable to access 'https://github.com/yhm-amber/sh3rr.git/': Failed to connect to github.com port 443 after 21294 ms: Could not connect to server
#|	tried: 4 for clone
#|	:: try-asking: rested times of that trying: 9996.
#|	:: try-asking: Then: 9995
#|	Cloning into bare repository 'sh3rr.sh-src/sh3rr.git'...
#|	remote: Enumerating objects: 58, done.
#|	remote: Counting objects: 100% (58/58), done.
#|	remote: Compressing objects: 100% (43/43), done.
#|	remote: Total 58 (delta 2), reused 19 (delta 2), pack-reused 0 (from 0)
#|	Receiving objects: 100% (58/58), 145.25 KiB | 454.00 KiB/s, done.
#|	Resolving deltas: 100% (2/2), done.
#|	:: change workdir to `sh3rr.sh-src/sh3rr.git` from `/mnt/repos/.syncing` to unshallow fetch ::
#|	:: unshallowing in `/mnt/repos/.syncing/sh3rr.sh-src/sh3rr.git` ::
#|	repochk: `/mnt/repos/.syncing/sh3rr.sh-src/sh3rr.git` is shallow repository ~ true
#|	remote: Enumerating objects: 1116, done.
#|	remote: Counting objects: 100% (1116/1116), done.
#|	remote: Compressing objects: 100% (658/658), done.
#|	remote: Total 1075 (delta 489), reused 838 (delta 340), pack-reused 0 (from 0)
#|	Receiving objects: 100% (1075/1075), 234.76 KiB | 423.00 KiB/s, done.
#|	Resolving deltas: 100% (489/489), completed with 21 local objects.
#|	From https://github.com/yhm-amber/sh3rr
#|	 * branch            HEAD       -> FETCH_HEAD
#|	:: updating in `/mnt/repos/.syncing/sh3rr.sh-src/sh3rr.git` ::
#|	repochk: `/mnt/repos/.syncing/sh3rr.sh-src/sh3rr.git` is inside worktree ~ false
#|	repochk: `/mnt/repos/.syncing/sh3rr.sh-src/sh3rr.git` is inside gitdir ~ true
#|	repochk: `/mnt/repos/.syncing/sh3rr.sh-src/sh3rr.git` is bare repository ~ true
#|	base_up: update from remote for '.'
#|	repochk: `/mnt/repos/.syncing/sh3rr.sh-src/sh3rr.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	fatal: unable to access 'https://github.com/yhm-amber/sh3rr.git/': Failed to connect to github.com port 443 after 21309 ms: Could not connect to server
#|	tried: 1 for remote update
#|	fatal: unable to access 'https://github.com/yhm-amber/sh3rr.git/': Failed to connect to github.com port 443 after 21384 ms: Could not connect to server
#|	tried: 2 for remote update
#|	fatal: unable to access 'https://github.com/yhm-amber/sh3rr.git/': Failed to connect to github.com port 443 after 21288 ms: Could not connect to server
#|	tried: 3 for remote update
#|	From https://github.com/yhm-amber/sh3rr
#|	 * branch            HEAD       -> FETCH_HEAD
#|	upper: updated in '.../sh3rr.sh-src/sh3rr.git' for remote(s)
#|	base_up: updated in '.'
#|	:: done for repo `sh3rr.sh-src/sh3rr.git`. ::
#|	
#|	:: executing: `.decks cp auto-clone --bare -- 'https://github.com/yhm-amber/yhm-amber.git' yph.m-grp/yhm-amber.git` at '/mnt/repos/.syncing' ::
#|	:: git cloning in shallow (depth 1) mode ::
#|	Cloning into bare repository 'yph.m-grp/yhm-amber.git'...
#|	remote: Enumerating objects: 137, done.
#|	remote: Counting objects: 100% (137/137), done.
#|	remote: Compressing objects: 100% (110/110), done.
#|	remote: Total 137 (delta 7), reused 113 (delta 7), pack-reused 0 (from 0)
#|	Receiving objects: 100% (137/137), 50.69 MiB | 76.00 KiB/s, done.
#|	Resolving deltas: 100% (7/7), done.
#|	:: change workdir to `yph.m-grp/yhm-amber.git` from `/mnt/repos/.syncing` to unshallow fetch ::
#|	:: unshallowing in `/mnt/repos/.syncing/yph.m-grp/yhm-amber.git` ::
#|	repochk: `/mnt/repos/.syncing/yph.m-grp/yhm-amber.git` is shallow repository ~ true
#|	fatal: unable to access 'https://github.com/yhm-amber/yhm-amber.git/': Recv failure: Connection was reset
#|	tried: 1 for unshallow
#|	fatal: unable to access 'https://github.com/yhm-amber/yhm-amber.git/': Recv failure: Connection was reset
#|	tried: 2 for unshallow
#|	fatal: unable to access 'https://github.com/yhm-amber/yhm-amber.git/': Failed to connect to github.com port 443 after 21366 ms: Could not connect to server
#|	tried: 3 for unshallow
#|	fatal: unable to access 'https://github.com/yhm-amber/yhm-amber.git/': Failed to connect to github.com port 443 after 21260 ms: Could not connect to server
#|	tried: 4 for unshallow
#|	remote: Enumerating objects: 2631, done.
#|	remote: Counting objects: 100% (2631/2631), done.
#|	remote: Compressing objects: 100% (872/872), done.
#|	remote: Total 2579 (delta 1460), reused 2518 (delta 1413), pack-reused 0 (from 0)
#|	Receiving objects: 100% (2579/2579), 526.21 KiB | 285.00 KiB/s, done.
#|	Resolving deltas: 100% (1460/1460), completed with 33 local objects.
#|	From https://github.com/yhm-amber/yhm-amber
#|	 * branch            HEAD       -> FETCH_HEAD
#|	:: updating in `/mnt/repos/.syncing/yph.m-grp/yhm-amber.git` ::
#|	repochk: `/mnt/repos/.syncing/yph.m-grp/yhm-amber.git` is inside worktree ~ false
#|	repochk: `/mnt/repos/.syncing/yph.m-grp/yhm-amber.git` is inside gitdir ~ true
#|	repochk: `/mnt/repos/.syncing/yph.m-grp/yhm-amber.git` is bare repository ~ true
#|	base_up: update from remote for '.'
#|	repochk: `/mnt/repos/.syncing/yph.m-grp/yhm-amber.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	fatal: unable to access 'https://github.com/yhm-amber/yhm-amber.git/': Failed to connect to github.com port 443 after 21359 ms: Could not connect to server
#|	tried: 1 for remote update
#|	From https://github.com/yhm-amber/yhm-amber
#|	 * branch            HEAD       -> FETCH_HEAD
#|	upper: updated in '.../yph.m-grp/yhm-amber.git' for remote(s)
#|	base_up: updated in '.'
#|	:: done for repo `yph.m-grp/yhm-amber.git`. ::
#|	
~~~

##### add rmts

~~~ sh
git-deck sp rmts a mabin.ls-src/mabynogion.spells.git \
	gh:https://github.com/pure-symbols/mabynogion.spells.git \
	cb:https://codeberg.org/pure-symbols/mabynogion.spells.git \
	dr:https://git.disroot.org/pure.symbols/mabynogion.spells.git \
	fr:https://framagit.org/pure.symbols/mabynogion.spells.git
#|	:: executing: `git remote add  -- gh https://github.com/pure-symbols/mabynogion.spells.git` at '/mnt/repos/.syncing/mabin.ls-src/mabynogion.spells.git' ::
#|	:: executing: `git remote add  -- cb https://codeberg.org/pure-symbols/mabynogion.spells.git` at '/mnt/repos/.syncing/mabin.ls-src/mabynogion.spells.git' ::
#|	:: executing: `git remote add  -- dr https://git.disroot.org/pure.symbols/mabynogion.spells.git` at '/mnt/repos/.syncing/mabin.ls-src/mabynogion.spells.git' ::
#|	:: executing: `git remote add  -- fr https://framagit.org/pure.symbols/mabynogion.spells.git` at '/mnt/repos/.syncing/mabin.ls-src/mabynogion.spells.git' ::
#|	::: Current Remotes Show :::
#|	cb      https://codeberg.org/pure-symbols/mabynogion.spells.git (fetch)
#|	cb      https://codeberg.org/pure-symbols/mabynogion.spells.git (push)
#|	dr      https://git.disroot.org/pure.symbols/mabynogion.spells.git (fetch)
#|	dr      https://git.disroot.org/pure.symbols/mabynogion.spells.git (push)
#|	fr      https://framagit.org/pure.symbols/mabynogion.spells.git (fetch)
#|	fr      https://framagit.org/pure.symbols/mabynogion.spells.git (push)
#|	gh      https://github.com/pure-symbols/mabynogion.spells.git (fetch)
#|	gh      https://github.com/pure-symbols/mabynogion.spells.git (push)
#|	origin  https://github.com/pure-symbols/mabynogion.spells.git (fetch)
#|	origin  https://github.com/pure-symbols/mabynogion.spells.git (push)

git-deck sp rmts a pure.yph-src/pure.lexicals.git \
	gh:https://github.com/pure-symbols/pure.lexicals.git \
	cb:https://codeberg.org/pure-symbols/pure.lexicals.git \
	dr:https://git.disroot.org/pure.symbols/pure.lexicals.git \
	fr:https://framagit.org/pure.symbols/pure.lexicals.git
#|	:: executing: `git remote add  -- gh https://github.com/pure-symbols/pure.lexicals.git` at '/mnt/repos/.syncing/pure.yph-src/pure.lexicals.git' ::
#|	:: executing: `git remote add  -- cb https://codeberg.org/pure-symbols/pure.lexicals.git` at '/mnt/repos/.syncing/pure.yph-src/pure.lexicals.git' ::
#|	:: executing: `git remote add  -- dr https://git.disroot.org/pure.symbols/pure.lexicals.git` at '/mnt/repos/.syncing/pure.yph-src/pure.lexicals.git' ::
#|	:: executing: `git remote add  -- fr https://framagit.org/pure.symbols/pure.lexicals.git` at '/mnt/repos/.syncing/pure.yph-src/pure.lexicals.git' ::
#|	::: Current Remotes Show :::
#|	cb      https://codeberg.org/pure-symbols/pure.lexicals.git (fetch)
#|	cb      https://codeberg.org/pure-symbols/pure.lexicals.git (push)
#|	dr      https://git.disroot.org/pure.symbols/pure.lexicals.git (fetch)
#|	dr      https://git.disroot.org/pure.symbols/pure.lexicals.git (push)
#|	fr      https://framagit.org/pure.symbols/pure.lexicals.git (fetch)
#|	fr      https://framagit.org/pure.symbols/pure.lexicals.git (push)
#|	gh      https://github.com/pure-symbols/pure.lexicals.git (fetch)
#|	gh      https://github.com/pure-symbols/pure.lexicals.git (push)
#|	origin  https://github.com/pure-symbols/pure.lexicals.git (fetch)
#|	origin  https://github.com/pure-symbols/pure.lexicals.git (push)

git-deck sp rmts a pure.symb-grp/pure-symbols.git \
	gh:https://github.com/pure-symbols/.github.git \
	cb:https://codeberg.org/pure-symbols/pure.symbols.git \
	dr:https://git.disroot.org/pure.symbols/pure.symbols.git \
	fr:https://framagit.org/pure.symbols/pure.symbols.git
#|	:: executing: `git remote add  -- gh https://github.com/pure-symbols/.github.git` at '/mnt/repos/.syncing/pure.symb-grp/pure-symbols.git' ::
#|	:: executing: `git remote add  -- cb https://codeberg.org/pure-symbols/pure.symbols.git` at '/mnt/repos/.syncing/pure.symb-grp/pure-symbols.git' ::
#|	:: executing: `git remote add  -- dr https://git.disroot.org/pure.symbols/pure.symbols.git` at '/mnt/repos/.syncing/pure.symb-grp/pure-symbols.git' ::
#|	:: executing: `git remote add  -- fr https://framagit.org/pure.symbols/pure.symbols.git` at '/mnt/repos/.syncing/pure.symb-grp/pure-symbols.git' ::
#|	::: Current Remotes Show :::
#|	cb      https://codeberg.org/pure-symbols/pure.symbols.git (fetch)
#|	cb      https://codeberg.org/pure-symbols/pure.symbols.git (push)
#|	dr      https://git.disroot.org/pure.symbols/pure.symbols.git (fetch)
#|	dr      https://git.disroot.org/pure.symbols/pure.symbols.git (push)
#|	fr      https://framagit.org/pure.symbols/pure.symbols.git (fetch)
#|	fr      https://framagit.org/pure.symbols/pure.symbols.git (push)
#|	gh      https://github.com/pure-symbols/.github.git (fetch)
#|	gh      https://github.com/pure-symbols/.github.git (push)
#|	origin  https://github.com/pure-symbols/.github.git (fetch)
#|	origin  https://github.com/pure-symbols/.github.git (push)

git-deck sp rmts a contain.note-src/container-note.git \
	gh:https://github.com/yhm-amber/container-note.git \
	cb:https://codeberg.org/yhm-ypa/container-note.git \
	dr:https://git.disroot.org/ypayhm/container-note.git \
	fr:https://framagit.org/ypayhm/container-note.git
#|	:: executing: `git remote add  -- gh https://github.com/yhm-amber/container-note.git` at '/mnt/repos/.syncing/contain.note-src/container-note.git' ::
#|	:: executing: `git remote add  -- cb https://codeberg.org/yhm-ypa/container-note.git` at '/mnt/repos/.syncing/contain.note-src/container-note.git' ::
#|	:: executing: `git remote add  -- dr https://git.disroot.org/ypayhm/container-note.git` at '/mnt/repos/.syncing/contain.note-src/container-note.git' ::
#|	:: executing: `git remote add  -- fr https://framagit.org/ypayhm/container-note.git` at '/mnt/repos/.syncing/contain.note-src/container-note.git' ::
#|	::: Current Remotes Show :::
#|	cb      https://codeberg.org/yhm-ypa/container-note.git (fetch)
#|	cb      https://codeberg.org/yhm-ypa/container-note.git (push)
#|	dr      https://git.disroot.org/ypayhm/container-note.git (fetch)
#|	dr      https://git.disroot.org/ypayhm/container-note.git (push)
#|	fr      https://framagit.org/ypayhm/container-note.git (fetch)
#|	fr      https://framagit.org/ypayhm/container-note.git (push)
#|	gh      https://github.com/yhm-amber/container-note.git (fetch)
#|	gh      https://github.com/yhm-amber/container-note.git (push)
#|	origin  https://github.com/yhm-amber/container-note.git (fetch)
#|	origin  https://github.com/yhm-amber/container-note.git (push)

git-deck sp rmts a lang.note-src/lang-note.git \
	gh:https://github.com/yhm-amber/lang-note.git \
	cb:https://codeberg.org/yhm-ypa/lang-note.git \
	dr:https://git.disroot.org/ypayhm/lang-note.git \
	fr:https://framagit.org/ypayhm/lang-note.git
#|	:: executing: `git remote add  -- gh https://github.com/yhm-amber/lang-note.git` at '/mnt/repos/.syncing/lang.note-src/lang-note.git' ::
#|	:: executing: `git remote add  -- cb https://codeberg.org/yhm-ypa/lang-note.git` at '/mnt/repos/.syncing/lang.note-src/lang-note.git' ::
#|	:: executing: `git remote add  -- dr https://git.disroot.org/ypayhm/lang-note.git` at '/mnt/repos/.syncing/lang.note-src/lang-note.git' ::
#|	:: executing: `git remote add  -- fr https://framagit.org/ypayhm/lang-note.git` at '/mnt/repos/.syncing/lang.note-src/lang-note.git' ::
#|	::: Current Remotes Show :::
#|	cb      https://codeberg.org/yhm-ypa/lang-note.git (fetch)
#|	cb      https://codeberg.org/yhm-ypa/lang-note.git (push)
#|	dr      https://git.disroot.org/ypayhm/lang-note.git (fetch)
#|	dr      https://git.disroot.org/ypayhm/lang-note.git (push)
#|	fr      https://framagit.org/ypayhm/lang-note.git (fetch)
#|	fr      https://framagit.org/ypayhm/lang-note.git (push)
#|	gh      https://github.com/yhm-amber/lang-note.git (fetch)
#|	gh      https://github.com/yhm-amber/lang-note.git (push)
#|	origin  https://github.com/yhm-amber/lang-note.git (fetch)
#|	origin  https://github.com/yhm-amber/lang-note.git (push)

git-deck sp rmts a sh3rr.sh-src/sh3rr.git \
	gh:https://github.com/yhm-amber/sh3rr.git \
	cb:https://codeberg.org/yhm-ypa/sh3rr.git \
	dr:https://git.disroot.org/ypayhm/sh3rr.git \
	fr:https://framagit.org/ypayhm/sh3rr.git
#|	:: executing: `git remote add  -- gh https://github.com/yhm-amber/sh3rr.git` at '/mnt/repos/.syncing/sh3rr.sh-src/sh3rr.git' ::
#|	:: executing: `git remote add  -- cb https://codeberg.org/yhm-ypa/sh3rr.git` at '/mnt/repos/.syncing/sh3rr.sh-src/sh3rr.git' ::
#|	:: executing: `git remote add  -- dr https://git.disroot.org/ypayhm/sh3rr.git` at '/mnt/repos/.syncing/sh3rr.sh-src/sh3rr.git' ::
#|	:: executing: `git remote add  -- fr https://framagit.org/ypayhm/sh3rr.git` at '/mnt/repos/.syncing/sh3rr.sh-src/sh3rr.git' ::
#|	::: Current Remotes Show :::
#|	cb      https://codeberg.org/yhm-ypa/sh3rr.git (fetch)
#|	cb      https://codeberg.org/yhm-ypa/sh3rr.git (push)
#|	dr      https://git.disroot.org/ypayhm/sh3rr.git (fetch)
#|	dr      https://git.disroot.org/ypayhm/sh3rr.git (push)
#|	fr      https://framagit.org/ypayhm/sh3rr.git (fetch)
#|	fr      https://framagit.org/ypayhm/sh3rr.git (push)
#|	gh      https://github.com/yhm-amber/sh3rr.git (fetch)
#|	gh      https://github.com/yhm-amber/sh3rr.git (push)
#|	origin  https://github.com/yhm-amber/sh3rr.git (fetch)
#|	origin  https://github.com/yhm-amber/sh3rr.git (push)

git-deck sp rmts a yph.m-grp/yhm-amber.git \
	gh:https://github.com/yhm-amber/yhm-amber.git \
	cb:https://codeberg.org/yhm-ypa/yhm-ypa.git \
	dr:https://git.disroot.org/ypayhm/ypayhm.git \
	fr:https://framagit.org/ypayhm/ypayhm.git
#|	:: executing: `git remote add  -- gh https://github.com/yhm-amber/yhm-amber.git` at '/mnt/repos/.syncing/yph.m-grp/yhm-amber.git' ::
#|	:: executing: `git remote add  -- cb https://codeberg.org/yhm-ypa/yhm-ypa.git` at '/mnt/repos/.syncing/yph.m-grp/yhm-amber.git' ::
#|	:: executing: `git remote add  -- dr https://git.disroot.org/ypayhm/ypayhm.git` at '/mnt/repos/.syncing/yph.m-grp/yhm-amber.git' ::
#|	:: executing: `git remote add  -- fr https://framagit.org/ypayhm/ypayhm.git` at '/mnt/repos/.syncing/yph.m-grp/yhm-amber.git' ::
#|	::: Current Remotes Show :::
#|	cb      https://codeberg.org/yhm-ypa/yhm-ypa.git (fetch)
#|	cb      https://codeberg.org/yhm-ypa/yhm-ypa.git (push)
#|	dr      https://git.disroot.org/ypayhm/ypayhm.git (fetch)
#|	dr      https://git.disroot.org/ypayhm/ypayhm.git (push)
#|	fr      https://framagit.org/ypayhm/ypayhm.git (fetch)
#|	fr      https://framagit.org/ypayhm/ypayhm.git (push)
#|	gh      https://github.com/yhm-amber/yhm-amber.git (fetch)
#|	gh      https://github.com/yhm-amber/yhm-amber.git (push)
#|	origin  https://github.com/yhm-amber/yhm-amber.git (fetch)
#|	origin  https://github.com/yhm-amber/yhm-amber.git (push)
~~~

##### test & fix

~~~ sh
git-deck sp all-sync *
#|	:: pulling from origin and all remotes in: contain.note-src/container-note.git/ ::
#|	repochk: `/mnt/repos/.syncing/contain.note-src/container-note.git` is inside worktree ~ false
#|	repochk: `/mnt/repos/.syncing/contain.note-src/container-note.git` is inside gitdir ~ true
#|	repochk: `/mnt/repos/.syncing/contain.note-src/container-note.git` is bare repository ~ true
#|	base_upgrade: update from remote for 'contain.note-src/container-note.git/'
#|	repochk: `/mnt/repos/.syncing/contain.note-src/container-note.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	Fetching origin
#|	From https://github.com/yhm-amber/container-note
#|	 * branch              HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	fatal: unable to access 'https://github.com/yhm-amber/container-note.git/': Recv failure: Connection was reset
#|	error: could not fetch gh
#|	Fetching cb
#|	From https://codeberg.org/yhm-ypa/container-note
#|	 * [new branch]        main       -> cb/main
#|	Fetching dr
#|	From https://git.disroot.org/ypayhm/container-note
#|	 * [new branch]        main       -> dr/main
#|	Fetching fr
#|	fatal: unable to access 'https://framagit.org/ypayhm/container-note.git/': Failed to connect to framagit.org port 443 after 21371 ms: Could not connect to server
#|	error: could not fetch fr
#|	tried: 1 for remote update
#|	Fetching origin
#|	From https://github.com/yhm-amber/container-note
#|	 * branch              HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	From https://github.com/yhm-amber/container-note
#|	 * [new branch]        main       -> gh/main
#|	Fetching cb
#|	Fetching dr
#|	Fetching fr
#|	fatal: unable to access 'https://framagit.org/ypayhm/container-note.git/': Failed to connect to framagit.org port 443 after 21338 ms: Could not connect to server
#|	error: could not fetch fr
#|	tried: 2 for remote update
#|	Fetching origin
#|	From https://github.com/yhm-amber/container-note
#|	 * branch              HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	fatal: unable to access 'https://github.com/yhm-amber/container-note.git/': Failed to connect to github.com port 443 after 21272 ms: Could not connect to server
#|	error: could not fetch gh
#|	Fetching cb
#|	Fetching dr
#|	Fetching fr
#|	fatal: unable to access 'https://framagit.org/ypayhm/container-note.git/': Failed to connect to framagit.org port 443 after 21664 ms: Could not connect to server
#|	error: could not fetch fr
#|	tried: 3 for remote update
#|	Fetching origin
#|	From https://github.com/yhm-amber/container-note
#|	 * branch              HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	fatal: unable to access 'https://github.com/yhm-amber/container-note.git/': Failed to connect to github.com port 443 after 21295 ms: Could not connect to server
#|	error: could not fetch gh
#|	Fetching cb
#|	Fetching dr
#|	Fetching fr
#|	fatal: unable to access 'https://framagit.org/ypayhm/container-note.git/': Failed to connect to framagit.org port 443 after 21316 ms: Could not connect to server
#|	error: could not fetch fr
#|	tried: 4 for remote update
#|	Fetching origin
#|	fatal: unable to access 'https://github.com/yhm-amber/container-note.git/': Failed to connect to github.com port 443 after 21289 ms: Could not connect to server
#|	error: could not fetch origin
#|	Fetching gh
#|	Fetching cb
#|	Fetching dr
#|	Fetching fr
#|	fatal: unable to access 'https://framagit.org/ypayhm/container-note.git/': Failed to connect to framagit.org port 443 after 21352 ms: Could not connect to server
#|	error: could not fetch fr
#|	tried: 5 for remote update
#|	Fetching origin
#|	fatal: unable to access 'https://github.com/yhm-amber/container-note.git/': Failed to connect to github.com port 443 after 21341 ms: Could not connect to server
#|	error: could not fetch origin
#|	Fetching gh
#| ^C

{
	git-deck sp rmts x mabin.ls-src/mabynogion.spells.git fr
	git-deck sp rmts x pure.yph-src/pure.lexicals.git fr
	git-deck sp rmts x pure.symb-grp/pure-symbols.git fr
	git-deck sp rmts x contain.note-src/container-note.git fr
	git-deck sp rmts x lang.note-src/lang-note.git fr
	git-deck sp rmts x sh3rr.sh-src/sh3rr.git fr
	git-deck sp rmts x yph.m-grp/yhm-amber.git fr
}
#|	:: executing: `git remote remove  -- fr ` at '/mnt/repos/.syncing/mabin.ls-src/mabynogion.spells.git' ::
#|	::: Current Remotes Show :::
#|	cb      https://codeberg.org/pure-symbols/mabynogion.spells.git (fetch)
#|	cb      https://codeberg.org/pure-symbols/mabynogion.spells.git (push)
#|	dr      https://git.disroot.org/pure.symbols/mabynogion.spells.git (fetch)
#|	dr      https://git.disroot.org/pure.symbols/mabynogion.spells.git (push)
#|	gh      https://github.com/pure-symbols/mabynogion.spells.git (fetch)
#|	gh      https://github.com/pure-symbols/mabynogion.spells.git (push)
#|	origin  https://github.com/pure-symbols/mabynogion.spells.git (fetch)
#|	origin  https://github.com/pure-symbols/mabynogion.spells.git (push)
#|	
#|	:: executing: `git remote remove  -- fr ` at '/mnt/repos/.syncing/pure.yph-src/pure.lexicals.git' ::
#|	::: Current Remotes Show :::
#|	cb      https://codeberg.org/pure-symbols/pure.lexicals.git (fetch)
#|	cb      https://codeberg.org/pure-symbols/pure.lexicals.git (push)
#|	dr      https://git.disroot.org/pure.symbols/pure.lexicals.git (fetch)
#|	dr      https://git.disroot.org/pure.symbols/pure.lexicals.git (push)
#|	gh      https://github.com/pure-symbols/pure.lexicals.git (fetch)
#|	gh      https://github.com/pure-symbols/pure.lexicals.git (push)
#|	origin  https://github.com/pure-symbols/pure.lexicals.git (fetch)
#|	origin  https://github.com/pure-symbols/pure.lexicals.git (push)
#|	
#|	:: executing: `git remote remove  -- fr ` at '/mnt/repos/.syncing/pure.symb-grp/pure-symbols.git' ::
#|	::: Current Remotes Show :::
#|	cb      https://codeberg.org/pure-symbols/pure.symbols.git (fetch)
#|	cb      https://codeberg.org/pure-symbols/pure.symbols.git (push)
#|	dr      https://git.disroot.org/pure.symbols/pure.symbols.git (fetch)
#|	dr      https://git.disroot.org/pure.symbols/pure.symbols.git (push)
#|	gh      https://github.com/pure-symbols/.github.git (fetch)
#|	gh      https://github.com/pure-symbols/.github.git (push)
#|	origin  https://github.com/pure-symbols/.github.git (fetch)
#|	origin  https://github.com/pure-symbols/.github.git (push)
#|	
#|	:: executing: `git remote remove  -- fr ` at '/mnt/repos/.syncing/contain.note-src/container-note.git' ::
#|	::: Current Remotes Show :::
#|	cb      https://codeberg.org/yhm-ypa/container-note.git (fetch)
#|	cb      https://codeberg.org/yhm-ypa/container-note.git (push)
#|	dr      https://git.disroot.org/ypayhm/container-note.git (fetch)
#|	dr      https://git.disroot.org/ypayhm/container-note.git (push)
#|	gh      https://github.com/yhm-amber/container-note.git (fetch)
#|	gh      https://github.com/yhm-amber/container-note.git (push)
#|	origin  https://github.com/yhm-amber/container-note.git (fetch)
#|	origin  https://github.com/yhm-amber/container-note.git (push)
#|	
#|	:: executing: `git remote remove  -- fr ` at '/mnt/repos/.syncing/lang.note-src/lang-note.git' ::
#|	::: Current Remotes Show :::
#|	cb      https://codeberg.org/yhm-ypa/lang-note.git (fetch)
#|	cb      https://codeberg.org/yhm-ypa/lang-note.git (push)
#|	dr      https://git.disroot.org/ypayhm/lang-note.git (fetch)
#|	dr      https://git.disroot.org/ypayhm/lang-note.git (push)
#|	gh      https://github.com/yhm-amber/lang-note.git (fetch)
#|	gh      https://github.com/yhm-amber/lang-note.git (push)
#|	origin  https://github.com/yhm-amber/lang-note.git (fetch)
#|	origin  https://github.com/yhm-amber/lang-note.git (push)
#|	
#|	:: executing: `git remote remove  -- fr ` at '/mnt/repos/.syncing/sh3rr.sh-src/sh3rr.git' ::
#|	::: Current Remotes Show :::
#|	cb      https://codeberg.org/yhm-ypa/sh3rr.git (fetch)
#|	cb      https://codeberg.org/yhm-ypa/sh3rr.git (push)
#|	dr      https://git.disroot.org/ypayhm/sh3rr.git (fetch)
#|	dr      https://git.disroot.org/ypayhm/sh3rr.git (push)
#|	gh      https://github.com/yhm-amber/sh3rr.git (fetch)
#|	gh      https://github.com/yhm-amber/sh3rr.git (push)
#|	origin  https://github.com/yhm-amber/sh3rr.git (fetch)
#|	origin  https://github.com/yhm-amber/sh3rr.git (push)
#|	
#|	:: executing: `git remote remove  -- fr ` at '/mnt/repos/.syncing/yph.m-grp/yhm-amber.git' ::
#|	::: Current Remotes Show :::
#|	cb      https://codeberg.org/yhm-ypa/yhm-ypa.git (fetch)
#|	cb      https://codeberg.org/yhm-ypa/yhm-ypa.git (push)
#|	dr      https://git.disroot.org/ypayhm/ypayhm.git (fetch)
#|	dr      https://git.disroot.org/ypayhm/ypayhm.git (push)
#|	gh      https://github.com/yhm-amber/yhm-amber.git (fetch)
#|	gh      https://github.com/yhm-amber/yhm-amber.git (push)
#|	origin  https://github.com/yhm-amber/yhm-amber.git (fetch)
#|	origin  https://github.com/yhm-amber/yhm-amber.git (push)
#|	
~~~

##### daily

~~~ sh
git-deck sp all-sync * #: comment: old ver with no necessity check.

#|	:: pulling from origin and all remotes in: contain.note-src/container-note.git/ ::
#|	repochk: `/mnt/repos/.syncing/contain.note-src/container-note.git` is inside worktree ~ false
#|	repochk: `/mnt/repos/.syncing/contain.note-src/container-note.git` is inside gitdir ~ true
#|	repochk: `/mnt/repos/.syncing/contain.note-src/container-note.git` is bare repository ~ true
#|	base_upgrade: update from remote for 'contain.note-src/container-note.git/'
#|	repochk: `/mnt/repos/.syncing/contain.note-src/container-note.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	Fetching origin
#|	From https://github.com/yhm-amber/container-note
#|	 * branch              HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	Fetching cb
#|	Fetching dr
#|	upper: updated in '.../contain.note-src/container-note.git' for remote(s)
#|	base_upgrade: updated in 'contain.note-src/container-note.git/'
#|	:: pulling all remotes in 'contain.note-src/container-note.git/' ::
#|	working: pull from remote 'cb' for 'contain.note-src/container-note.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://codeberg.org/yhm-ypa/container-note
#|	 ! [rejected]          main       -> main  (non-fast-forward)
#|	 = [up to date]        main       -> cb/main
#|	tried: 1 for `git fetch -v -- cb 'refs/heads/*:refs/heads/*'` in 'contain.note-src/container-note.git/'
#|	:: try-asking: How many times you want to retry then ? :: 0
#|	:: try-asking: you inputed '0' as 0.
#|	:: try-asking: rested times of that trying: -1.
#|	:: try-asking: Break.
#|	working: pull from remote 'dr' for 'contain.note-src/container-note.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://git.disroot.org/ypayhm/container-note
#|	 ! [rejected]          main       -> main  (non-fast-forward)
#|	 = [up to date]        main       -> dr/main
#|	tried: 2 for `git fetch -v -- dr 'refs/heads/*:refs/heads/*'` in 'contain.note-src/container-note.git/'
#|	:: try-asking: How many times you want to retry then ? :: 0
#|	:: try-asking: you inputed '0' as 0.
#|	:: try-asking: rested times of that trying: -1.
#|	:: try-asking: Break.
#|	working: pull from remote 'gh' for 'contain.note-src/container-note.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://github.com/yhm-amber/container-note
#|	 = [up to date]        main       -> main
#|	 = [up to date]        main       -> gh/main
#|	working: pull from remote 'origin' for 'contain.note-src/container-note.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://github.com/yhm-amber/container-note
#|	 = [up to date]        main       -> main
#|	:: pulled all remotes in 'contain.note-src/container-note.git/' ::
#|	
#|	:: pushing origin to all remotes in: contain.note-src/container-note.git/ ::
#|	repochk: `/mnt/repos/.syncing/contain.note-src/container-note.git` is inside worktree ~ false
#|	repochk: `/mnt/repos/.syncing/contain.note-src/container-note.git` is inside gitdir ~ true
#|	repochk: `/mnt/repos/.syncing/contain.note-src/container-note.git` is bare repository ~ true
#|	base_upgrade: update from remote for 'contain.note-src/container-note.git/'
#|	repochk: `/mnt/repos/.syncing/contain.note-src/container-note.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	Fetching origin
#|	From https://github.com/yhm-amber/container-note
#|	 * branch              HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	Fetching cb
#|	Fetching dr
#|	upper: updated in '.../contain.note-src/container-note.git' for remote(s)
#|	base_upgrade: updated in 'contain.note-src/container-note.git/'
#|	:: pushing all remotes in 'contain.note-src/container-note.git/' ::
#|	working: push to remote 'cb' for 'contain.note-src/container-note.git/'
#|	Pushing to https://codeberg.org/yhm-ypa/container-note.git
#|	warning: auto-detection of host provider took too long (>2000ms)
#|	warning: see https://aka.ms/gcm/autodetect for more information.
#|	Enumerating objects: 325, done.
#|	Counting objects: 100% (325/325), done.
#|	Delta compression using up to 16 threads
#|	Compressing objects: 100% (141/141), done.
#|	Writing objects: 100% (297/297), 3.93 MiB | 8.04 MiB/s, done.
#|	Total 297 (delta 131), reused 280 (delta 114), pack-reused 0 (from 0)
#|	POST git-receive-pack (4118766 bytes)
#|	remote: Resolving deltas: 100% (131/131), completed with 10 local objects.
#|	To https://codeberg.org/yhm-ypa/container-note.git
#|	   5c573333..45e4dae0  main -> main
#|	updating local tracking ref 'refs/remotes/cb/main'
#|	working: push to remote 'dr' for 'contain.note-src/container-note.git/'
#|	Pushing to https://git.disroot.org/ypayhm/container-note.git
#|	Enumerating objects: 325, done.
#|	Counting objects: 100% (325/325), done.
#|	Delta compression using up to 16 threads
#|	Compressing objects: 100% (141/141), done.
#|	Writing objects: 100% (297/297), 3.93 MiB | 46.77 MiB/s, done.
#|	Total 297 (delta 131), reused 280 (delta 114), pack-reused 0 (from 0)
#|	POST git-receive-pack (4118766 bytes)
#|	remote: Resolving deltas: 100% (131/131), completed with 10 local objects.
#|	remote: Checking connectivity: 296, done.
#|	To https://git.disroot.org/ypayhm/container-note.git
#|	   5c573333..45e4dae0  main -> main
#|	updating local tracking ref 'refs/remotes/dr/main'
#|	working: push to remote 'gh' for 'contain.note-src/container-note.git/'
#|	Pushing to https://github.com/yhm-amber/container-note.git
#|	To https://github.com/yhm-amber/container-note.git
#|	 = [up to date]        main -> main
#|	updating local tracking ref 'refs/remotes/gh/main'
#|	Everything up-to-date
#|	working: push to remote 'origin' for 'contain.note-src/container-note.git/'
#|	Pushing to https://github.com/yhm-amber/container-note.git
#|	To https://github.com/yhm-amber/container-note.git
#|	 = [up to date]        main -> main
#|	Everything up-to-date
#|	:: pushed all remotes in 'contain.note-src/container-note.git/' ::
#|	
#|	:: pulling from origin and all remotes in: lang.note-src/lang-note.git/ ::
#|	repochk: `/mnt/repos/.syncing/lang.note-src/lang-note.git` is inside worktree ~ false
#|	repochk: `/mnt/repos/.syncing/lang.note-src/lang-note.git` is inside gitdir ~ true
#|	repochk: `/mnt/repos/.syncing/lang.note-src/lang-note.git` is bare repository ~ true
#|	base_up: update from remote for 'lang.note-src/lang-note.git/'
#|	repochk: `/mnt/repos/.syncing/lang.note-src/lang-note.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	Fetching origin
#|	From https://github.com/yhm-amber/lang-note
#|	 * branch            HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	From https://github.com/yhm-amber/lang-note
#|	 * [new branch]      main       -> gh/main
#|	Fetching cb
#|	From https://codeberg.org/yhm-ypa/lang-note
#|	 * [new branch]      main       -> cb/main
#|	Fetching dr
#|	From https://git.disroot.org/ypayhm/lang-note
#|	 * [new branch]      main       -> dr/main
#|	upper: updated in '.../lang.note-src/lang-note.git' for remote(s)
#|	base_up: updated in 'lang.note-src/lang-note.git/'
#|	:: pulling all remotes in 'lang.note-src/lang-note.git/' ::
#|	working: pull from remote 'cb' for 'lang.note-src/lang-note.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://codeberg.org/yhm-ypa/lang-note
#|	 = [up to date]      main       -> main
#|	 = [up to date]      main       -> cb/main
#|	working: pull from remote 'dr' for 'lang.note-src/lang-note.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://git.disroot.org/ypayhm/lang-note
#|	 = [up to date]      main       -> main
#|	 = [up to date]      main       -> dr/main
#|	working: pull from remote 'gh' for 'lang.note-src/lang-note.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://github.com/yhm-amber/lang-note
#|	 = [up to date]      main       -> main
#|	 = [up to date]      main       -> gh/main
#|	working: pull from remote 'origin' for 'lang.note-src/lang-note.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://github.com/yhm-amber/lang-note
#|	 = [up to date]      main       -> main
#|	:: pulled all remotes in 'lang.note-src/lang-note.git/' ::
#|	
#|	:: pushing origin to all remotes in: lang.note-src/lang-note.git/ ::
#|	repochk: `/mnt/repos/.syncing/lang.note-src/lang-note.git` is inside worktree ~ false
#|	repochk: `/mnt/repos/.syncing/lang.note-src/lang-note.git` is inside gitdir ~ true
#|	repochk: `/mnt/repos/.syncing/lang.note-src/lang-note.git` is bare repository ~ true
#|	base_up: update from remote for 'lang.note-src/lang-note.git/'
#|	repochk: `/mnt/repos/.syncing/lang.note-src/lang-note.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	Fetching origin
#|	From https://github.com/yhm-amber/lang-note
#|	 * branch            HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	Fetching cb
#|	Fetching dr
#|	upper: updated in '.../lang.note-src/lang-note.git' for remote(s)
#|	base_up: updated in 'lang.note-src/lang-note.git/'
#|	:: pushing all remotes in 'lang.note-src/lang-note.git/' ::
#|	working: push to remote 'cb' for 'lang.note-src/lang-note.git/'
#|	Pushing to https://codeberg.org/yhm-ypa/lang-note.git
#|	To https://codeberg.org/yhm-ypa/lang-note.git
#|	 = [up to date]      main -> main
#|	updating local tracking ref 'refs/remotes/cb/main'
#|	Everything up-to-date
#|	working: push to remote 'dr' for 'lang.note-src/lang-note.git/'
#|	Pushing to https://git.disroot.org/ypayhm/lang-note.git
#|	To https://git.disroot.org/ypayhm/lang-note.git
#|	 = [up to date]      main -> main
#|	updating local tracking ref 'refs/remotes/dr/main'
#|	Everything up-to-date
#|	working: push to remote 'gh' for 'lang.note-src/lang-note.git/'
#|	Pushing to https://github.com/yhm-amber/lang-note.git
#|	To https://github.com/yhm-amber/lang-note.git
#|	 = [up to date]      main -> main
#|	updating local tracking ref 'refs/remotes/gh/main'
#|	Everything up-to-date
#|	working: push to remote 'origin' for 'lang.note-src/lang-note.git/'
#|	Pushing to https://github.com/yhm-amber/lang-note.git
#|	To https://github.com/yhm-amber/lang-note.git
#|	 = [up to date]      main -> main
#|	Everything up-to-date
#|	:: pushed all remotes in 'lang.note-src/lang-note.git/' ::
#|	
#|	:: pulling from origin and all remotes in: mabin.ls-src/mabynogion.spells.git/ ::
#|	repochk: `/mnt/repos/.syncing/mabin.ls-src/mabynogion.spells.git` is inside worktree ~ false
#|	repochk: `/mnt/repos/.syncing/mabin.ls-src/mabynogion.spells.git` is inside gitdir ~ true
#|	repochk: `/mnt/repos/.syncing/mabin.ls-src/mabynogion.spells.git` is bare repository ~ true
#|	base_up: update from remote for 'mabin.ls-src/mabynogion.spells.git/'
#|	repochk: `/mnt/repos/.syncing/mabin.ls-src/mabynogion.spells.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	Fetching origin
#|	From https://github.com/pure-symbols/mabynogion.spells
#|	 * branch            HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	From https://github.com/pure-symbols/mabynogion.spells
#|	 * [new branch]      base       -> gh/base
#|	 * [new branch]      main       -> gh/main
#|	 * [new branch]      myrddin.R  -> gh/myrddin.R
#|	 * [new branch]      tylluan.sh -> gh/tylluan.sh
#|	Fetching cb
#|	From https://codeberg.org/pure-symbols/mabynogion.spells
#|	 * [new branch]      base       -> cb/base
#|	 * [new branch]      main       -> cb/main
#|	 * [new branch]      myrddin.R  -> cb/myrddin.R
#|	 * [new branch]      tylluan.sh -> cb/tylluan.sh
#|	Fetching dr
#|	From https://git.disroot.org/pure.symbols/mabynogion.spells
#|	 * [new branch]      base       -> dr/base
#|	 * [new branch]      main       -> dr/main
#|	 * [new branch]      myrddin.R  -> dr/myrddin.R
#|	 * [new branch]      tylluan.sh -> dr/tylluan.sh
#|	upper: updated in '.../mabin.ls-src/mabynogion.spells.git' for remote(s)
#|	base_up: updated in 'mabin.ls-src/mabynogion.spells.git/'
#|	:: pulling all remotes in 'mabin.ls-src/mabynogion.spells.git/' ::
#|	working: pull from remote 'cb' for 'mabin.ls-src/mabynogion.spells.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://codeberg.org/pure-symbols/mabynogion.spells
#|	 = [up to date]      base       -> base
#|	 = [up to date]      main       -> main
#|	 = [up to date]      myrddin.R  -> myrddin.R
#|	 = [up to date]      tylluan.sh -> tylluan.sh
#|	 = [up to date]      base       -> cb/base
#|	 = [up to date]      main       -> cb/main
#|	 = [up to date]      myrddin.R  -> cb/myrddin.R
#|	 = [up to date]      tylluan.sh -> cb/tylluan.sh
#|	working: pull from remote 'dr' for 'mabin.ls-src/mabynogion.spells.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://git.disroot.org/pure.symbols/mabynogion.spells
#|	 = [up to date]      base       -> base
#|	 = [up to date]      main       -> main
#|	 = [up to date]      myrddin.R  -> myrddin.R
#|	 = [up to date]      tylluan.sh -> tylluan.sh
#|	 = [up to date]      base       -> dr/base
#|	 = [up to date]      main       -> dr/main
#|	 = [up to date]      myrddin.R  -> dr/myrddin.R
#|	 = [up to date]      tylluan.sh -> dr/tylluan.sh
#|	working: pull from remote 'gh' for 'mabin.ls-src/mabynogion.spells.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://github.com/pure-symbols/mabynogion.spells
#|	 = [up to date]      base       -> base
#|	 = [up to date]      main       -> main
#|	 = [up to date]      myrddin.R  -> myrddin.R
#|	 = [up to date]      tylluan.sh -> tylluan.sh
#|	 = [up to date]      base       -> gh/base
#|	 = [up to date]      main       -> gh/main
#|	 = [up to date]      myrddin.R  -> gh/myrddin.R
#|	 = [up to date]      tylluan.sh -> gh/tylluan.sh
#|	working: pull from remote 'origin' for 'mabin.ls-src/mabynogion.spells.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://github.com/pure-symbols/mabynogion.spells
#|	 = [up to date]      base       -> base
#|	 = [up to date]      main       -> main
#|	 = [up to date]      myrddin.R  -> myrddin.R
#|	 = [up to date]      tylluan.sh -> tylluan.sh
#|	:: pulled all remotes in 'mabin.ls-src/mabynogion.spells.git/' ::
#|	
#|	:: pushing origin to all remotes in: mabin.ls-src/mabynogion.spells.git/ ::
#|	repochk: `/mnt/repos/.syncing/mabin.ls-src/mabynogion.spells.git` is inside worktree ~ false
#|	repochk: `/mnt/repos/.syncing/mabin.ls-src/mabynogion.spells.git` is inside gitdir ~ true
#|	repochk: `/mnt/repos/.syncing/mabin.ls-src/mabynogion.spells.git` is bare repository ~ true
#|	base_up: update from remote for 'mabin.ls-src/mabynogion.spells.git/'
#|	repochk: `/mnt/repos/.syncing/mabin.ls-src/mabynogion.spells.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	Fetching origin
#|	From https://github.com/pure-symbols/mabynogion.spells
#|	 * branch            HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	Fetching cb
#|	Fetching dr
#|	upper: updated in '.../mabin.ls-src/mabynogion.spells.git' for remote(s)
#|	base_up: updated in 'mabin.ls-src/mabynogion.spells.git/'
#|	:: pushing all remotes in 'mabin.ls-src/mabynogion.spells.git/' ::
#|	working: push to remote 'cb' for 'mabin.ls-src/mabynogion.spells.git/'
#|	Pushing to https://codeberg.org/pure-symbols/mabynogion.spells.git
#|	To https://codeberg.org/pure-symbols/mabynogion.spells.git
#|	 = [up to date]      base -> base
#|	 = [up to date]      main -> main
#|	 = [up to date]      myrddin.R -> myrddin.R
#|	 = [up to date]      tylluan.sh -> tylluan.sh
#|	updating local tracking ref 'refs/remotes/cb/base'
#|	updating local tracking ref 'refs/remotes/cb/main'
#|	updating local tracking ref 'refs/remotes/cb/myrddin.R'
#|	updating local tracking ref 'refs/remotes/cb/tylluan.sh'
#|	Everything up-to-date
#|	working: push to remote 'dr' for 'mabin.ls-src/mabynogion.spells.git/'
#|	Pushing to https://git.disroot.org/pure.symbols/mabynogion.spells.git
#|	To https://git.disroot.org/pure.symbols/mabynogion.spells.git
#|	 = [up to date]      base -> base
#|	 = [up to date]      main -> main
#|	 = [up to date]      myrddin.R -> myrddin.R
#|	 = [up to date]      tylluan.sh -> tylluan.sh
#|	updating local tracking ref 'refs/remotes/dr/base'
#|	updating local tracking ref 'refs/remotes/dr/main'
#|	updating local tracking ref 'refs/remotes/dr/myrddin.R'
#|	updating local tracking ref 'refs/remotes/dr/tylluan.sh'
#|	Everything up-to-date
#|	working: push to remote 'gh' for 'mabin.ls-src/mabynogion.spells.git/'
#|	Pushing to https://github.com/pure-symbols/mabynogion.spells.git
#|	To https://github.com/pure-symbols/mabynogion.spells.git
#|	 = [up to date]      base -> base
#|	 = [up to date]      main -> main
#|	 = [up to date]      myrddin.R -> myrddin.R
#|	 = [up to date]      tylluan.sh -> tylluan.sh
#|	updating local tracking ref 'refs/remotes/gh/base'
#|	updating local tracking ref 'refs/remotes/gh/main'
#|	updating local tracking ref 'refs/remotes/gh/myrddin.R'
#|	updating local tracking ref 'refs/remotes/gh/tylluan.sh'
#|	Everything up-to-date
#|	working: push to remote 'origin' for 'mabin.ls-src/mabynogion.spells.git/'
#|	Pushing to https://github.com/pure-symbols/mabynogion.spells.git
#|	To https://github.com/pure-symbols/mabynogion.spells.git
#|	 = [up to date]      base -> base
#|	 = [up to date]      main -> main
#|	 = [up to date]      myrddin.R -> myrddin.R
#|	 = [up to date]      tylluan.sh -> tylluan.sh
#|	Everything up-to-date
#|	:: pushed all remotes in 'mabin.ls-src/mabynogion.spells.git/' ::
#|	
#|	:: pulling from origin and all remotes in: pure.symb-grp/pure-symbols.git/ ::
#|	repochk: `/mnt/repos/.syncing/pure.symb-grp/pure-symbols.git` is inside worktree ~ false
#|	repochk: `/mnt/repos/.syncing/pure.symb-grp/pure-symbols.git` is inside gitdir ~ true
#|	repochk: `/mnt/repos/.syncing/pure.symb-grp/pure-symbols.git` is bare repository ~ true
#|	base_up: update from remote for 'pure.symb-grp/pure-symbols.git/'
#|	repochk: `/mnt/repos/.syncing/pure.symb-grp/pure-symbols.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	Fetching origin
#|	From https://github.com/pure-symbols/.github
#|	 * branch            HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	From https://github.com/pure-symbols/.github
#|	 * [new branch]      main       -> gh/main
#|	Fetching cb
#|	From https://codeberg.org/pure-symbols/pure.symbols
#|	 * [new branch]      main       -> cb/main
#|	Fetching dr
#|	From https://git.disroot.org/pure.symbols/pure.symbols
#|	 * [new branch]      main       -> dr/main
#|	upper: updated in '.../pure.symb-grp/pure-symbols.git' for remote(s)
#|	base_up: updated in 'pure.symb-grp/pure-symbols.git/'
#|	:: pulling all remotes in 'pure.symb-grp/pure-symbols.git/' ::
#|	working: pull from remote 'cb' for 'pure.symb-grp/pure-symbols.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://codeberg.org/pure-symbols/pure.symbols
#|	 = [up to date]      main       -> main
#|	 = [up to date]      main       -> cb/main
#|	working: pull from remote 'dr' for 'pure.symb-grp/pure-symbols.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://git.disroot.org/pure.symbols/pure.symbols
#|	 = [up to date]      main       -> main
#|	 = [up to date]      main       -> dr/main
#|	working: pull from remote 'gh' for 'pure.symb-grp/pure-symbols.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://github.com/pure-symbols/.github
#|	 = [up to date]      main       -> main
#|	 = [up to date]      main       -> gh/main
#|	working: pull from remote 'origin' for 'pure.symb-grp/pure-symbols.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://github.com/pure-symbols/.github
#|	 = [up to date]      main       -> main
#|	:: pulled all remotes in 'pure.symb-grp/pure-symbols.git/' ::
#|	
#|	:: pushing origin to all remotes in: pure.symb-grp/pure-symbols.git/ ::
#|	repochk: `/mnt/repos/.syncing/pure.symb-grp/pure-symbols.git` is inside worktree ~ false
#|	repochk: `/mnt/repos/.syncing/pure.symb-grp/pure-symbols.git` is inside gitdir ~ true
#|	repochk: `/mnt/repos/.syncing/pure.symb-grp/pure-symbols.git` is bare repository ~ true
#|	base_up: update from remote for 'pure.symb-grp/pure-symbols.git/'
#|	repochk: `/mnt/repos/.syncing/pure.symb-grp/pure-symbols.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	Fetching origin
#|	From https://github.com/pure-symbols/.github
#|	 * branch            HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	Fetching cb
#|	Fetching dr
#|	upper: updated in '.../pure.symb-grp/pure-symbols.git' for remote(s)
#|	base_up: updated in 'pure.symb-grp/pure-symbols.git/'
#|	:: pushing all remotes in 'pure.symb-grp/pure-symbols.git/' ::
#|	working: push to remote 'cb' for 'pure.symb-grp/pure-symbols.git/'
#|	Pushing to https://codeberg.org/pure-symbols/pure.symbols.git
#|	To https://codeberg.org/pure-symbols/pure.symbols.git
#|	 = [up to date]      main -> main
#|	updating local tracking ref 'refs/remotes/cb/main'
#|	Everything up-to-date
#|	working: push to remote 'dr' for 'pure.symb-grp/pure-symbols.git/'
#|	Pushing to https://git.disroot.org/pure.symbols/pure.symbols.git
#|	To https://git.disroot.org/pure.symbols/pure.symbols.git
#|	 = [up to date]      main -> main
#|	updating local tracking ref 'refs/remotes/dr/main'
#|	Everything up-to-date
#|	working: push to remote 'gh' for 'pure.symb-grp/pure-symbols.git/'
#|	Pushing to https://github.com/pure-symbols/.github.git
#|	To https://github.com/pure-symbols/.github.git
#|	 = [up to date]      main -> main
#|	updating local tracking ref 'refs/remotes/gh/main'
#|	Everything up-to-date
#|	working: push to remote 'origin' for 'pure.symb-grp/pure-symbols.git/'
#|	Pushing to https://github.com/pure-symbols/.github.git
#|	To https://github.com/pure-symbols/.github.git
#|	 = [up to date]      main -> main
#|	Everything up-to-date
#|	:: pushed all remotes in 'pure.symb-grp/pure-symbols.git/' ::
#|	
#|	:: pulling from origin and all remotes in: pure.yph-src/pure.lexicals.git/ ::
#|	repochk: `/mnt/repos/.syncing/pure.yph-src/pure.lexicals.git` is inside worktree ~ false
#|	repochk: `/mnt/repos/.syncing/pure.yph-src/pure.lexicals.git` is inside gitdir ~ true
#|	repochk: `/mnt/repos/.syncing/pure.yph-src/pure.lexicals.git` is bare repository ~ true
#|	base_up: update from remote for 'pure.yph-src/pure.lexicals.git/'
#|	repochk: `/mnt/repos/.syncing/pure.yph-src/pure.lexicals.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	Fetching origin
#|	From https://github.com/pure-symbols/pure.lexicals
#|	 * branch            HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	Fetching cb
#|	Fetching dr
#|	upper: updated in '.../pure.yph-src/pure.lexicals.git' for remote(s)
#|	base_up: updated in 'pure.yph-src/pure.lexicals.git/'
#|	:: pulling all remotes in 'pure.yph-src/pure.lexicals.git/' ::
#|	working: pull from remote 'cb' for 'pure.yph-src/pure.lexicals.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://codeberg.org/pure-symbols/pure.lexicals
#|	 ! [rejected]        main       -> main  (non-fast-forward)
#|	 = [up to date]      main       -> cb/main
#|	tried: 1 for `git fetch -v -- cb 'refs/heads/*:refs/heads/*'` in 'pure.yph-src/pure.lexicals.git/'
#|	:: try-asking: How many times you want to retry then ? :: 2
#|	:: try-asking: you inputed '2' as 2.
#|	POST git-upload-pack (165 bytes)
#|	From https://codeberg.org/pure-symbols/pure.lexicals
#|	 ! [rejected]        main       -> main  (non-fast-forward)
#|	 = [up to date]      main       -> cb/main
#|	tried: 2 for `git fetch -v -- cb 'refs/heads/*:refs/heads/*'` in 'pure.yph-src/pure.lexicals.git/'
#|	:: try-asking: rested times of that trying: 1.
#|	:: try-asking: Then: 0
#|	POST git-upload-pack (165 bytes)
#|	From https://codeberg.org/pure-symbols/pure.lexicals
#|	 ! [rejected]        main       -> main  (non-fast-forward)
#|	 = [up to date]      main       -> cb/main
#|	tried: 3 for `git fetch -v -- cb 'refs/heads/*:refs/heads/*'` in 'pure.yph-src/pure.lexicals.git/'
#|	:: try-asking: How many times you want to retry then ? :: 1
#|	:: try-asking: you inputed '1' as 1.
#|	:: try-asking: rested times of that trying: 0.
#|	:: try-asking: Then: -1
#|	POST git-upload-pack (165 bytes)
#|	From https://codeberg.org/pure-symbols/pure.lexicals
#|	 ! [rejected]        main       -> main  (non-fast-forward)
#|	 = [up to date]      main       -> cb/main
#|	tried: 4 for `git fetch -v -- cb 'refs/heads/*:refs/heads/*'` in 'pure.yph-src/pure.lexicals.git/'
#|	:: try-asking: How many times you want to retry then ? :: 0
#|	:: try-asking: you inputed '0' as 0.
#|	POST git-upload-pack (165 bytes)
#|	From https://codeberg.org/pure-symbols/pure.lexicals
#|	 ! [rejected]        main       -> main  (non-fast-forward)
#|	 = [up to date]      main       -> cb/main
#|	tried: 5 for `git fetch -v -- cb 'refs/heads/*:refs/heads/*'` in 'pure.yph-src/pure.lexicals.git/'
#|	:: try-asking: rested times of that trying: -1.
#|	:: try-asking: Break.
#|	working: pull from remote 'dr' for 'pure.yph-src/pure.lexicals.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://git.disroot.org/pure.symbols/pure.lexicals
#|	 ! [rejected]        main       -> main  (non-fast-forward)
#|	 = [up to date]      main       -> dr/main
#|	tried: 6 for `git fetch -v -- dr 'refs/heads/*:refs/heads/*'` in 'pure.yph-src/pure.lexicals.git/'
#|	:: try-asking: How many times you want to retry then ? :: 3
#|	:: try-asking: you inputed '3' as 3.
#|	POST git-upload-pack (165 bytes)
#|	From https://git.disroot.org/pure.symbols/pure.lexicals
#|	 ! [rejected]        main       -> main  (non-fast-forward)
#|	 = [up to date]      main       -> dr/main
#|	tried: 7 for `git fetch -v -- dr 'refs/heads/*:refs/heads/*'` in 'pure.yph-src/pure.lexicals.git/'
#|	:: try-asking: rested times of that trying: 2.
#|	:: try-asking: Then: 1
#|	POST git-upload-pack (165 bytes)
#|	From https://git.disroot.org/pure.symbols/pure.lexicals
#|	 ! [rejected]        main       -> main  (non-fast-forward)
#|	 = [up to date]      main       -> dr/main
#|	tried: 8 for `git fetch -v -- dr 'refs/heads/*:refs/heads/*'` in 'pure.yph-src/pure.lexicals.git/'
#|	:: try-asking: rested times of that trying: 1.
#|	:: try-asking: Then: 0
#|	POST git-upload-pack (165 bytes)
#|	From https://git.disroot.org/pure.symbols/pure.lexicals
#|	 ! [rejected]        main       -> main  (non-fast-forward)
#|	 = [up to date]      main       -> dr/main
#|	tried: 9 for `git fetch -v -- dr 'refs/heads/*:refs/heads/*'` in 'pure.yph-src/pure.lexicals.git/'
#|	:: try-asking: How many times you want to retry then ? :: 0
#|	:: try-asking: you inputed '0' as 0.
#|	POST git-upload-pack (165 bytes)
#|	From https://git.disroot.org/pure.symbols/pure.lexicals
#|	 ! [rejected]        main       -> main  (non-fast-forward)
#|	 = [up to date]      main       -> dr/main
#|	tried: 10 for `git fetch -v -- dr 'refs/heads/*:refs/heads/*'` in 'pure.yph-src/pure.lexicals.git/'
#|	:: try-asking: rested times of that trying: -1.
#|	:: try-asking: Break.
#|	working: pull from remote 'gh' for 'pure.yph-src/pure.lexicals.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://github.com/pure-symbols/pure.lexicals
#|	 = [up to date]      main       -> main
#|	 = [up to date]      main       -> gh/main
#|	working: pull from remote 'origin' for 'pure.yph-src/pure.lexicals.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://github.com/pure-symbols/pure.lexicals
#|	 = [up to date]      main       -> main
#|	:: pulled all remotes in 'pure.yph-src/pure.lexicals.git/' ::
#|	
#|	:: pushing origin to all remotes in: pure.yph-src/pure.lexicals.git/ ::
#|	repochk: `/mnt/repos/.syncing/pure.yph-src/pure.lexicals.git` is inside worktree ~ false
#|	repochk: `/mnt/repos/.syncing/pure.yph-src/pure.lexicals.git` is inside gitdir ~ true
#|	repochk: `/mnt/repos/.syncing/pure.yph-src/pure.lexicals.git` is bare repository ~ true
#|	base_up: update from remote for 'pure.yph-src/pure.lexicals.git/'
#|	repochk: `/mnt/repos/.syncing/pure.yph-src/pure.lexicals.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	Fetching origin
#|	From https://github.com/pure-symbols/pure.lexicals
#|	 * branch            HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	Fetching cb
#|	Fetching dr
#|	upper: updated in '.../pure.yph-src/pure.lexicals.git' for remote(s)
#|	base_up: updated in 'pure.yph-src/pure.lexicals.git/'
#|	:: pushing all remotes in 'pure.yph-src/pure.lexicals.git/' ::
#|	working: push to remote 'cb' for 'pure.yph-src/pure.lexicals.git/'
#|	Pushing to https://codeberg.org/pure-symbols/pure.lexicals.git
#|	Enumerating objects: 529, done.
#|	Counting objects: 100% (529/529), done.
#|	Delta compression using up to 16 threads
#|	Compressing objects: 100% (195/195), done.
#|	Writing objects: 100% (513/513), 189.12 KiB | 4.61 MiB/s, done.
#|	Total 513 (delta 340), reused 490 (delta 317), pack-reused 0 (from 0)
#|	POST git-receive-pack (193845 bytes)
#|	remote: Resolving deltas: 100% (340/340), completed with 11 local objects.
#|	To https://codeberg.org/pure-symbols/pure.lexicals.git
#|	   4416b93..608048c  main -> main
#|	updating local tracking ref 'refs/remotes/cb/main'
#|	working: push to remote 'dr' for 'pure.yph-src/pure.lexicals.git/'
#|	Pushing to https://git.disroot.org/pure.symbols/pure.lexicals.git
#|	Enumerating objects: 55, done.
#|	Counting objects: 100% (55/55), done.
#|	Delta compression using up to 16 threads
#|	Compressing objects: 100% (26/26), done.
#|	Writing objects: 100% (49/49), 44.97 KiB | 3.00 MiB/s, done.
#|	Total 49 (delta 28), reused 44 (delta 23), pack-reused 0 (from 0)
#|	POST git-receive-pack (46230 bytes)
#|	remote: Checking connectivity: 49, done.
#|	To https://git.disroot.org/pure.symbols/pure.lexicals.git
#|	   8fbcd08..608048c  main -> main
#|	updating local tracking ref 'refs/remotes/dr/main'
#|	working: push to remote 'gh' for 'pure.yph-src/pure.lexicals.git/'
#|	Pushing to https://github.com/pure-symbols/pure.lexicals.git
#|	To https://github.com/pure-symbols/pure.lexicals.git
#|	 = [up to date]      main -> main
#|	updating local tracking ref 'refs/remotes/gh/main'
#|	Everything up-to-date
#|	working: push to remote 'origin' for 'pure.yph-src/pure.lexicals.git/'
#|	Pushing to https://github.com/pure-symbols/pure.lexicals.git
#|	To https://github.com/pure-symbols/pure.lexicals.git
#|	 = [up to date]      main -> main
#|	Everything up-to-date
#|	:: pushed all remotes in 'pure.yph-src/pure.lexicals.git/' ::
#|	
#|	:: pulling from origin and all remotes in: sh3rr.sh-src/sh3rr.git/ ::
#|	repochk: `/mnt/repos/.syncing/sh3rr.sh-src/sh3rr.git` is inside worktree ~ false
#|	repochk: `/mnt/repos/.syncing/sh3rr.sh-src/sh3rr.git` is inside gitdir ~ true
#|	repochk: `/mnt/repos/.syncing/sh3rr.sh-src/sh3rr.git` is bare repository ~ true
#|	base_up: update from remote for 'sh3rr.sh-src/sh3rr.git/'
#|	repochk: `/mnt/repos/.syncing/sh3rr.sh-src/sh3rr.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	Fetching origin
#|	From https://github.com/yhm-amber/sh3rr
#|	 * branch            HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	From https://github.com/yhm-amber/sh3rr
#|	 * [new branch]      main       -> gh/main
#|	Fetching cb
#|	From https://codeberg.org/yhm-ypa/sh3rr
#|	 * [new branch]      main       -> cb/main
#|	Fetching dr
#|	From https://git.disroot.org/ypayhm/sh3rr
#|	 * [new branch]      main       -> dr/main
#|	upper: updated in '.../sh3rr.sh-src/sh3rr.git' for remote(s)
#|	base_up: updated in 'sh3rr.sh-src/sh3rr.git/'
#|	:: pulling all remotes in 'sh3rr.sh-src/sh3rr.git/' ::
#|	working: pull from remote 'cb' for 'sh3rr.sh-src/sh3rr.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://codeberg.org/yhm-ypa/sh3rr
#|	 = [up to date]      main       -> main
#|	 = [up to date]      main       -> cb/main
#|	working: pull from remote 'dr' for 'sh3rr.sh-src/sh3rr.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://git.disroot.org/ypayhm/sh3rr
#|	 = [up to date]      main       -> main
#|	 = [up to date]      main       -> dr/main
#|	working: pull from remote 'gh' for 'sh3rr.sh-src/sh3rr.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://github.com/yhm-amber/sh3rr
#|	 = [up to date]      main       -> main
#|	 = [up to date]      main       -> gh/main
#|	working: pull from remote 'origin' for 'sh3rr.sh-src/sh3rr.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://github.com/yhm-amber/sh3rr
#|	 = [up to date]      main       -> main
#|	:: pulled all remotes in 'sh3rr.sh-src/sh3rr.git/' ::
#|	
#|	:: pushing origin to all remotes in: sh3rr.sh-src/sh3rr.git/ ::
#|	repochk: `/mnt/repos/.syncing/sh3rr.sh-src/sh3rr.git` is inside worktree ~ false
#|	repochk: `/mnt/repos/.syncing/sh3rr.sh-src/sh3rr.git` is inside gitdir ~ true
#|	repochk: `/mnt/repos/.syncing/sh3rr.sh-src/sh3rr.git` is bare repository ~ true
#|	base_up: update from remote for 'sh3rr.sh-src/sh3rr.git/'
#|	repochk: `/mnt/repos/.syncing/sh3rr.sh-src/sh3rr.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	Fetching origin
#|	From https://github.com/yhm-amber/sh3rr
#|	 * branch            HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	Fetching cb
#|	Fetching dr
#|	upper: updated in '.../sh3rr.sh-src/sh3rr.git' for remote(s)
#|	base_up: updated in 'sh3rr.sh-src/sh3rr.git/'
#|	:: pushing all remotes in 'sh3rr.sh-src/sh3rr.git/' ::
#|	working: push to remote 'cb' for 'sh3rr.sh-src/sh3rr.git/'
#|	Pushing to https://codeberg.org/yhm-ypa/sh3rr.git
#|	To https://codeberg.org/yhm-ypa/sh3rr.git
#|	 = [up to date]      main -> main
#|	updating local tracking ref 'refs/remotes/cb/main'
#|	Everything up-to-date
#|	working: push to remote 'dr' for 'sh3rr.sh-src/sh3rr.git/'
#|	Pushing to https://git.disroot.org/ypayhm/sh3rr.git
#|	To https://git.disroot.org/ypayhm/sh3rr.git
#|	 = [up to date]      main -> main
#|	updating local tracking ref 'refs/remotes/dr/main'
#|	Everything up-to-date
#|	working: push to remote 'gh' for 'sh3rr.sh-src/sh3rr.git/'
#|	Pushing to https://github.com/yhm-amber/sh3rr.git
#|	To https://github.com/yhm-amber/sh3rr.git
#|	 = [up to date]      main -> main
#|	updating local tracking ref 'refs/remotes/gh/main'
#|	Everything up-to-date
#|	working: push to remote 'origin' for 'sh3rr.sh-src/sh3rr.git/'
#|	Pushing to https://github.com/yhm-amber/sh3rr.git
#|	To https://github.com/yhm-amber/sh3rr.git
#|	 = [up to date]      main -> main
#|	Everything up-to-date
#|	:: pushed all remotes in 'sh3rr.sh-src/sh3rr.git/' ::
#|	
#|	:: pulling from origin and all remotes in: yph.m-grp/yhm-amber.git/ ::
#|	repochk: `/mnt/repos/.syncing/yph.m-grp/yhm-amber.git` is inside worktree ~ false
#|	repochk: `/mnt/repos/.syncing/yph.m-grp/yhm-amber.git` is inside gitdir ~ true
#|	repochk: `/mnt/repos/.syncing/yph.m-grp/yhm-amber.git` is bare repository ~ true
#|	base_up: update from remote for 'yph.m-grp/yhm-amber.git/'
#|	repochk: `/mnt/repos/.syncing/yph.m-grp/yhm-amber.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	Fetching origin
#|	From https://github.com/yhm-amber/yhm-amber
#|	 * branch            HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	From https://github.com/yhm-amber/yhm-amber
#|	 * [new branch]      main       -> gh/main
#|	Fetching cb
#|	From https://codeberg.org/yhm-ypa/yhm-ypa
#|	 * [new branch]      main       -> cb/main
#|	Fetching dr
#|	From https://git.disroot.org/ypayhm/ypayhm
#|	 * [new branch]      main       -> dr/main
#|	upper: updated in '.../yph.m-grp/yhm-amber.git' for remote(s)
#|	base_up: updated in 'yph.m-grp/yhm-amber.git/'
#|	:: pulling all remotes in 'yph.m-grp/yhm-amber.git/' ::
#|	working: pull from remote 'cb' for 'yph.m-grp/yhm-amber.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://codeberg.org/yhm-ypa/yhm-ypa
#|	 = [up to date]      main       -> main
#|	 = [up to date]      main       -> cb/main
#|	working: pull from remote 'dr' for 'yph.m-grp/yhm-amber.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://git.disroot.org/ypayhm/ypayhm
#|	 = [up to date]      main       -> main
#|	 = [up to date]      main       -> dr/main
#|	working: pull from remote 'gh' for 'yph.m-grp/yhm-amber.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://github.com/yhm-amber/yhm-amber
#|	 = [up to date]      main       -> main
#|	 = [up to date]      main       -> gh/main
#|	working: pull from remote 'origin' for 'yph.m-grp/yhm-amber.git/'
#|	POST git-upload-pack (165 bytes)
#|	From https://github.com/yhm-amber/yhm-amber
#|	 = [up to date]      main       -> main
#|	:: pulled all remotes in 'yph.m-grp/yhm-amber.git/' ::
#|	
#|	:: pushing origin to all remotes in: yph.m-grp/yhm-amber.git/ ::
#|	repochk: `/mnt/repos/.syncing/yph.m-grp/yhm-amber.git` is inside worktree ~ false
#|	repochk: `/mnt/repos/.syncing/yph.m-grp/yhm-amber.git` is inside gitdir ~ true
#|	repochk: `/mnt/repos/.syncing/yph.m-grp/yhm-amber.git` is bare repository ~ true
#|	base_up: update from remote for 'yph.m-grp/yhm-amber.git/'
#|	repochk: `/mnt/repos/.syncing/yph.m-grp/yhm-amber.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	Fetching origin
#|	From https://github.com/yhm-amber/yhm-amber
#|	 * branch            HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	Fetching cb
#|	Fetching dr
#|	upper: updated in '.../yph.m-grp/yhm-amber.git' for remote(s)
#|	base_up: updated in 'yph.m-grp/yhm-amber.git/'
#|	:: pushing all remotes in 'yph.m-grp/yhm-amber.git/' ::
#|	working: push to remote 'cb' for 'yph.m-grp/yhm-amber.git/'
#|	Pushing to https://codeberg.org/yhm-ypa/yhm-ypa.git
#|	To https://codeberg.org/yhm-ypa/yhm-ypa.git
#|	 = [up to date]      main -> main
#|	updating local tracking ref 'refs/remotes/cb/main'
#|	Everything up-to-date
#|	working: push to remote 'dr' for 'yph.m-grp/yhm-amber.git/'
#|	Pushing to https://git.disroot.org/ypayhm/ypayhm.git
#|	To https://git.disroot.org/ypayhm/ypayhm.git
#|	 = [up to date]      main -> main
#|	updating local tracking ref 'refs/remotes/dr/main'
#|	Everything up-to-date
#|	working: push to remote 'gh' for 'yph.m-grp/yhm-amber.git/'
#|	Pushing to https://github.com/yhm-amber/yhm-amber.git
#|	To https://github.com/yhm-amber/yhm-amber.git
#|	 = [up to date]      main -> main
#|	updating local tracking ref 'refs/remotes/gh/main'
#|	Everything up-to-date
#|	working: push to remote 'origin' for 'yph.m-grp/yhm-amber.git/'
#|	Pushing to https://github.com/yhm-amber/yhm-amber.git
#|	To https://github.com/yhm-amber/yhm-amber.git
#|	 = [up to date]      main -> main
#|	Everything up-to-date
#|	:: pushed all remotes in 'yph.m-grp/yhm-amber.git/' ::
#|	
~~~

~~~ sh
ASKING_MAXTRY=9 git-deck sp all-sync *

#|	:: pulling from origin and all remotes in: contain.note-src/container-note.git/ ::
#|	repochk: `/mnt/repos/.syncing/contain.note-src/container-note.git` is inside worktree ~ false
#|	repochk: `/mnt/repos/.syncing/contain.note-src/container-note.git` is inside gitdir ~ true
#|	repochk: `/mnt/repos/.syncing/contain.note-src/container-note.git` is bare repository ~ true
#|	base_up: update from remote for 'contain.note-src/container-note.git/'
#|	repochk: `/mnt/repos/.syncing/contain.note-src/container-note.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	Fetching origin
#|	fatal: unable to access 'https://github.com/yhm-amber/container-note.git/': Recv failure: Connection was reset
#|	error: could not fetch origin
#|	Fetching gh
#|	fatal: unable to access 'https://github.com/yhm-amber/container-note.git/': Recv failure: Connection was reset
#|	error: could not fetch gh
#|	Fetching cb
#|	Fetching dr
#|	tried: 1 for remote update
#|	Fetching origin
#|	fatal: unable to access 'https://github.com/yhm-amber/container-note.git/': Recv failure: Connection was reset
#|	error: could not fetch origin
#|	Fetching gh
#|	fatal: unable to access 'https://github.com/yhm-amber/container-note.git/': Recv failure: Connection was reset
#|	error: could not fetch gh
#|	Fetching cb
#|	fatal: unable to access 'https://codeberg.org/yhm-ypa/container-note.git/': Failed to connect to codeberg.org port 443 after 24133 ms: Could not connect to server
#|	error: could not fetch cb
#|	Fetching dr
#|	tried: 2 for remote update
#|	Fetching origin
#|	fatal: unable to access 'https://github.com/yhm-amber/container-note.git/': Failed to connect to github.com port 443 after 21307 ms: Could not connect to server
#|	error: could not fetch origin
#|	Fetching gh
#|	Fetching cb
#|	Fetching dr
#|	tried: 3 for remote update
#|	Fetching origin
#|	From https://github.com/yhm-amber/container-note
#|	 * branch              HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	Fetching cb
#|	Fetching dr
#|	upper: updated in '.../contain.note-src/container-note.git' for remote(s)
#|	base_up: updated in 'contain.note-src/container-note.git/'
#|	:: pulling all remotes in 'contain.note-src/container-note.git/' ::
#|	repochk: `/mnt/repos/.syncing/contain.note-src/container-note.git` is bare repository ~ true
#|	working: pull from remote 'cb' for 'container-note.git'
#|	POST git-upload-pack (165 bytes)
#|	From https://codeberg.org/yhm-ypa/container-note
#|	 = [up to date]        main       -> main
#|	 = [up to date]        main       -> cb/main
#|	
#|	repochk: `/mnt/repos/.syncing/contain.note-src/container-note.git` is bare repository ~ true
#|	working: pull from remote 'dr' for 'container-note.git'
#|	POST git-upload-pack (165 bytes)
#|	From https://git.disroot.org/ypayhm/container-note
#|	 = [up to date]        main       -> main
#|	 = [up to date]        main       -> dr/main
#|	
#|	repochk: `/mnt/repos/.syncing/contain.note-src/container-note.git` is bare repository ~ true
#|	working: pull from remote 'gh' for 'container-note.git'
#|	POST git-upload-pack (165 bytes)
#|	From https://github.com/yhm-amber/container-note
#|	 = [up to date]        main       -> main
#|	 = [up to date]        main       -> gh/main
#|	
#|	repochk: `/mnt/repos/.syncing/contain.note-src/container-note.git` is bare repository ~ true
#|	working: pull from remote 'origin' for 'container-note.git'
#|	fatal: unable to access 'https://github.com/yhm-amber/container-note.git/': Failed to connect to github.com port 443 after 22496 ms: Could not connect to server
#|	::: chking: verificing the necessity of remote 'origin' for *pulling* works.
#|	existed: 'origin' https://github.com/yhm-amber/container-note.git
#|	chking: 	_rmt: origin	ref_path: refs/heads/main	hash_remote: 45e4dae0aedf4500fe7cd9767fea8a60d67170f6	hash_local: 45e4dae0aedf4500fe7cd9767fea8a60d67170f6
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/main
#|	
#|	:: pulled all remotes in 'contain.note-src/container-note.git/' ::
#|	
#|	:: pushing origin to all remotes in: contain.note-src/container-note.git/ ::
#|	repochk: `/mnt/repos/.syncing/contain.note-src/container-note.git` is inside worktree ~ false
#|	repochk: `/mnt/repos/.syncing/contain.note-src/container-note.git` is inside gitdir ~ true
#|	repochk: `/mnt/repos/.syncing/contain.note-src/container-note.git` is bare repository ~ true
#|	base_up: update from remote for 'contain.note-src/container-note.git/'
#|	repochk: `/mnt/repos/.syncing/contain.note-src/container-note.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	Fetching origin
#|	From https://github.com/yhm-amber/container-note
#|	 * branch              HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	Fetching cb
#|	Fetching dr
#|	upper: updated in '.../contain.note-src/container-note.git' for remote(s)
#|	base_up: updated in 'contain.note-src/container-note.git/'
#|	:: pushing all remotes in 'contain.note-src/container-note.git/' ::
#|	repochk: `/mnt/repos/.syncing/contain.note-src/container-note.git` is bare repository ~ true
#|	working: push to remote 'cb' for 'container-note.git'
#|	Pushing to https://codeberg.org/yhm-ypa/container-note.git
#|	To https://codeberg.org/yhm-ypa/container-note.git
#|	 = [up to date]        main -> main
#|	updating local tracking ref 'refs/remotes/cb/main'
#|	Everything up-to-date
#|	
#|	repochk: `/mnt/repos/.syncing/contain.note-src/container-note.git` is bare repository ~ true
#|	working: push to remote 'dr' for 'container-note.git'
#|	Pushing to https://git.disroot.org/ypayhm/container-note.git
#|	To https://git.disroot.org/ypayhm/container-note.git
#|	 = [up to date]        main -> main
#|	updating local tracking ref 'refs/remotes/dr/main'
#|	Everything up-to-date
#|	
#|	repochk: `/mnt/repos/.syncing/contain.note-src/container-note.git` is bare repository ~ true
#|	working: push to remote 'gh' for 'container-note.git'
#|	Pushing to https://github.com/yhm-amber/container-note.git
#|	To https://github.com/yhm-amber/container-note.git
#|	 = [up to date]        main -> main
#|	updating local tracking ref 'refs/remotes/gh/main'
#|	Everything up-to-date
#|	
#|	repochk: `/mnt/repos/.syncing/contain.note-src/container-note.git` is bare repository ~ true
#|	working: push to remote 'origin' for 'container-note.git'
#|	Pushing to https://github.com/yhm-amber/container-note.git
#|	To https://github.com/yhm-amber/container-note.git
#|	 = [up to date]        main -> main
#|	Everything up-to-date
#|	
#|	:: pushed all remotes in 'contain.note-src/container-note.git/' ::
#|	
#|	:: pulling from origin and all remotes in: lang.note-src/lang-note.git/ ::
#|	repochk: `/mnt/repos/.syncing/lang.note-src/lang-note.git` is inside worktree ~ false
#|	repochk: `/mnt/repos/.syncing/lang.note-src/lang-note.git` is inside gitdir ~ true
#|	repochk: `/mnt/repos/.syncing/lang.note-src/lang-note.git` is bare repository ~ true
#|	base_up: update from remote for 'lang.note-src/lang-note.git/'
#|	repochk: `/mnt/repos/.syncing/lang.note-src/lang-note.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	Fetching origin
#|	From https://github.com/yhm-amber/lang-note
#|	 * branch            HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	Fetching cb
#|	Fetching dr
#|	upper: updated in '.../lang.note-src/lang-note.git' for remote(s)
#|	base_up: updated in 'lang.note-src/lang-note.git/'
#|	:: pulling all remotes in 'lang.note-src/lang-note.git/' ::
#|	repochk: `/mnt/repos/.syncing/lang.note-src/lang-note.git` is bare repository ~ true
#|	working: pull from remote 'cb' for 'lang-note.git'
#|	POST git-upload-pack (165 bytes)
#|	From https://codeberg.org/yhm-ypa/lang-note
#|	 = [up to date]      main       -> main
#|	 = [up to date]      main       -> cb/main
#|	
#|	repochk: `/mnt/repos/.syncing/lang.note-src/lang-note.git` is bare repository ~ true
#|	working: pull from remote 'dr' for 'lang-note.git'
#|	POST git-upload-pack (165 bytes)
#|	From https://git.disroot.org/ypayhm/lang-note
#|	 ! [rejected]        main       -> main  (non-fast-forward)
#|	 = [up to date]      main       -> dr/main
#|	::: chking: verificing the necessity of remote 'dr' for *pulling* works.
#|	existed: 'dr' https://git.disroot.org/ypayhm/lang-note.git
#|	chking: 	_rmt: dr	ref_path: refs/heads/main	hash_remote: 8ba3aae65bf7469525d29b815dae70446215cee7	hash_local: ae322ffbb7b858644ee24ade10ff9b4529909d82
#|	pass: 	_pass_by: ODD_FFRES.LCO_HASH	_rsc: 1	_rmt: dr	ref_path: refs/heads/main
#|	
#|	repochk: `/mnt/repos/.syncing/lang.note-src/lang-note.git` is bare repository ~ true
#|	working: pull from remote 'gh' for 'lang-note.git'
#|	POST git-upload-pack (165 bytes)
#|	From https://github.com/yhm-amber/lang-note
#|	   ae322ff..6128af4  main       -> main
#|	 = [up to date]      main       -> gh/main
#|	
#|	repochk: `/mnt/repos/.syncing/lang.note-src/lang-note.git` is bare repository ~ true
#|	working: pull from remote 'origin' for 'lang-note.git'
#|	POST git-upload-pack (165 bytes)
#|	From https://github.com/yhm-amber/lang-note
#|	 = [up to date]      main       -> main
#|	
#|	:: pulled all remotes in 'lang.note-src/lang-note.git/' ::
#|	
#|	:: pushing origin to all remotes in: lang.note-src/lang-note.git/ ::
#|	repochk: `/mnt/repos/.syncing/lang.note-src/lang-note.git` is inside worktree ~ false
#|	repochk: `/mnt/repos/.syncing/lang.note-src/lang-note.git` is inside gitdir ~ true
#|	repochk: `/mnt/repos/.syncing/lang.note-src/lang-note.git` is bare repository ~ true
#|	base_up: update from remote for 'lang.note-src/lang-note.git/'
#|	repochk: `/mnt/repos/.syncing/lang.note-src/lang-note.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	Fetching origin
#|	From https://github.com/yhm-amber/lang-note
#|	 * branch            HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	Fetching cb
#|	Fetching dr
#|	upper: updated in '.../lang.note-src/lang-note.git' for remote(s)
#|	base_up: updated in 'lang.note-src/lang-note.git/'
#|	:: pushing all remotes in 'lang.note-src/lang-note.git/' ::
#|	repochk: `/mnt/repos/.syncing/lang.note-src/lang-note.git` is bare repository ~ true
#|	working: push to remote 'cb' for 'lang-note.git'
#|	Pushing to https://codeberg.org/yhm-ypa/lang-note.git
#|	Enumerating objects: 11, done.
#|	Counting objects: 100% (11/11), done.
#|	Delta compression using up to 16 threads
#|	Compressing objects: 100% (6/6), done.
#|	Writing objects: 100% (6/6), 1.55 KiB | 529.00 KiB/s, done.
#|	Total 6 (delta 4), reused 0 (delta 0), pack-reused 0 (from 0)
#|	POST git-receive-pack (1771 bytes)
#|	To https://codeberg.org/yhm-ypa/lang-note.git
#|	   ae322ff..6128af4  main -> main
#|	updating local tracking ref 'refs/remotes/cb/main'
#|	
#|	repochk: `/mnt/repos/.syncing/lang.note-src/lang-note.git` is bare repository ~ true
#|	working: push to remote 'dr' for 'lang-note.git'
#|	Pushing to https://git.disroot.org/ypayhm/lang-note.git
#|	Enumerating objects: 24, done.
#|	Counting objects: 100% (24/24), done.
#|	Delta compression using up to 16 threads
#|	Compressing objects: 100% (18/18), done.
#|	Writing objects: 100% (18/18), 13.19 KiB | 1.10 MiB/s, done.
#|	Total 18 (delta 11), reused 0 (delta 0), pack-reused 0 (from 0)
#|	POST git-receive-pack (13692 bytes)
#|	To https://git.disroot.org/ypayhm/lang-note.git
#|	   8ba3aae..6128af4  main -> main
#|	updating local tracking ref 'refs/remotes/dr/main'
#|	
#|	repochk: `/mnt/repos/.syncing/lang.note-src/lang-note.git` is bare repository ~ true
#|	working: push to remote 'gh' for 'lang-note.git'
#|	Pushing to https://github.com/yhm-amber/lang-note.git
#|	To https://github.com/yhm-amber/lang-note.git
#|	 = [up to date]      main -> main
#|	updating local tracking ref 'refs/remotes/gh/main'
#|	Everything up-to-date
#|	
#|	repochk: `/mnt/repos/.syncing/lang.note-src/lang-note.git` is bare repository ~ true
#|	working: push to remote 'origin' for 'lang-note.git'
#|	Pushing to https://github.com/yhm-amber/lang-note.git
#|	To https://github.com/yhm-amber/lang-note.git
#|	 = [up to date]      main -> main
#|	Everything up-to-date
#|	
#|	:: pushed all remotes in 'lang.note-src/lang-note.git/' ::
#|	
#|	:: pulling from origin and all remotes in: mabin.ls-src/mabynogion.spells.git/ ::
#|	repochk: `/mnt/repos/.syncing/mabin.ls-src/mabynogion.spells.git` is inside worktree ~ false
#|	repochk: `/mnt/repos/.syncing/mabin.ls-src/mabynogion.spells.git` is inside gitdir ~ true
#|	repochk: `/mnt/repos/.syncing/mabin.ls-src/mabynogion.spells.git` is bare repository ~ true
#|	base_up: update from remote for 'mabin.ls-src/mabynogion.spells.git/'
#|	repochk: `/mnt/repos/.syncing/mabin.ls-src/mabynogion.spells.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	Fetching origin
#|	From https://github.com/pure-symbols/mabynogion.spells
#|	 * branch            HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	Fetching cb
#|	Fetching dr
#|	upper: updated in '.../mabin.ls-src/mabynogion.spells.git' for remote(s)
#|	base_up: updated in 'mabin.ls-src/mabynogion.spells.git/'
#|	:: pulling all remotes in 'mabin.ls-src/mabynogion.spells.git/' ::
#|	repochk: `/mnt/repos/.syncing/mabin.ls-src/mabynogion.spells.git` is bare repository ~ true
#|	working: pull from remote 'cb' for 'mabynogion.spells.git'
#|	POST git-upload-pack (165 bytes)
#|	From https://codeberg.org/pure-symbols/mabynogion.spells
#|	 = [up to date]      base       -> base
#|	 = [up to date]      main       -> main
#|	 = [up to date]      myrddin.R  -> myrddin.R
#|	 = [up to date]      tylluan.sh -> tylluan.sh
#|	 = [up to date]      base       -> cb/base
#|	 = [up to date]      main       -> cb/main
#|	 = [up to date]      myrddin.R  -> cb/myrddin.R
#|	 = [up to date]      tylluan.sh -> cb/tylluan.sh
#|	
#|	repochk: `/mnt/repos/.syncing/mabin.ls-src/mabynogion.spells.git` is bare repository ~ true
#|	working: pull from remote 'dr' for 'mabynogion.spells.git'
#|	POST git-upload-pack (165 bytes)
#|	From https://git.disroot.org/pure.symbols/mabynogion.spells
#|	 = [up to date]      base       -> base
#|	 = [up to date]      main       -> main
#|	 = [up to date]      myrddin.R  -> myrddin.R
#|	 = [up to date]      tylluan.sh -> tylluan.sh
#|	 = [up to date]      base       -> dr/base
#|	 = [up to date]      main       -> dr/main
#|	 = [up to date]      myrddin.R  -> dr/myrddin.R
#|	 = [up to date]      tylluan.sh -> dr/tylluan.sh
#|	
#|	repochk: `/mnt/repos/.syncing/mabin.ls-src/mabynogion.spells.git` is bare repository ~ true
#|	working: pull from remote 'gh' for 'mabynogion.spells.git'
#|	POST git-upload-pack (165 bytes)
#|	From https://github.com/pure-symbols/mabynogion.spells
#|	 = [up to date]      base       -> base
#|	 = [up to date]      main       -> main
#|	 = [up to date]      myrddin.R  -> myrddin.R
#|	 = [up to date]      tylluan.sh -> tylluan.sh
#|	 = [up to date]      base       -> gh/base
#|	 = [up to date]      main       -> gh/main
#|	 = [up to date]      myrddin.R  -> gh/myrddin.R
#|	 = [up to date]      tylluan.sh -> gh/tylluan.sh
#|	
#|	repochk: `/mnt/repos/.syncing/mabin.ls-src/mabynogion.spells.git` is bare repository ~ true
#|	working: pull from remote 'origin' for 'mabynogion.spells.git'
#|	POST git-upload-pack (165 bytes)
#|	From https://github.com/pure-symbols/mabynogion.spells
#|	 = [up to date]      base       -> base
#|	 = [up to date]      main       -> main
#|	 = [up to date]      myrddin.R  -> myrddin.R
#|	 = [up to date]      tylluan.sh -> tylluan.sh
#|	
#|	:: pulled all remotes in 'mabin.ls-src/mabynogion.spells.git/' ::
#|	
#|	:: pushing origin to all remotes in: mabin.ls-src/mabynogion.spells.git/ ::
#|	repochk: `/mnt/repos/.syncing/mabin.ls-src/mabynogion.spells.git` is inside worktree ~ false
#|	repochk: `/mnt/repos/.syncing/mabin.ls-src/mabynogion.spells.git` is inside gitdir ~ true
#|	repochk: `/mnt/repos/.syncing/mabin.ls-src/mabynogion.spells.git` is bare repository ~ true
#|	base_up: update from remote for 'mabin.ls-src/mabynogion.spells.git/'
#|	repochk: `/mnt/repos/.syncing/mabin.ls-src/mabynogion.spells.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	Fetching origin
#|	From https://github.com/pure-symbols/mabynogion.spells
#|	 * branch            HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	Fetching cb
#|	Fetching dr
#|	upper: updated in '.../mabin.ls-src/mabynogion.spells.git' for remote(s)
#|	base_up: updated in 'mabin.ls-src/mabynogion.spells.git/'
#|	:: pushing all remotes in 'mabin.ls-src/mabynogion.spells.git/' ::
#|	repochk: `/mnt/repos/.syncing/mabin.ls-src/mabynogion.spells.git` is bare repository ~ true
#|	working: push to remote 'cb' for 'mabynogion.spells.git'
#|	Pushing to https://codeberg.org/pure-symbols/mabynogion.spells.git
#|	To https://codeberg.org/pure-symbols/mabynogion.spells.git
#|	 = [up to date]      base -> base
#|	 = [up to date]      main -> main
#|	 = [up to date]      myrddin.R -> myrddin.R
#|	 = [up to date]      tylluan.sh -> tylluan.sh
#|	updating local tracking ref 'refs/remotes/cb/base'
#|	updating local tracking ref 'refs/remotes/cb/main'
#|	updating local tracking ref 'refs/remotes/cb/myrddin.R'
#|	updating local tracking ref 'refs/remotes/cb/tylluan.sh'
#|	Everything up-to-date
#|	
#|	repochk: `/mnt/repos/.syncing/mabin.ls-src/mabynogion.spells.git` is bare repository ~ true
#|	working: push to remote 'dr' for 'mabynogion.spells.git'
#|	Pushing to https://git.disroot.org/pure.symbols/mabynogion.spells.git
#|	To https://git.disroot.org/pure.symbols/mabynogion.spells.git
#|	 = [up to date]      base -> base
#|	 = [up to date]      main -> main
#|	 = [up to date]      myrddin.R -> myrddin.R
#|	 = [up to date]      tylluan.sh -> tylluan.sh
#|	updating local tracking ref 'refs/remotes/dr/base'
#|	updating local tracking ref 'refs/remotes/dr/main'
#|	updating local tracking ref 'refs/remotes/dr/myrddin.R'
#|	updating local tracking ref 'refs/remotes/dr/tylluan.sh'
#|	Everything up-to-date
#|	
#|	repochk: `/mnt/repos/.syncing/mabin.ls-src/mabynogion.spells.git` is bare repository ~ true
#|	working: push to remote 'gh' for 'mabynogion.spells.git'
#|	Pushing to https://github.com/pure-symbols/mabynogion.spells.git
#|	To https://github.com/pure-symbols/mabynogion.spells.git
#|	 = [up to date]      base -> base
#|	 = [up to date]      main -> main
#|	 = [up to date]      myrddin.R -> myrddin.R
#|	 = [up to date]      tylluan.sh -> tylluan.sh
#|	updating local tracking ref 'refs/remotes/gh/base'
#|	updating local tracking ref 'refs/remotes/gh/main'
#|	updating local tracking ref 'refs/remotes/gh/myrddin.R'
#|	updating local tracking ref 'refs/remotes/gh/tylluan.sh'
#|	Everything up-to-date
#|	
#|	repochk: `/mnt/repos/.syncing/mabin.ls-src/mabynogion.spells.git` is bare repository ~ true
#|	working: push to remote 'origin' for 'mabynogion.spells.git'
#|	Pushing to https://github.com/pure-symbols/mabynogion.spells.git
#|	To https://github.com/pure-symbols/mabynogion.spells.git
#|	 = [up to date]      base -> base
#|	 = [up to date]      main -> main
#|	 = [up to date]      myrddin.R -> myrddin.R
#|	 = [up to date]      tylluan.sh -> tylluan.sh
#|	Everything up-to-date
#|	
#|	:: pushed all remotes in 'mabin.ls-src/mabynogion.spells.git/' ::
#|	
#|	:: pulling from origin and all remotes in: pure.symb-grp/pure-symbols.git/ ::
#|	repochk: `/mnt/repos/.syncing/pure.symb-grp/pure-symbols.git` is inside worktree ~ false
#|	repochk: `/mnt/repos/.syncing/pure.symb-grp/pure-symbols.git` is inside gitdir ~ true
#|	repochk: `/mnt/repos/.syncing/pure.symb-grp/pure-symbols.git` is bare repository ~ true
#|	base_up: update from remote for 'pure.symb-grp/pure-symbols.git/'
#|	repochk: `/mnt/repos/.syncing/pure.symb-grp/pure-symbols.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	Fetching origin
#|	From https://github.com/pure-symbols/.github
#|	 * branch            HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	Fetching cb
#|	Fetching dr
#|	upper: updated in '.../pure.symb-grp/pure-symbols.git' for remote(s)
#|	base_up: updated in 'pure.symb-grp/pure-symbols.git/'
#|	:: pulling all remotes in 'pure.symb-grp/pure-symbols.git/' ::
#|	repochk: `/mnt/repos/.syncing/pure.symb-grp/pure-symbols.git` is bare repository ~ true
#|	working: pull from remote 'cb' for 'pure-symbols.git'
#|	POST git-upload-pack (165 bytes)
#|	From https://codeberg.org/pure-symbols/pure.symbols
#|	 = [up to date]      main       -> main
#|	 = [up to date]      main       -> cb/main
#|	
#|	repochk: `/mnt/repos/.syncing/pure.symb-grp/pure-symbols.git` is bare repository ~ true
#|	working: pull from remote 'dr' for 'pure-symbols.git'
#|	POST git-upload-pack (165 bytes)
#|	From https://git.disroot.org/pure.symbols/pure.symbols
#|	 = [up to date]      main       -> main
#|	 = [up to date]      main       -> dr/main
#|	
#|	repochk: `/mnt/repos/.syncing/pure.symb-grp/pure-symbols.git` is bare repository ~ true
#|	working: pull from remote 'gh' for 'pure-symbols.git'
#|	fatal: unable to access 'https://github.com/pure-symbols/.github.git/': Recv failure: Connection was reset
#|	::: chking: verificing the necessity of remote 'gh' for *pulling* works.
#|	existed: 'gh' https://github.com/pure-symbols/.github.git
#|	fatal: unable to access 'https://github.com/pure-symbols/.github.git/': Recv failure: Connection was reset
#|	fail: 1 retried ls remote 'gh'
#|	fatal: unable to access 'https://github.com/pure-symbols/.github.git/': SSL/TLS connection timeout
#|	fail: 2 retried ls remote 'gh'
#|	chking: 	_rmt: gh	ref_path: refs/heads/main	hash_remote: 39c1d8778c9f63e6c2d264aa62663223482e5f13	hash_local: 39c1d8778c9f63e6c2d264aa62663223482e5f13
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: gh	ref_path: refs/heads/main
#|	
#|	repochk: `/mnt/repos/.syncing/pure.symb-grp/pure-symbols.git` is bare repository ~ true
#|	working: pull from remote 'origin' for 'pure-symbols.git'
#|	POST git-upload-pack (165 bytes)
#|	From https://github.com/pure-symbols/.github
#|	 = [up to date]      main       -> main
#|	
#|	:: pulled all remotes in 'pure.symb-grp/pure-symbols.git/' ::
#|	
#|	:: pushing origin to all remotes in: pure.symb-grp/pure-symbols.git/ ::
#|	repochk: `/mnt/repos/.syncing/pure.symb-grp/pure-symbols.git` is inside worktree ~ false
#|	repochk: `/mnt/repos/.syncing/pure.symb-grp/pure-symbols.git` is inside gitdir ~ true
#|	repochk: `/mnt/repos/.syncing/pure.symb-grp/pure-symbols.git` is bare repository ~ true
#|	base_up: update from remote for 'pure.symb-grp/pure-symbols.git/'
#|	repochk: `/mnt/repos/.syncing/pure.symb-grp/pure-symbols.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	Fetching origin
#|	From https://github.com/pure-symbols/.github
#|	 * branch            HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	Fetching cb
#|	Fetching dr
#|	upper: updated in '.../pure.symb-grp/pure-symbols.git' for remote(s)
#|	base_up: updated in 'pure.symb-grp/pure-symbols.git/'
#|	:: pushing all remotes in 'pure.symb-grp/pure-symbols.git/' ::
#|	repochk: `/mnt/repos/.syncing/pure.symb-grp/pure-symbols.git` is bare repository ~ true
#|	working: push to remote 'cb' for 'pure-symbols.git'
#|	Pushing to https://codeberg.org/pure-symbols/pure.symbols.git
#|	To https://codeberg.org/pure-symbols/pure.symbols.git
#|	 = [up to date]      main -> main
#|	updating local tracking ref 'refs/remotes/cb/main'
#|	Everything up-to-date
#|	
#|	repochk: `/mnt/repos/.syncing/pure.symb-grp/pure-symbols.git` is bare repository ~ true
#|	working: push to remote 'dr' for 'pure-symbols.git'
#|	Pushing to https://git.disroot.org/pure.symbols/pure.symbols.git
#|	To https://git.disroot.org/pure.symbols/pure.symbols.git
#|	 = [up to date]      main -> main
#|	updating local tracking ref 'refs/remotes/dr/main'
#|	Everything up-to-date
#|	
#|	repochk: `/mnt/repos/.syncing/pure.symb-grp/pure-symbols.git` is bare repository ~ true
#|	working: push to remote 'gh' for 'pure-symbols.git'
#|	Pushing to https://github.com/pure-symbols/.github.git
#|	To https://github.com/pure-symbols/.github.git
#|	 = [up to date]      main -> main
#|	updating local tracking ref 'refs/remotes/gh/main'
#|	Everything up-to-date
#|	
#|	repochk: `/mnt/repos/.syncing/pure.symb-grp/pure-symbols.git` is bare repository ~ true
#|	working: push to remote 'origin' for 'pure-symbols.git'
#|	Pushing to https://github.com/pure-symbols/.github.git
#|	To https://github.com/pure-symbols/.github.git
#|	 = [up to date]      main -> main
#|	Everything up-to-date
#|	
#|	:: pushed all remotes in 'pure.symb-grp/pure-symbols.git/' ::
#|	
#|	:: pulling from origin and all remotes in: pure.yph-src/pure.lexicals.git/ ::
#|	repochk: `/mnt/repos/.syncing/pure.yph-src/pure.lexicals.git` is inside worktree ~ false
#|	repochk: `/mnt/repos/.syncing/pure.yph-src/pure.lexicals.git` is inside gitdir ~ true
#|	repochk: `/mnt/repos/.syncing/pure.yph-src/pure.lexicals.git` is bare repository ~ true
#|	base_up: update from remote for 'pure.yph-src/pure.lexicals.git/'
#|	repochk: `/mnt/repos/.syncing/pure.yph-src/pure.lexicals.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	Fetching origin
#|	remote: Enumerating objects: 52, done.
#|	remote: Counting objects: 100% (52/52), done.
#|	remote: Compressing objects: 100% (40/40), done.
#|	remote: Total 42 (delta 24), reused 0 (delta 0), pack-reused 0 (from 0)
#|	Unpacking objects: 100% (42/42), 10.91 KiB | 3.00 KiB/s, done.
#|	From https://github.com/pure-symbols/pure.lexicals
#|	 * branch            HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	From https://github.com/pure-symbols/pure.lexicals
#|	   4f75afa..8d2d946  main       -> gh/main
#|	Fetching cb
#|	Fetching dr
#|	upper: updated in '.../pure.yph-src/pure.lexicals.git' for remote(s)
#|	base_up: updated in 'pure.yph-src/pure.lexicals.git/'
#|	:: pulling all remotes in 'pure.yph-src/pure.lexicals.git/' ::
#|	repochk: `/mnt/repos/.syncing/pure.yph-src/pure.lexicals.git` is bare repository ~ true
#|	working: pull from remote 'cb' for 'pure.lexicals.git'
#|	POST git-upload-pack (165 bytes)
#|	From https://codeberg.org/pure-symbols/pure.lexicals
#|	 = [up to date]      main       -> main
#|	 = [up to date]      main       -> cb/main
#|	
#|	repochk: `/mnt/repos/.syncing/pure.yph-src/pure.lexicals.git` is bare repository ~ true
#|	working: pull from remote 'dr' for 'pure.lexicals.git'
#|	POST git-upload-pack (165 bytes)
#|	From https://git.disroot.org/pure.symbols/pure.lexicals
#|	 = [up to date]      main       -> main
#|	 = [up to date]      main       -> dr/main
#|	
#|	repochk: `/mnt/repos/.syncing/pure.yph-src/pure.lexicals.git` is bare repository ~ true
#|	working: pull from remote 'gh' for 'pure.lexicals.git'
#|	POST git-upload-pack (165 bytes)
#|	From https://github.com/pure-symbols/pure.lexicals
#|	   4f75afa..8d2d946  main       -> main
#|	 = [up to date]      main       -> gh/main
#|	
#|	repochk: `/mnt/repos/.syncing/pure.yph-src/pure.lexicals.git` is bare repository ~ true
#|	working: pull from remote 'origin' for 'pure.lexicals.git'
#|	POST git-upload-pack (165 bytes)
#|	From https://github.com/pure-symbols/pure.lexicals
#|	 = [up to date]      main       -> main
#|	
#|	:: pulled all remotes in 'pure.yph-src/pure.lexicals.git/' ::
#|	
#|	:: pushing origin to all remotes in: pure.yph-src/pure.lexicals.git/ ::
#|	repochk: `/mnt/repos/.syncing/pure.yph-src/pure.lexicals.git` is inside worktree ~ false
#|	repochk: `/mnt/repos/.syncing/pure.yph-src/pure.lexicals.git` is inside gitdir ~ true
#|	repochk: `/mnt/repos/.syncing/pure.yph-src/pure.lexicals.git` is bare repository ~ true
#|	base_up: update from remote for 'pure.yph-src/pure.lexicals.git/'
#|	repochk: `/mnt/repos/.syncing/pure.yph-src/pure.lexicals.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	Fetching origin
#|	From https://github.com/pure-symbols/pure.lexicals
#|	 * branch            HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	Fetching cb
#|	Fetching dr
#|	upper: updated in '.../pure.yph-src/pure.lexicals.git' for remote(s)
#|	base_up: updated in 'pure.yph-src/pure.lexicals.git/'
#|	:: pushing all remotes in 'pure.yph-src/pure.lexicals.git/' ::
#|	repochk: `/mnt/repos/.syncing/pure.yph-src/pure.lexicals.git` is bare repository ~ true
#|	working: push to remote 'cb' for 'pure.lexicals.git'
#|	Pushing to https://codeberg.org/pure-symbols/pure.lexicals.git
#|	Enumerating objects: 52, done.
#|	Counting objects: 100% (52/52), done.
#|	Delta compression using up to 16 threads
#|	Compressing objects: 100% (40/40), done.
#|	Writing objects: 100% (42/42), 21.65 KiB | 1.08 MiB/s, done.
#|	Total 42 (delta 24), reused 0 (delta 0), pack-reused 0 (from 0)
#|	POST git-receive-pack (22350 bytes)
#|	To https://codeberg.org/pure-symbols/pure.lexicals.git
#|	   4f75afa..8d2d946  main -> main
#|	updating local tracking ref 'refs/remotes/cb/main'
#|	
#|	repochk: `/mnt/repos/.syncing/pure.yph-src/pure.lexicals.git` is bare repository ~ true
#|	working: push to remote 'dr' for 'pure.lexicals.git'
#|	Pushing to https://git.disroot.org/pure.symbols/pure.lexicals.git
#|	Enumerating objects: 52, done.
#|	Counting objects: 100% (52/52), done.
#|	Delta compression using up to 16 threads
#|	Compressing objects: 100% (40/40), done.
#|	Writing objects: 100% (42/42), 21.65 KiB | 791.00 KiB/s, done.
#|	Total 42 (delta 24), reused 0 (delta 0), pack-reused 0 (from 0)
#|	POST git-receive-pack (22350 bytes)
#|	To https://git.disroot.org/pure.symbols/pure.lexicals.git
#|	   4f75afa..8d2d946  main -> main
#|	updating local tracking ref 'refs/remotes/dr/main'
#|	
#|	repochk: `/mnt/repos/.syncing/pure.yph-src/pure.lexicals.git` is bare repository ~ true
#|	working: push to remote 'gh' for 'pure.lexicals.git'
#|	Pushing to https://github.com/pure-symbols/pure.lexicals.git
#|	To https://github.com/pure-symbols/pure.lexicals.git
#|	 = [up to date]      main -> main
#|	updating local tracking ref 'refs/remotes/gh/main'
#|	Everything up-to-date
#|	
#|	repochk: `/mnt/repos/.syncing/pure.yph-src/pure.lexicals.git` is bare repository ~ true
#|	working: push to remote 'origin' for 'pure.lexicals.git'
#|	Pushing to https://github.com/pure-symbols/pure.lexicals.git
#|	To https://github.com/pure-symbols/pure.lexicals.git
#|	 = [up to date]      main -> main
#|	Everything up-to-date
#|	
#|	:: pushed all remotes in 'pure.yph-src/pure.lexicals.git/' ::
#|	
#|	:: pulling from origin and all remotes in: sh3rr.sh-src/sh3rr.git/ ::
#|	repochk: `/mnt/repos/.syncing/sh3rr.sh-src/sh3rr.git` is inside worktree ~ false
#|	repochk: `/mnt/repos/.syncing/sh3rr.sh-src/sh3rr.git` is inside gitdir ~ true
#|	repochk: `/mnt/repos/.syncing/sh3rr.sh-src/sh3rr.git` is bare repository ~ true
#|	base_up: update from remote for 'sh3rr.sh-src/sh3rr.git/'
#|	repochk: `/mnt/repos/.syncing/sh3rr.sh-src/sh3rr.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	Fetching origin
#|	From https://github.com/yhm-amber/sh3rr
#|	 * branch            HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	Fetching cb
#|	Fetching dr
#|	upper: updated in '.../sh3rr.sh-src/sh3rr.git' for remote(s)
#|	base_up: updated in 'sh3rr.sh-src/sh3rr.git/'
#|	:: pulling all remotes in 'sh3rr.sh-src/sh3rr.git/' ::
#|	repochk: `/mnt/repos/.syncing/sh3rr.sh-src/sh3rr.git` is bare repository ~ true
#|	working: pull from remote 'cb' for 'sh3rr.git'
#|	POST git-upload-pack (165 bytes)
#|	From https://codeberg.org/yhm-ypa/sh3rr
#|	 = [up to date]      main       -> main
#|	 = [up to date]      main       -> cb/main
#|	
#|	repochk: `/mnt/repos/.syncing/sh3rr.sh-src/sh3rr.git` is bare repository ~ true
#|	working: pull from remote 'dr' for 'sh3rr.git'
#|	POST git-upload-pack (165 bytes)
#|	From https://git.disroot.org/ypayhm/sh3rr
#|	 = [up to date]      main       -> main
#|	 = [up to date]      main       -> dr/main
#|	
#|	repochk: `/mnt/repos/.syncing/sh3rr.sh-src/sh3rr.git` is bare repository ~ true
#|	working: pull from remote 'gh' for 'sh3rr.git'
#|	fatal: unable to access 'https://github.com/yhm-amber/sh3rr.git/': Recv failure: Connection was reset
#|	::: chking: verificing the necessity of remote 'gh' for *pulling* works.
#|	existed: 'gh' https://github.com/yhm-amber/sh3rr.git
#|	fatal: unable to access 'https://github.com/yhm-amber/sh3rr.git/': Recv failure: Connection was reset
#|	fail: 1 retried ls remote 'gh'
#|	fatal: unable to access 'https://github.com/yhm-amber/sh3rr.git/': Recv failure: Connection was reset
#|	fail: 2 retried ls remote 'gh'
#|	fatal: unable to access 'https://github.com/yhm-amber/sh3rr.git/': Failed to connect to github.com port 443 after 21338 ms: Could not connect to server
#|	fail: 3 retried ls remote 'gh'
#|	fatal: unable to access 'https://github.com/yhm-amber/sh3rr.git/': Recv failure: Connection was reset
#|	fail: 4 retried ls remote 'gh'
#|	chking: 	_rmt: gh	ref_path: refs/heads/main	hash_remote: bf215b58a2c346b6028e636f1925d5451a6524de	hash_local: bf215b58a2c346b6028e636f1925d5451a6524de
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: gh	ref_path: refs/heads/main
#|	
#|	repochk: `/mnt/repos/.syncing/sh3rr.sh-src/sh3rr.git` is bare repository ~ true
#|	working: pull from remote 'origin' for 'sh3rr.git'
#|	fatal: unable to access 'https://github.com/yhm-amber/sh3rr.git/': Failed to connect to github.com port 443 after 21348 ms: Could not connect to server
#|	::: chking: verificing the necessity of remote 'origin' for *pulling* works.
#|	existed: 'origin' https://github.com/yhm-amber/sh3rr.git
#|	fatal: unable to access 'https://github.com/yhm-amber/sh3rr.git/': Failed to connect to github.com port 443 after 21359 ms: Could not connect to server
#|	fail: 1 retried ls remote 'origin'
#|	chking: 	_rmt: origin	ref_path: refs/heads/main	hash_remote: bf215b58a2c346b6028e636f1925d5451a6524de	hash_local: bf215b58a2c346b6028e636f1925d5451a6524de
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/main
#|	
#|	:: pulled all remotes in 'sh3rr.sh-src/sh3rr.git/' ::
#|	
#|	:: pushing origin to all remotes in: sh3rr.sh-src/sh3rr.git/ ::
#|	repochk: `/mnt/repos/.syncing/sh3rr.sh-src/sh3rr.git` is inside worktree ~ false
#|	repochk: `/mnt/repos/.syncing/sh3rr.sh-src/sh3rr.git` is inside gitdir ~ true
#|	repochk: `/mnt/repos/.syncing/sh3rr.sh-src/sh3rr.git` is bare repository ~ true
#|	base_up: update from remote for 'sh3rr.sh-src/sh3rr.git/'
#|	repochk: `/mnt/repos/.syncing/sh3rr.sh-src/sh3rr.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	Fetching origin
#|	From https://github.com/yhm-amber/sh3rr
#|	 * branch            HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	Fetching cb
#|	Fetching dr
#|	upper: updated in '.../sh3rr.sh-src/sh3rr.git' for remote(s)
#|	base_up: updated in 'sh3rr.sh-src/sh3rr.git/'
#|	:: pushing all remotes in 'sh3rr.sh-src/sh3rr.git/' ::
#|	repochk: `/mnt/repos/.syncing/sh3rr.sh-src/sh3rr.git` is bare repository ~ true
#|	working: push to remote 'cb' for 'sh3rr.git'
#|	Pushing to https://codeberg.org/yhm-ypa/sh3rr.git
#|	To https://codeberg.org/yhm-ypa/sh3rr.git
#|	 = [up to date]      main -> main
#|	updating local tracking ref 'refs/remotes/cb/main'
#|	Everything up-to-date
#|	
#|	repochk: `/mnt/repos/.syncing/sh3rr.sh-src/sh3rr.git` is bare repository ~ true
#|	working: push to remote 'dr' for 'sh3rr.git'
#|	Pushing to https://git.disroot.org/ypayhm/sh3rr.git
#|	To https://git.disroot.org/ypayhm/sh3rr.git
#|	 = [up to date]      main -> main
#|	updating local tracking ref 'refs/remotes/dr/main'
#|	Everything up-to-date
#|	
#|	repochk: `/mnt/repos/.syncing/sh3rr.sh-src/sh3rr.git` is bare repository ~ true
#|	working: push to remote 'gh' for 'sh3rr.git'
#|	Pushing to https://github.com/yhm-amber/sh3rr.git
#|	To https://github.com/yhm-amber/sh3rr.git
#|	 = [up to date]      main -> main
#|	updating local tracking ref 'refs/remotes/gh/main'
#|	Everything up-to-date
#|	
#|	repochk: `/mnt/repos/.syncing/sh3rr.sh-src/sh3rr.git` is bare repository ~ true
#|	working: push to remote 'origin' for 'sh3rr.git'
#|	Pushing to https://github.com/yhm-amber/sh3rr.git
#|	To https://github.com/yhm-amber/sh3rr.git
#|	 = [up to date]      main -> main
#|	Everything up-to-date
#|	
#|	:: pushed all remotes in 'sh3rr.sh-src/sh3rr.git/' ::
#|	
#|	:: pulling from origin and all remotes in: yph.m-grp/yhm-amber.git/ ::
#|	repochk: `/mnt/repos/.syncing/yph.m-grp/yhm-amber.git` is inside worktree ~ false
#|	repochk: `/mnt/repos/.syncing/yph.m-grp/yhm-amber.git` is inside gitdir ~ true
#|	repochk: `/mnt/repos/.syncing/yph.m-grp/yhm-amber.git` is bare repository ~ true
#|	base_up: update from remote for 'yph.m-grp/yhm-amber.git/'
#|	repochk: `/mnt/repos/.syncing/yph.m-grp/yhm-amber.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	Fetching origin
#|	From https://github.com/yhm-amber/yhm-amber
#|	 * branch            HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	Fetching cb
#|	Fetching dr
#|	upper: updated in '.../yph.m-grp/yhm-amber.git' for remote(s)
#|	base_up: updated in 'yph.m-grp/yhm-amber.git/'
#|	:: pulling all remotes in 'yph.m-grp/yhm-amber.git/' ::
#|	repochk: `/mnt/repos/.syncing/yph.m-grp/yhm-amber.git` is bare repository ~ true
#|	working: pull from remote 'cb' for 'yhm-amber.git'
#|	POST git-upload-pack (165 bytes)
#|	From https://codeberg.org/yhm-ypa/yhm-ypa
#|	 = [up to date]      main       -> main
#|	 = [up to date]      main       -> cb/main
#|	
#|	repochk: `/mnt/repos/.syncing/yph.m-grp/yhm-amber.git` is bare repository ~ true
#|	working: pull from remote 'dr' for 'yhm-amber.git'
#|	fatal: unable to access 'https://git.disroot.org/ypayhm/ypayhm.git/': Failed to connect to git.disroot.org port 443 after 24139 ms: Could not connect to server
#|	::: chking: verificing the necessity of remote 'dr' for *pulling* works.
#|	existed: 'dr' https://git.disroot.org/ypayhm/ypayhm.git
#|	chking: 	_rmt: dr	ref_path: refs/heads/main	hash_remote: 9a45653d41cdb21bd95f40f57ef96f7aa2b20873	hash_local: 9a45653d41cdb21bd95f40f57ef96f7aa2b20873
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: dr	ref_path: refs/heads/main
#|	
#|	repochk: `/mnt/repos/.syncing/yph.m-grp/yhm-amber.git` is bare repository ~ true
#|	working: pull from remote 'gh' for 'yhm-amber.git'
#|	POST git-upload-pack (165 bytes)
#|	From https://github.com/yhm-amber/yhm-amber
#|	 = [up to date]      main       -> main
#|	 = [up to date]      main       -> gh/main
#|	
#|	repochk: `/mnt/repos/.syncing/yph.m-grp/yhm-amber.git` is bare repository ~ true
#|	working: pull from remote 'origin' for 'yhm-amber.git'
#|	POST git-upload-pack (165 bytes)
#|	From https://github.com/yhm-amber/yhm-amber
#|	 = [up to date]      main       -> main
#|	
#|	:: pulled all remotes in 'yph.m-grp/yhm-amber.git/' ::
#|	
#|	:: pushing origin to all remotes in: yph.m-grp/yhm-amber.git/ ::
#|	repochk: `/mnt/repos/.syncing/yph.m-grp/yhm-amber.git` is inside worktree ~ false
#|	repochk: `/mnt/repos/.syncing/yph.m-grp/yhm-amber.git` is inside gitdir ~ true
#|	repochk: `/mnt/repos/.syncing/yph.m-grp/yhm-amber.git` is bare repository ~ true
#|	base_up: update from remote for 'yph.m-grp/yhm-amber.git/'
#|	repochk: `/mnt/repos/.syncing/yph.m-grp/yhm-amber.git` is bare repository ~ true
#|	:: executing: remote update ::
#|	Fetching origin
#|	From https://github.com/yhm-amber/yhm-amber
#|	 * branch            HEAD       -> FETCH_HEAD
#|	Fetching gh
#|	Fetching cb
#|	Fetching dr
#|	upper: updated in '.../yph.m-grp/yhm-amber.git' for remote(s)
#|	base_up: updated in 'yph.m-grp/yhm-amber.git/'
#|	:: pushing all remotes in 'yph.m-grp/yhm-amber.git/' ::
#|	repochk: `/mnt/repos/.syncing/yph.m-grp/yhm-amber.git` is bare repository ~ true
#|	working: push to remote 'cb' for 'yhm-amber.git'
#|	Pushing to https://codeberg.org/yhm-ypa/yhm-ypa.git
#|	To https://codeberg.org/yhm-ypa/yhm-ypa.git
#|	 = [up to date]      main -> main
#|	updating local tracking ref 'refs/remotes/cb/main'
#|	Everything up-to-date
#|	
#|	repochk: `/mnt/repos/.syncing/yph.m-grp/yhm-amber.git` is bare repository ~ true
#|	working: push to remote 'dr' for 'yhm-amber.git'
#|	Pushing to https://git.disroot.org/ypayhm/ypayhm.git
#|	To https://git.disroot.org/ypayhm/ypayhm.git
#|	 = [up to date]      main -> main
#|	updating local tracking ref 'refs/remotes/dr/main'
#|	Everything up-to-date
#|	
#|	repochk: `/mnt/repos/.syncing/yph.m-grp/yhm-amber.git` is bare repository ~ true
#|	working: push to remote 'gh' for 'yhm-amber.git'
#|	Pushing to https://github.com/yhm-amber/yhm-amber.git
#|	To https://github.com/yhm-amber/yhm-amber.git
#|	 = [up to date]      main -> main
#|	updating local tracking ref 'refs/remotes/gh/main'
#|	Everything up-to-date
#|	
#|	repochk: `/mnt/repos/.syncing/yph.m-grp/yhm-amber.git` is bare repository ~ true
#|	working: push to remote 'origin' for 'yhm-amber.git'
#|	Pushing to https://github.com/yhm-amber/yhm-amber.git
#|	To https://github.com/yhm-amber/yhm-amber.git
#|	 = [up to date]      main -> main
#|	Everything up-to-date
#|	
#|	:: pushed all remotes in 'yph.m-grp/yhm-amber.git/' ::
#|	
~~~

##### Summary

~~~ sh
#: clone
cd -- /mnt/repos/.syncing
ASKING_MAXTRY=9999 OPTS_CLONE=--bare git-deck cp m . \
	mabin.ls-src/mabynogion.spells.git:https://github.com/pure-symbols/mabynogion.spells.git \
	pure.yph-src/pure.lexicals.git:https://github.com/pure-symbols/pure.lexicals.git \
	pure.symb-grp/pure-symbols.git:https://github.com/pure-symbols/.github.git \
	contain.note-src/container-note.git:https://github.com/yhm-amber/container-note.git \
	lang.note-src/lang-note.git:https://github.com/yhm-amber/lang-note.git \
	sh3rr.sh-src/sh3rr.git:https://github.com/yhm-amber/sh3rr.git \
	yph.m-grp/yhm-amber.git:https://github.com/yhm-amber/yhm-amber.git

#: remotes
git-deck sp rmts a mabin.ls-src/mabynogion.spells.git \
	gh:https://github.com/pure-symbols/mabynogion.spells.git \
	cb:https://codeberg.org/pure-symbols/mabynogion.spells.git \
	dr:https://git.disroot.org/pure.symbols/mabynogion.spells.git
git-deck sp rmts a pure.yph-src/pure.lexicals.git \
	gh:https://github.com/pure-symbols/pure.lexicals.git \
	cb:https://codeberg.org/pure-symbols/pure.lexicals.git \
	dr:https://git.disroot.org/pure.symbols/pure.lexicals.git
git-deck sp rmts a pure.symb-grp/pure-symbols.git \
	gh:https://github.com/pure-symbols/.github.git \
	cb:https://codeberg.org/pure-symbols/pure.symbols.git \
	dr:https://git.disroot.org/pure.symbols/pure.symbols.git
git-deck sp rmts a contain.note-src/container-note.git \
	gh:https://github.com/yhm-amber/container-note.git \
	cb:https://codeberg.org/yhm-ypa/container-note.git \
	dr:https://git.disroot.org/ypayhm/container-note.git
git-deck sp rmts a lang.note-src/lang-note.git \
	gh:https://github.com/yhm-amber/lang-note.git \
	cb:https://codeberg.org/yhm-ypa/lang-note.git \
	dr:https://git.disroot.org/ypayhm/lang-note.git
git-deck sp rmts a sh3rr.sh-src/sh3rr.git \
	gh:https://github.com/yhm-amber/sh3rr.git \
	cb:https://codeberg.org/yhm-ypa/sh3rr.git \
	dr:https://git.disroot.org/ypayhm/sh3rr.git
git-deck sp rmts a yph.m-grp/yhm-amber.git \
	gh:https://github.com/yhm-amber/yhm-amber.git \
	cb:https://codeberg.org/yhm-ypa/yhm-ypa.git \
	dr:https://git.disroot.org/ypayhm/ypayhm.git
~~~

~~~ sh
#: daily
ASKING_MAXTRY=9 git-deck sp all-sync *
~~~

#### `sp rmt nec deno`

~~~ sh
necessity check pull origin
#|	existed: 'origin' https://github.com/denoland/deno.git
#|	fatal: unable to access 'https://github.com/denoland/deno.git/': Failed to connect to github.com port 443 after 21301 ms: Could not connect to server
#|	fail: 1 retried ls remote 'origin'
#|	fatal: unable to access 'https://github.com/denoland/deno.git/': SSL/TLS connection timeout
#|	fail: 2 retried ls remote 'origin'
#|	fatal: unable to access 'https://github.com/denoland/deno.git/': Recv failure: Connection was reset
#|	fail: 3 retried ls remote 'origin'
#|	fatal: unable to access 'https://github.com/denoland/deno.git/': Failed to connect to github.com port 443 after 21400 ms: Could not connect to server
#|	fail: 4 retried ls remote 'origin'
#|	fatal: unable to access 'https://github.com/denoland/deno.git/': Recv failure: Connection was reset
#|	fail: 5 retried ls remote 'origin'
#|	fatal: unable to access 'https://github.com/denoland/deno.git/': Failed to connect to github.com port 443 after 24133 ms: Could not connect to server
#|	fail: 6 retried ls remote 'origin'
#|	chking: 	_rmt: origin	ref_path: refs/heads/add_otel_cache_instrumentation	hash_remote: 9b4af15bbc56b2ec489fd79433f4e6a8bd75b756	hash_local: 9b4af15bbc56b2ec489fd79433f4e6a8bd75b756
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/add_otel_cache_instrumentation
#|	chking: 	_rmt: origin	ref_path: refs/heads/andrewthauer/node-pty-fs-write-raw-fd	hash_remote: 0b82505203487bdcc26e11ac9430cb8cc2d70ea0	hash_local: _
#|	capt: 	_capt_by: @@@ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/andrewthauer/node-pty-fs-write-raw-fd
#|	origin 1

necessity check push origin
#|	existed: 'origin' https://github.com/denoland/deno.git
#|	fatal: unable to access 'https://github.com/denoland/deno.git/': SSL/TLS connection timeout
#|	fail: 1 retried ls remote 'origin'
#|	fatal: unable to access 'https://github.com/denoland/deno.git/': Failed to connect to github.com port 443 after 21347 ms: Could not connect to server
#|	fail: 2 retried ls remote 'origin'
#|	chking: 	_rmt: origin	ref_path: refs/heads/add_otel_cache_instrumentation	hash_remote: 9b4af15bbc56b2ec489fd79433f4e6a8bd75b756	hash_local: 9b4af15bbc56b2ec489fd79433f4e6a8bd75b756
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/add_otel_cache_instrumentation
#|	chking: 	_rmt: origin	ref_path: refs/heads/andrewthauer/node-pty-fs-write-raw-fd	hash_remote: 0b82505203487bdcc26e11ac9430cb8cc2d70ea0	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/andrewthauer/node-pty-fs-write-raw-fd
#|	chking: 	_rmt: origin	ref_path: refs/heads/apidocsupdates	hash_remote: a064691e66bc43da00f56bb23fcc8924e996f9e6	hash_local: a064691e66bc43da00f56bb23fcc8924e996f9e6
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/apidocsupdates
#|	chking: 	_rmt: origin	ref_path: refs/heads/auto-clean	hash_remote: 0fa9059f4d7366c480c6dab4c280c7c5eb6c1f96	hash_local: 0fa9059f4d7366c480c6dab4c280c7c5eb6c1f96
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/auto-clean
#|	chking: 	_rmt: origin	ref_path: refs/heads/auto-config	hash_remote: fe326df0db5442f1ae5da23e3777513baf849262	hash_local: fe326df0db5442f1ae5da23e3777513baf849262
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/auto-config
#|	chking: 	_rmt: origin	ref_path: refs/heads/bartlomieju/refactor/rolldown-bundle	hash_remote: 00b67f06d4c54c5fcd28a72c3f82a175634d5d2f	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/bartlomieju/refactor/rolldown-bundle
#|	chking: 	_rmt: origin	ref_path: refs/heads/better-upgrades-2	hash_remote: f20fff6f48743ce5b1cc55c22f30423a49bc024a	hash_local: f20fff6f48743ce5b1cc55c22f30423a49bc024a
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/better-upgrades-2
#|	chking: 	_rmt: origin	ref_path: refs/heads/bi/check-desktop-lib	hash_remote: 4bbc4919a373ded15ba33ffadc071771d46f315a	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/bi/check-desktop-lib
#|	chking: 	_rmt: origin	ref_path: refs/heads/bi/check-doctests	hash_remote: e5f560dc9d419d0476ec139c69fb82d49e6e87f2	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/bi/check-doctests
#|	chking: 	_rmt: origin	ref_path: refs/heads/bi/check-node-type-refs	hash_remote: f07516d446c73758c660e47d56266f54aee5098e	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/bi/check-node-type-refs
#|	chking: 	_rmt: origin	ref_path: refs/heads/bi/check-skiplibcheck-align	hash_remote: 8b5ebc50fd7a94c60ac1a363291920aeda7dc067	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/bi/check-skiplibcheck-align
#|	chking: 	_rmt: origin	ref_path: refs/heads/bi/tsc-overlay	hash_remote: c2e8b8da206d3c9013db73f32353e5470191787f	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/bi/tsc-overlay
#|	chking: 	_rmt: origin	ref_path: refs/heads/build/lzld-macos-startup	hash_remote: 537e547b3c3082c194b1e26b1d14c2c076da0508	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/build/lzld-macos-startup
#|	chking: 	_rmt: origin	ref_path: refs/heads/bundle-v2	hash_remote: ae831b111fca2453e3dad6139e3d7653c55177c4	hash_local: ae831b111fca2453e3dad6139e3d7653c55177c4
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/bundle-v2
#|	chking: 	_rmt: origin	ref_path: refs/heads/child_process_shim	hash_remote: 12f146494910ac72d8e250103b03b397bf8cc9d6	hash_local: 12f146494910ac72d8e250103b03b397bf8cc9d6
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/child_process_shim
#|	chking: 	_rmt: origin	ref_path: refs/heads/chore(ops)-update-docs-on-fast-calls	hash_remote: ff37cc046153a58cfc8d6b2dba5049e114463cc9	hash_local: ff37cc046153a58cfc8d6b2dba5049e114463cc9
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/chore(ops)-update-docs-on-fast-calls
#|	chking: 	_rmt: origin	ref_path: refs/heads/chore/bump-laufey-gcm-fix	hash_remote: 7396255dc80da6d03f45b0a09b371397a250dba7	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/chore/bump-laufey-gcm-fix
#|	chking: 	_rmt: origin	ref_path: refs/heads/chore/ignore-esm-loader-internal-tests	hash_remote: 3a563eee0bceccbe510df52e3fb584377a384602	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/chore/ignore-esm-loader-internal-tests
#|	chking: 	_rmt: origin	ref_path: refs/heads/chore/node-compat-skill-pr-prefix	hash_remote: b56d4bd51620d553954e9492839c1eb5b5c24ca2	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/chore/node-compat-skill-pr-prefix
#|	chking: 	_rmt: origin	ref_path: refs/heads/chore/track-deno_lint-main	hash_remote: 7ce38e67bd64490d97f841d43879147ca27e1b7f	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/chore/track-deno_lint-main
#|	chking: 	_rmt: origin	ref_path: refs/heads/chore_fix_node_compat_test_workflow	hash_remote: 74455a40803503d2686d60ae481c3645dbbba087	hash_local: 74455a40803503d2686d60ae481c3645dbbba087
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/chore_fix_node_compat_test_workflow
#|	chking: 	_rmt: origin	ref_path: refs/heads/chore_fix_node_compat_test_workflow_again	hash_remote: 1dc1ddcb00883905c7087af9d3a00a041387af9d	hash_local: 1dc1ddcb00883905c7087af9d3a00a041387af9d
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/chore_fix_node_compat_test_workflow_again
#|	chking: 	_rmt: origin	ref_path: refs/heads/chore_npm_publish_improve	hash_remote: 2dfd344f5e4d51e7681204abc3f2773061a3ecdc	hash_local: 2dfd344f5e4d51e7681204abc3f2773061a3ecdc
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/chore_npm_publish_improve
#|	chking: 	_rmt: origin	ref_path: refs/heads/ci_fix_npm_publish	hash_remote: e9e511538186dadc7122e1e73b26b04bcce7dd20	hash_local: e9e511538186dadc7122e1e73b26b04bcce7dd20
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/ci_fix_npm_publish
#|	chking: 	_rmt: origin	ref_path: refs/heads/claude/bun-file-deno-research-gwfgx8	hash_remote: 44a4b4610aa1726f1d5ee7c0a115005459030576	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/claude/bun-file-deno-research-gwfgx8
#|	chking: 	_rmt: origin	ref_path: refs/heads/claude/deno-26336-e2rd0q	hash_remote: f233dd3e1bac280832e435827e1ff847eea0f49b	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/claude/deno-26336-e2rd0q
#|	chking: 	_rmt: origin	ref_path: refs/heads/claude/deno-compile-time-TA9v7	hash_remote: a7c3376b4716333b21e2a104428532de4279bfb2	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/claude/deno-compile-time-TA9v7
#|	chking: 	_rmt: origin	ref_path: refs/heads/claude/deno-dom-api-research-5vv5ih	hash_remote: c12595b764fe07993af26f358ddb1699cddc403a	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/claude/deno-dom-api-research-5vv5ih
#|	chking: 	_rmt: origin	ref_path: refs/heads/claude/deno-issue-20152-i1d2hz	hash_remote: 9e1e8c59be83187e920f02c9ec00f613557707fa	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/claude/deno-issue-20152-i1d2hz
#|	chking: 	_rmt: origin	ref_path: refs/heads/claude/fix-deno-issue-32929-xlVPU	hash_remote: 336a2aab63ea0b057aceb5958fe1e3978e7ef9cc	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/claude/fix-deno-issue-32929-xlVPU
#|	chking: 	_rmt: origin	ref_path: refs/heads/claude/testing-framework-comparison-i2y2j1	hash_remote: 6d821b979de300d731394310dca0156c007ea581	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/claude/testing-framework-comparison-i2y2j1
#|	chking: 	_rmt: origin	ref_path: refs/heads/cleanup/native-tcp-connect	hash_remote: b65f6226839fde0416508b071c440b2823424b51	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/cleanup/native-tcp-connect
#|	chking: 	_rmt: origin	ref_path: refs/heads/cleanup_bindings_rs	hash_remote: b5f73a6258ceae6fb6660624123b6d55c859da9a	hash_local: b5f73a6258ceae6fb6660624123b6d55c859da9a
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/cleanup_bindings_rs
#|	chking: 	_rmt: origin	ref_path: refs/heads/codegen-ci	hash_remote: 70a3dd69d01ca9d4f6f203b5b80e0c7236b908c0	hash_local: 70a3dd69d01ca9d4f6f203b5b80e0c7236b908c0
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/codegen-ci
#|	chking: 	_rmt: origin	ref_path: refs/heads/coderabbitai/docstrings/d704ca2	hash_remote: a095a1d8145a7a8d4ff0a4d64d287a095f086912	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/coderabbitai/docstrings/d704ca2
#|	chking: 	_rmt: origin	ref_path: refs/heads/codex/aged-4c3d66f0-fcc	hash_remote: 157eecd8a46922610ce4979960802ab5e581c956	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/codex/aged-4c3d66f0-fcc
#|	chking: 	_rmt: origin	ref_path: refs/heads/color-depth	hash_remote: cce800e3a97244f2e71f488dfd79369f77b0b046	hash_local: cce800e3a97244f2e71f488dfd79369f77b0b046
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/color-depth
#|	chking: 	_rmt: origin	ref_path: refs/heads/compass	hash_remote: 1cffda520b4b3562a265b1ecb3ccf619cbcb5843	hash_local: 1cffda520b4b3562a265b1ecb3ccf619cbcb5843
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/compass
#|	chking: 	_rmt: origin	ref_path: refs/heads/compression-hot-fix	hash_remote: 69af418487ed5e7b51a9e1258b10bdf4925c4340	hash_local: 69af418487ed5e7b51a9e1258b10bdf4925c4340
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/compression-hot-fix
#|	chking: 	_rmt: origin	ref_path: refs/heads/copilot/add-easy-uninstall-command	hash_remote: 99492990be91372d61e4eb4ab1f7bca8317cbdfb	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/copilot/add-easy-uninstall-command
#|	chking: 	_rmt: origin	ref_path: refs/heads/copilot/add-node-process-execve-support	hash_remote: 31bf7e21e08528cb350a8abe911ec11bd410bc0c	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/copilot/add-node-process-execve-support
#|	chking: 	_rmt: origin	ref_path: refs/heads/copilot/fix-deno-publish-ci-issue	hash_remote: e585c4d95fd3f4385736e507ca7c68218f741bad	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/copilot/fix-deno-publish-ci-issue
#|	chking: 	_rmt: origin	ref_path: refs/heads/copilot/fix-dx-npm-tsx-panic	hash_remote: 20e827e9bd63422cd826e0ed650f2e401b253dc6	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/copilot/fix-dx-npm-tsx-panic
#|	chking: 	_rmt: origin	ref_path: refs/heads/copilot/fix-panic-forgejo-actions	hash_remote: 2ec709989cd34f90c309db4e704a1290fb57dcaf	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/copilot/fix-panic-forgejo-actions
#|	chking: 	_rmt: origin	ref_path: refs/heads/copilot/sub-pr-32509	hash_remote: 1bac93ad62dfaffc6b151fc92284ec105c7550e0	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/copilot/sub-pr-32509
#|	chking: 	_rmt: origin	ref_path: refs/heads/copilot/update-wpt-job-comment	hash_remote: 79ce092269805736a88995e79f3f309f2155a8ba	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/copilot/update-wpt-job-comment
#|	chking: 	_rmt: origin	ref_path: refs/heads/cpu-prof	hash_remote: 23a1ba509c78b1d658e02c499c4d80b1116637d6	hash_local: 23a1ba509c78b1d658e02c499c4d80b1116637d6
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/cpu-prof
#|	chking: 	_rmt: origin	ref_path: refs/heads/debug-ci	hash_remote: 8152490068f7198851edf3f55270ff08f8f30ecb	hash_local: 8152490068f7198851edf3f55270ff08f8f30ecb
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/debug-ci
#|	chking: 	_rmt: origin	ref_path: refs/heads/debug-ci2	hash_remote: a95e3f118af593d7c9ce5af734342c7867e50517	hash_local: a95e3f118af593d7c9ce5af734342c7867e50517
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/debug-ci2
#|	chking: 	_rmt: origin	ref_path: refs/heads/defork/webgpu-globals-deferral	hash_remote: 8c41089bca1f8c801838af2c7d1410e6736a96d9	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/defork/webgpu-globals-deferral
#|	chking: 	_rmt: origin	ref_path: refs/heads/DENB-29802-10	hash_remote: 807c6d67784f7b54c6100e36e45c78031c177021	hash_local: 807c6d67784f7b54c6100e36e45c78031c177021
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/DENB-29802-10
#|	chking: 	_rmt: origin	ref_path: refs/heads/DENB-29802-3	hash_remote: 93460dfa17dbb23126e372638497deeac9049539	hash_local: 93460dfa17dbb23126e372638497deeac9049539
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/DENB-29802-3
#|	chking: 	_rmt: origin	ref_path: refs/heads/DENB-29802-5	hash_remote: b1c70308e97228e104b9df33ea25e5e3c40de746	hash_local: b1c70308e97228e104b9df33ea25e5e3c40de746
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/DENB-29802-5
#|	chking: 	_rmt: origin	ref_path: refs/heads/DENB-29802-parallel/test-stream-finished.js	hash_remote: b5df174549c20b65d6095c782740c6503b35cce6	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/DENB-29802-parallel/test-stream-finished.js
#|	chking: 	_rmt: origin	ref_path: refs/heads/DENB-29802-parallel/test-stream-readable-async-iterators.js	hash_remote: 93145c76c8dd1696037e42f9a613870be74bdd95	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/DENB-29802-parallel/test-stream-readable-async-iterators.js
#|	chking: 	_rmt: origin	ref_path: refs/heads/DENB-29802-parallel-test-stream-pipeline.js	hash_remote: cfe67e72aafaa3d0e901969dc9b80a9217ac7a6f	hash_local: cfe67e72aafaa3d0e901969dc9b80a9217ac7a6f
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/DENB-29802-parallel-test-stream-pipeline.js
#|	chking: 	_rmt: origin	ref_path: refs/heads/DENB-29802-test-issue-test-stream-pipeline-http2	hash_remote: 49130b6a0b544fbf665cbdbf2840b4841d7dda0a	hash_local: 49130b6a0b544fbf665cbdbf2840b4841d7dda0a
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/DENB-29802-test-issue-test-stream-pipeline-http2
#|	chking: 	_rmt: origin	ref_path: refs/heads/DENB-29802-test-stream2-httpclient-response-end.js-2	hash_remote: 96b935a5d8c9cba3d49c14bf86bc0466f2029a47	hash_local: 96b935a5d8c9cba3d49c14bf86bc0466f2029a47
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/DENB-29802-test-stream2-httpclient-response-end.js-2
#|	chking: 	_rmt: origin	ref_path: refs/heads/DENB-29802-test-stream2-stderr-sync	hash_remote: 24772082f27faf5678aedf338f2e29ea7fd61a3f	hash_local: 24772082f27faf5678aedf338f2e29ea7fd61a3f
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/DENB-29802-test-stream2-stderr-sync
#|	chking: 	_rmt: origin	ref_path: refs/heads/DENB-29802-test-stream-pipeline-process	hash_remote: bb09263e959adaccd5c3e9537d9a42609aa4b3b9	hash_local: bb09263e959adaccd5c3e9537d9a42609aa4b3b9
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/DENB-29802-test-stream-pipeline-process
#|	chking: 	_rmt: origin	ref_path: refs/heads/DENB-29942	hash_remote: 886474bfa94cc1d326e991be7ce88f80f155e608	hash_local: 886474bfa94cc1d326e991be7ce88f80f155e608
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/DENB-29942
#|	chking: 	_rmt: origin	ref_path: refs/heads/deno_server_require_real_response	hash_remote: a85823c94497e41d82565c78c338f3fbcfecf35b	hash_local: a85823c94497e41d82565c78c338f3fbcfecf35b
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/deno_server_require_real_response
#|	chking: 	_rmt: origin	ref_path: refs/heads/deno-check-green	hash_remote: 2f9ca696e76821494050152a8cad3c29ce17dd0b	hash_local: 2f9ca696e76821494050152a8cad3c29ce17dd0b
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/deno-check-green
#|	chking: 	_rmt: origin	ref_path: refs/heads/deno-lts-plumbing	hash_remote: a9defb14509d984899c99b362d5720fcd752980d	hash_local: 107fccd252f1a5c779c0e9f9377d454f2e93943e
#|	fatal: Not a valid commit name a9defb14509d984899c99b362d5720fcd752980d
#|	capt: 	_capt_by: @@@ODD_LATE.RMT_HASH	_rsc: 128	_rmt: origin	ref_path: refs/heads/deno-lts-plumbing
#|	origin 128
~~~

~~~ sh
gd sp remote necessity verific origin pull ; echo ~~~ $?
#|	::: chking: verificing the necessity of remote 'origin' for *pulling* works.
#|	existed: 'origin' https://github.com/denoland/deno.git
#|	chking: 	_rmt: origin	ref_path: refs/heads/add_otel_cache_instrumentation	hash_remote: 9b4af15bbc56b2ec489fd79433f4e6a8bd75b756	hash_local: 9b4af15bbc56b2ec489fd79433f4e6a8bd75b756
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/add_otel_cache_instrumentation
#|	chking: 	_rmt: origin	ref_path: refs/heads/andrewthauer/node-pty-fs-write-raw-fd	hash_remote: 0b82505203487bdcc26e11ac9430cb8cc2d70ea0	hash_local: _
#|	capt: 	_capt_by: @@@ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/andrewthauer/node-pty-fs-write-raw-fd
#|	~~~ 1

gd sp remote necessity verific origin push ; echo ~~~ $?
#|	::: chking: verificing the necessity of remote 'origin' for *pushing* works.
#|	existed: 'origin' https://github.com/denoland/deno.git
#|	chking: 	_rmt: origin	ref_path: refs/heads/add_otel_cache_instrumentation	hash_remote: 9b4af15bbc56b2ec489fd79433f4e6a8bd75b756	hash_local: 9b4af15bbc56b2ec489fd79433f4e6a8bd75b756
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/add_otel_cache_instrumentation
#|	chking: 	_rmt: origin	ref_path: refs/heads/andrewthauer/node-pty-fs-write-raw-fd	hash_remote: 0b82505203487bdcc26e11ac9430cb8cc2d70ea0	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/andrewthauer/node-pty-fs-write-raw-fd
#|	chking: 	_rmt: origin	ref_path: refs/heads/apidocsupdates	hash_remote: a064691e66bc43da00f56bb23fcc8924e996f9e6	hash_local: a064691e66bc43da00f56bb23fcc8924e996f9e6
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/apidocsupdates
#|	chking: 	_rmt: origin	ref_path: refs/heads/auto-clean	hash_remote: 0fa9059f4d7366c480c6dab4c280c7c5eb6c1f96	hash_local: 0fa9059f4d7366c480c6dab4c280c7c5eb6c1f96
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/auto-clean
#|	chking: 	_rmt: origin	ref_path: refs/heads/auto-config	hash_remote: fe326df0db5442f1ae5da23e3777513baf849262	hash_local: fe326df0db5442f1ae5da23e3777513baf849262
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/auto-config
#|	chking: 	_rmt: origin	ref_path: refs/heads/bartlomieju/refactor/rolldown-bundle	hash_remote: 00b67f06d4c54c5fcd28a72c3f82a175634d5d2f	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/bartlomieju/refactor/rolldown-bundle
#|	chking: 	_rmt: origin	ref_path: refs/heads/better-upgrades-2	hash_remote: f20fff6f48743ce5b1cc55c22f30423a49bc024a	hash_local: f20fff6f48743ce5b1cc55c22f30423a49bc024a
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/better-upgrades-2
#|	chking: 	_rmt: origin	ref_path: refs/heads/bi/check-desktop-lib	hash_remote: 4bbc4919a373ded15ba33ffadc071771d46f315a	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/bi/check-desktop-lib
#|	chking: 	_rmt: origin	ref_path: refs/heads/bi/check-doctests	hash_remote: e5f560dc9d419d0476ec139c69fb82d49e6e87f2	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/bi/check-doctests
#|	chking: 	_rmt: origin	ref_path: refs/heads/bi/check-node-type-refs	hash_remote: f07516d446c73758c660e47d56266f54aee5098e	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/bi/check-node-type-refs
#|	chking: 	_rmt: origin	ref_path: refs/heads/bi/check-skiplibcheck-align	hash_remote: 8b5ebc50fd7a94c60ac1a363291920aeda7dc067	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/bi/check-skiplibcheck-align
#|	chking: 	_rmt: origin	ref_path: refs/heads/bi/tsc-overlay	hash_remote: c2e8b8da206d3c9013db73f32353e5470191787f	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/bi/tsc-overlay
#|	chking: 	_rmt: origin	ref_path: refs/heads/build/lzld-macos-startup	hash_remote: 537e547b3c3082c194b1e26b1d14c2c076da0508	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/build/lzld-macos-startup
#|	chking: 	_rmt: origin	ref_path: refs/heads/bundle-v2	hash_remote: ae831b111fca2453e3dad6139e3d7653c55177c4	hash_local: ae831b111fca2453e3dad6139e3d7653c55177c4
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/bundle-v2
#|	chking: 	_rmt: origin	ref_path: refs/heads/child_process_shim	hash_remote: 12f146494910ac72d8e250103b03b397bf8cc9d6	hash_local: 12f146494910ac72d8e250103b03b397bf8cc9d6
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/child_process_shim
#|	chking: 	_rmt: origin	ref_path: refs/heads/chore(ops)-update-docs-on-fast-calls	hash_remote: ff37cc046153a58cfc8d6b2dba5049e114463cc9	hash_local: ff37cc046153a58cfc8d6b2dba5049e114463cc9
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/chore(ops)-update-docs-on-fast-calls
#|	chking: 	_rmt: origin	ref_path: refs/heads/chore/bump-laufey-gcm-fix	hash_remote: 7396255dc80da6d03f45b0a09b371397a250dba7	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/chore/bump-laufey-gcm-fix
#|	chking: 	_rmt: origin	ref_path: refs/heads/chore/ignore-esm-loader-internal-tests	hash_remote: 3a563eee0bceccbe510df52e3fb584377a384602	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/chore/ignore-esm-loader-internal-tests
#|	chking: 	_rmt: origin	ref_path: refs/heads/chore/node-compat-skill-pr-prefix	hash_remote: b56d4bd51620d553954e9492839c1eb5b5c24ca2	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/chore/node-compat-skill-pr-prefix
#|	chking: 	_rmt: origin	ref_path: refs/heads/chore/track-deno_lint-main	hash_remote: 7ce38e67bd64490d97f841d43879147ca27e1b7f	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/chore/track-deno_lint-main
#|	chking: 	_rmt: origin	ref_path: refs/heads/chore_fix_node_compat_test_workflow	hash_remote: 74455a40803503d2686d60ae481c3645dbbba087	hash_local: 74455a40803503d2686d60ae481c3645dbbba087
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/chore_fix_node_compat_test_workflow
#|	chking: 	_rmt: origin	ref_path: refs/heads/chore_fix_node_compat_test_workflow_again	hash_remote: 1dc1ddcb00883905c7087af9d3a00a041387af9d	hash_local: 1dc1ddcb00883905c7087af9d3a00a041387af9d
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/chore_fix_node_compat_test_workflow_again
#|	chking: 	_rmt: origin	ref_path: refs/heads/chore_npm_publish_improve	hash_remote: 2dfd344f5e4d51e7681204abc3f2773061a3ecdc	hash_local: 2dfd344f5e4d51e7681204abc3f2773061a3ecdc
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/chore_npm_publish_improve
#|	chking: 	_rmt: origin	ref_path: refs/heads/ci_fix_npm_publish	hash_remote: e9e511538186dadc7122e1e73b26b04bcce7dd20	hash_local: e9e511538186dadc7122e1e73b26b04bcce7dd20
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/ci_fix_npm_publish
#|	chking: 	_rmt: origin	ref_path: refs/heads/claude/bun-file-deno-research-gwfgx8	hash_remote: 44a4b4610aa1726f1d5ee7c0a115005459030576	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/claude/bun-file-deno-research-gwfgx8
#|	chking: 	_rmt: origin	ref_path: refs/heads/claude/deno-26336-e2rd0q	hash_remote: f233dd3e1bac280832e435827e1ff847eea0f49b	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/claude/deno-26336-e2rd0q
#|	chking: 	_rmt: origin	ref_path: refs/heads/claude/deno-compile-time-TA9v7	hash_remote: a7c3376b4716333b21e2a104428532de4279bfb2	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/claude/deno-compile-time-TA9v7
#|	chking: 	_rmt: origin	ref_path: refs/heads/claude/deno-dom-api-research-5vv5ih	hash_remote: c12595b764fe07993af26f358ddb1699cddc403a	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/claude/deno-dom-api-research-5vv5ih
#|	chking: 	_rmt: origin	ref_path: refs/heads/claude/deno-issue-20152-i1d2hz	hash_remote: 9e1e8c59be83187e920f02c9ec00f613557707fa	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/claude/deno-issue-20152-i1d2hz
#|	chking: 	_rmt: origin	ref_path: refs/heads/claude/fix-deno-issue-32929-xlVPU	hash_remote: 336a2aab63ea0b057aceb5958fe1e3978e7ef9cc	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/claude/fix-deno-issue-32929-xlVPU
#|	chking: 	_rmt: origin	ref_path: refs/heads/claude/testing-framework-comparison-i2y2j1	hash_remote: 6d821b979de300d731394310dca0156c007ea581	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/claude/testing-framework-comparison-i2y2j1
#|	chking: 	_rmt: origin	ref_path: refs/heads/cleanup/native-tcp-connect	hash_remote: b65f6226839fde0416508b071c440b2823424b51	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/cleanup/native-tcp-connect
#|	chking: 	_rmt: origin	ref_path: refs/heads/cleanup_bindings_rs	hash_remote: b5f73a6258ceae6fb6660624123b6d55c859da9a	hash_local: b5f73a6258ceae6fb6660624123b6d55c859da9a
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/cleanup_bindings_rs
#|	chking: 	_rmt: origin	ref_path: refs/heads/codegen-ci	hash_remote: 70a3dd69d01ca9d4f6f203b5b80e0c7236b908c0	hash_local: 70a3dd69d01ca9d4f6f203b5b80e0c7236b908c0
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/codegen-ci
#|	chking: 	_rmt: origin	ref_path: refs/heads/coderabbitai/docstrings/d704ca2	hash_remote: a095a1d8145a7a8d4ff0a4d64d287a095f086912	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/coderabbitai/docstrings/d704ca2
#|	chking: 	_rmt: origin	ref_path: refs/heads/codex/aged-4c3d66f0-fcc	hash_remote: 157eecd8a46922610ce4979960802ab5e581c956	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/codex/aged-4c3d66f0-fcc
#|	chking: 	_rmt: origin	ref_path: refs/heads/color-depth	hash_remote: cce800e3a97244f2e71f488dfd79369f77b0b046	hash_local: cce800e3a97244f2e71f488dfd79369f77b0b046
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/color-depth
#|	chking: 	_rmt: origin	ref_path: refs/heads/compass	hash_remote: 1cffda520b4b3562a265b1ecb3ccf619cbcb5843	hash_local: 1cffda520b4b3562a265b1ecb3ccf619cbcb5843
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/compass
#|	chking: 	_rmt: origin	ref_path: refs/heads/compression-hot-fix	hash_remote: 69af418487ed5e7b51a9e1258b10bdf4925c4340	hash_local: 69af418487ed5e7b51a9e1258b10bdf4925c4340
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/compression-hot-fix
#|	chking: 	_rmt: origin	ref_path: refs/heads/copilot/add-easy-uninstall-command	hash_remote: 99492990be91372d61e4eb4ab1f7bca8317cbdfb	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/copilot/add-easy-uninstall-command
#|	chking: 	_rmt: origin	ref_path: refs/heads/copilot/add-node-process-execve-support	hash_remote: 31bf7e21e08528cb350a8abe911ec11bd410bc0c	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/copilot/add-node-process-execve-support
#|	chking: 	_rmt: origin	ref_path: refs/heads/copilot/fix-deno-publish-ci-issue	hash_remote: e585c4d95fd3f4385736e507ca7c68218f741bad	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/copilot/fix-deno-publish-ci-issue
#|	chking: 	_rmt: origin	ref_path: refs/heads/copilot/fix-dx-npm-tsx-panic	hash_remote: 20e827e9bd63422cd826e0ed650f2e401b253dc6	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/copilot/fix-dx-npm-tsx-panic
#|	chking: 	_rmt: origin	ref_path: refs/heads/copilot/fix-panic-forgejo-actions	hash_remote: 2ec709989cd34f90c309db4e704a1290fb57dcaf	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/copilot/fix-panic-forgejo-actions
#|	chking: 	_rmt: origin	ref_path: refs/heads/copilot/sub-pr-32509	hash_remote: 1bac93ad62dfaffc6b151fc92284ec105c7550e0	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/copilot/sub-pr-32509
#|	chking: 	_rmt: origin	ref_path: refs/heads/copilot/update-wpt-job-comment	hash_remote: 79ce092269805736a88995e79f3f309f2155a8ba	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/copilot/update-wpt-job-comment
#|	chking: 	_rmt: origin	ref_path: refs/heads/cpu-prof	hash_remote: 23a1ba509c78b1d658e02c499c4d80b1116637d6	hash_local: 23a1ba509c78b1d658e02c499c4d80b1116637d6
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/cpu-prof
#|	chking: 	_rmt: origin	ref_path: refs/heads/debug-ci	hash_remote: 8152490068f7198851edf3f55270ff08f8f30ecb	hash_local: 8152490068f7198851edf3f55270ff08f8f30ecb
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/debug-ci
#|	chking: 	_rmt: origin	ref_path: refs/heads/debug-ci2	hash_remote: a95e3f118af593d7c9ce5af734342c7867e50517	hash_local: a95e3f118af593d7c9ce5af734342c7867e50517
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/debug-ci2
#|	chking: 	_rmt: origin	ref_path: refs/heads/defork/webgpu-globals-deferral	hash_remote: 8c41089bca1f8c801838af2c7d1410e6736a96d9	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/defork/webgpu-globals-deferral
#|	chking: 	_rmt: origin	ref_path: refs/heads/DENB-29802-10	hash_remote: 807c6d67784f7b54c6100e36e45c78031c177021	hash_local: 807c6d67784f7b54c6100e36e45c78031c177021
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/DENB-29802-10
#|	chking: 	_rmt: origin	ref_path: refs/heads/DENB-29802-3	hash_remote: 93460dfa17dbb23126e372638497deeac9049539	hash_local: 93460dfa17dbb23126e372638497deeac9049539
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/DENB-29802-3
#|	chking: 	_rmt: origin	ref_path: refs/heads/DENB-29802-5	hash_remote: b1c70308e97228e104b9df33ea25e5e3c40de746	hash_local: b1c70308e97228e104b9df33ea25e5e3c40de746
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/DENB-29802-5
#|	chking: 	_rmt: origin	ref_path: refs/heads/DENB-29802-parallel/test-stream-finished.js	hash_remote: b5df174549c20b65d6095c782740c6503b35cce6	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/DENB-29802-parallel/test-stream-finished.js
#|	chking: 	_rmt: origin	ref_path: refs/heads/DENB-29802-parallel/test-stream-readable-async-iterators.js	hash_remote: 93145c76c8dd1696037e42f9a613870be74bdd95	hash_local: _
#|	pass: 	_pass_by: ODD_NONE.LCO_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/DENB-29802-parallel/test-stream-readable-async-iterators.js
#|	chking: 	_rmt: origin	ref_path: refs/heads/DENB-29802-parallel-test-stream-pipeline.js	hash_remote: cfe67e72aafaa3d0e901969dc9b80a9217ac7a6f	hash_local: cfe67e72aafaa3d0e901969dc9b80a9217ac7a6f
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/DENB-29802-parallel-test-stream-pipeline.js
#|	chking: 	_rmt: origin	ref_path: refs/heads/DENB-29802-test-issue-test-stream-pipeline-http2	hash_remote: 49130b6a0b544fbf665cbdbf2840b4841d7dda0a	hash_local: 49130b6a0b544fbf665cbdbf2840b4841d7dda0a
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/DENB-29802-test-issue-test-stream-pipeline-http2
#|	chking: 	_rmt: origin	ref_path: refs/heads/DENB-29802-test-stream2-httpclient-response-end.js-2	hash_remote: 96b935a5d8c9cba3d49c14bf86bc0466f2029a47	hash_local: 96b935a5d8c9cba3d49c14bf86bc0466f2029a47
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/DENB-29802-test-stream2-httpclient-response-end.js-2
#|	chking: 	_rmt: origin	ref_path: refs/heads/DENB-29802-test-stream2-stderr-sync	hash_remote: 24772082f27faf5678aedf338f2e29ea7fd61a3f	hash_local: 24772082f27faf5678aedf338f2e29ea7fd61a3f
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/DENB-29802-test-stream2-stderr-sync
#|	chking: 	_rmt: origin	ref_path: refs/heads/DENB-29802-test-stream-pipeline-process	hash_remote: bb09263e959adaccd5c3e9537d9a42609aa4b3b9	hash_local: bb09263e959adaccd5c3e9537d9a42609aa4b3b9
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/DENB-29802-test-stream-pipeline-process
#|	chking: 	_rmt: origin	ref_path: refs/heads/DENB-29942	hash_remote: 886474bfa94cc1d326e991be7ce88f80f155e608	hash_local: 886474bfa94cc1d326e991be7ce88f80f155e608
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/DENB-29942
#|	chking: 	_rmt: origin	ref_path: refs/heads/deno_server_require_real_response	hash_remote: a85823c94497e41d82565c78c338f3fbcfecf35b	hash_local: a85823c94497e41d82565c78c338f3fbcfecf35b
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/deno_server_require_real_response
#|	chking: 	_rmt: origin	ref_path: refs/heads/deno-check-green	hash_remote: 2f9ca696e76821494050152a8cad3c29ce17dd0b	hash_local: 2f9ca696e76821494050152a8cad3c29ce17dd0b
#|	pass: 	_pass_by: EVN_EQUAL.BOTH_HASH	_rsc: 1	_rmt: origin	ref_path: refs/heads/deno-check-green
#|	chking: 	_rmt: origin	ref_path: refs/heads/deno-lts-plumbing	hash_remote: a9defb14509d984899c99b362d5720fcd752980d	hash_local: 107fccd252f1a5c779c0e9f9377d454f2e93943e
#|	fatal: Not a valid commit name a9defb14509d984899c99b362d5720fcd752980d
#|	capt: 	_capt_by: @@@ODD_LATE.RMT_HASH	_rsc: 128	_rmt: origin	ref_path: refs/heads/deno-lts-plumbing
#|	~~~ 128
~~~

