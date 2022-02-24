Set-Location ../../
Get-ChildItem -Recurse -Filter *.Rtex | Foreach-Object {
    $FixedName = $_.FullName.Replace("\", "/")
    $Dirname = $_.FullName.Replace("\", "/").Replace(".Rtex", ".tex")
    C:/"Program Files"/R/R-4.1.2/bin/x64/R.exe -e "library(knitr);knit2pdf('$FixedName', '$Dirname')" 
}
Set-Location docs
xelatex.exe -file-line-error -interaction=nonstopmode Main.tex
# makeglossaries.exe docs/Main.Tex 
xelatex.exe -file-line-error -interaction=nonstopmode Main.tex
xelatex.exe -file-line-error -interaction=nonstopmode Main.tex 
Set-Location ..
Set-Location src/build
