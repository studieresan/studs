default: cv-test.pdf

.PHONY: distclean clean

%.pdf: %.tex
	pdflatex $<
	pdflatex $<

cv-test.pdf:
	./test_cv_conv.rb > cv-test.tex
	pdflatex cv-test.tex
	pdflatex cv-test.tex

distclean: clean
	rm -f *.pdf

clean:
	rm -f *.aux *.log *.out
