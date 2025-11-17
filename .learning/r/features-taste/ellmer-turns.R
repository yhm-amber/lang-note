
#: Managing turns in your chat
turn.ls = chat$get_turns(list())
#' ... changing turns in turn.ls
chat$set_turns(turn.ls)

#; tool calling(s) will be recorded as assistant turn
#; and return(s) of tool calling will be recorded as user turn
#; both of them will be marked with [tool request (chatcmpl-tool-<32-len-64bit-code-uuid>)]
#; a calling and its return has same uuid in their tool request mark.
