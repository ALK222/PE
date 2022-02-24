Get-ChildItem -Recurse -Filter ../docs/*.Rtex | Foreach-Object {
    $FixedName = $_.FullName.Replace("\", "/")
    $Dirname = $_.FullName.Replace("\", "/").Replace(".Rtex", ".tex")
    C:/"Program Files"/R/R-4.1.2/bin/x64/R.exe -e "library(knitr);knit2pdf('$FixedName', '$Dirname')" 
}
