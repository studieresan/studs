%.pdf: %.tex
	pdflatex $<
	pdflatex $<

.PHONY: cv-test.pdf
cv-test.pdf:
	./test_cv_conv.rb > cv-test.tex
	pdflatex cv-test.tex
	pdflatex cv-test.tex
