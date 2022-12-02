# v: 0.72.0

〉ls
╭───┬────────────┬──────┬───────────┬──────────────╮
│ # │    name    │ type │   size    │   modified   │
├───┼────────────┼──────┼───────────┼──────────────┤
│ 0 │ nyan.html  │ file │ 818.7 KiB │ 2 months ago │
│ 1 │ singlefile │ dir  │   3.4 KiB │ 2 months ago │
│ 2 │ yhm-amber  │ dir  │   3.4 KiB │ 2 months ago │
│ 3 │ yy         │ file │     432 B │ 5 days ago   │
│ 4 │ zz         │ file │     476 B │ 5 days ago   │
╰───┴────────────┴──────┴───────────┴──────────────╯
〉ls | each { |it| $"N ($it)" }                                                                12/02/2022 01:50:48 上午
╭───┬────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ 0 │ N {name: nyan.html, type: file, size: 818.7 KiB, modified: Sun, 11 Sep 2022 03:56:27 +0000 (2 months ago)} │
│ 1 │ N {name: singlefile, type: dir, size: 3.4 KiB, modified: Mon, 26 Sep 2022 06:02:33 +0000 (2 months ago)}   │
│ 2 │ N {name: yhm-amber, type: dir, size: 3.4 KiB, modified: Mon, 26 Sep 2022 06:13:19 +0000 (2 months ago)}    │
│ 3 │ N {name: yy, type: file, size: 432 B, modified: Sat, 26 Nov 2022 12:53:08 +0000 (5 days ago)}              │
│ 4 │ N {name: zz, type: file, size: 476 B, modified: Sat, 26 Nov 2022 12:03:17 +0000 (5 days ago)}              │
╰───┴────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
〉ls | each -n { |it| $"N ($it)" }                                                             12/02/2022 01:50:40 上午
╭───┬──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ 0 │ N {index: 0, item: {name: nyan.html, type: file, size: 818.7 KiB, modified: Sun, 11 Sep 2022 03:56:27 +0000 (2 months ago)}} │
│ 1 │ N {index: 1, item: {name: singlefile, type: dir, size: 3.4 KiB, modified: Mon, 26 Sep 2022 06:02:33 +0000 (2 months ago)}}   │
│ 2 │ N {index: 2, item: {name: yhm-amber, type: dir, size: 3.4 KiB, modified: Mon, 26 Sep 2022 06:13:19 +0000 (2 months ago)}}    │
│ 3 │ N {index: 3, item: {name: yy, type: file, size: 432 B, modified: Sat, 26 Nov 2022 12:53:08 +0000 (5 days ago)}}              │
│ 4 │ N {index: 4, item: {name: zz, type: file, size: 476 B, modified: Sat, 26 Nov 2022 12:03:17 +0000 (5 days ago)}}              │
╰───┴──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
