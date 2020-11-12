PAPER=text
COMPILER=pdflatex
BUILDDIR=build
FLAGS=-shell-escape \
      -interaction nonstopmode \
      -halt-on-error \
      -file-line-error \
      -output-directory=$(BUILDDIR)

all:
	mkdir -p $(BUILDDIR)
	$(COMPILER) $(FLAGS) $(PAPER).tex
	mv $(BUILDDIR)/*.pdf .

clean:
	rm -rf $(BUILDDIR) _minted-slides/ indent.log

watch:  
	ls $(PAPER).tex | entr make all
