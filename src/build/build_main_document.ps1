if ($args.Length -gt 1) {
    throw "Número incorrecto de argumentos, ponga compile para compilar el documento o  no ponga nada."
}

compile = $args[0]

if (compile -ne "compile") {
    throw "Argumento no reconocido, ponga compile para compilar el documento o  no ponga nada."
}

Set-Location ../../
Get-ChildItem -Recurse -Filter *.Rtex | Foreach-Object {
    $FixedName = $_.FullName.Replace("\", "/")
    $Dirname = $_.FullName.Replace("\", "/").Replace(".Rtex", ".tex")
    C:/"Program Files"/R/R-4.1.2/bin/x64/R.exe -e "library(knitr);knit2pdf('$FixedName', '$Dirname')" 
}

if (compile -eq compile) {
    Set-Location docs
    xelatex.exe -file-line-error -interaction=nonstopmode Main.tex
    makeglossaries.exe docs/Main 
    xelatex.exe -file-line-error -interaction=nonstopmode Main.tex
    xelatex.exe -file-line-error -interaction=nonstopmode Main.tex 
    Set-Location ..
}
Set-Location src/build
