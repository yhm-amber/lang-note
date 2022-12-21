(def save-new [p: string]
{
    (if ($p | path exists) 
    {$in | null} else 
    {$in | save $p} )
})
