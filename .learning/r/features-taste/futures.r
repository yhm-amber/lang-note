
future::plan(future::multisession)

sheepy = \(n) {Sys.sleep(n);n} ;

1:8 %>% lapply (\(x) future::future(sheepy (x))) %>% lapply (future::value) %>% lapply (print) %>% unlist
1:8 %>% lapply (\(x) future::future(sheepy (x))) %>% lapply (\(x) future::value (x) %>% print) %>% unlist

## [1] 1
## [1] 2
## [1] 3
## [1] 4
## [1] 5
## [1] 6
## [1] 7
## [1] 8
## [1] 1 2 3 4 5 6 7 8

### 👺 前一行会 8 秒后给出所有结果
### 👺 后一行会每过一秒打一个数字并在最后一次打出所有数字
