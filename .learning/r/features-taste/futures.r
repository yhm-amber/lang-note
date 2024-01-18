
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


#' 有限并行度

future::plan(future::cluster, workers = 3)

sheepy = \(n) {Sys.sleep(3);n}

seq(6) %>% 
  lapply (\(n) future::future(sheepy(n))) %>% 
  lapply(\(x) x %>% (future::value) %>% as.character %T>% message) %>% 
  unlist
## 1
## 2
## 3
## 4
## 5
## 6
## [1] "1" "2" "3" "4" "5" "6"
## 

#' 三秒后出前三个序号，
#' 再三秒出后三个序号、以及所有序号。
#' 

