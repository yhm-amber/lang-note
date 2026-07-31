

#: 微妙的 eval 临时作用域

A=a eval 'echo $A' #> a
echo $A #> ''
A=a echo $A #> ''

