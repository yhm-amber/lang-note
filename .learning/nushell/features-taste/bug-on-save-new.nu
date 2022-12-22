def save-new [p: string] { if ($p | path exists) {$in | null} else { $in | save $p ; (ls $p).name.0 | path expand | path relative-to ('../../..' | path expand) } } ;

"######" | save-new foo ## will get file foo if not exist

mkdir aa bb cc ; ls | where type == dir | each {|d| cd ($d.name) ; '%%%' | save-new foo } ## will err
mkdir aa bb cc ; ls | where type == dir | each {|d| cd ($d.name) ; '%%%' | save foo } ## ... but this will NOT, WHY?

### bug is occur when using `cd` inner `each { }` !!
### not a `save` bug .

mkdir save-test/kk ; cd save-test/kk ; def save-kk [p: string] { $in | save $p } ; cd -

ls | where type == dir | each {|d| cd $d.name ; 'xx' | save-kk xx } ## bug
ls | where type == dir | each {|d| 'xsx' | save-kk $"($d.name)/xsx" } ## ok

ls | where type == dir | each {|d| ls ($d.name) } | flatten ## look
