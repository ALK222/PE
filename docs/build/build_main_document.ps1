if ($args.Length -gt 1) {
    throw "Número incorrecto de argumentos, ponga compile para compilar el documento o  no ponga nada."
}
$compile = $args[0]

if ($args.Length -eq 1) {
    if ( ($compile -ne "") -and ($compile -ne "compile")) {
        throw "Argumento no reconocido, ponga compile para compilar el documento o  no ponga nada."
    }
    else {
        Set-Location ../../
    }
}



Set-Location docs
Get-ChildItem -Recurse -Filter *.Rtex | Foreach-Object {
    $FixedName = $_.FullName.Replace("\", "/")
    $Dirname = $_.FullName.Replace("\", "/").Replace(".Rtex", ".tex")
    C:/"Program Files"/R/R-4.1.2/bin/x64/R.exe -e "library(knitr);knit('$FixedName', '$Dirname')" 
}

if (($args.Length -eq 1) -and ($compile -eq "compile")) {
    xelatex.exe -file-line-error -interaction=nonstopmode Estudio.tex
    xelatex.exe -file-line-error -interaction=nonstopmode Estudio.tex 
    Set-Location ..
    Set-Location ./src/build
}
