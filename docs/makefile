all: Rtex Latex Latex

Rtex: Rtex 
	R -e "library(knitr);knit('Nota_Prensa.Rtex', 'Nota_Prensa.tex')"
Latex: Latex
	xelatex -file-line-error -interaction=nonstopmode Nota_Prensa.tex
clean: 
	rm Nota_Prensa.tex Nota_Prensa.aux figure/* *.out *.log
