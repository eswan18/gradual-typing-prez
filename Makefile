MD_FILES = $(wildcard premark_slides/*)

.PHONY: slides clean

slides: slides.html
	
slides.html: $(MD_FILES) premark.yaml premark_assets/styles.css
	premark -o slides.html --config premark.yaml premark_slides

clean:
	rm slides.html
