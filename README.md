# Module Template

This repo serves as the basis for new education slideshow modules that I build.

Right now, I'm using [Premark](https://github.com/eswan18/premark), a fork of [Remarker](https://github.com/tylerdave/remarker), in which I've added the ability to stitch multiple "sections" together into a single slideshow.

On a Unix-y system, build your presentation with:
```bash
make slides
```

Simply open the produced `slides.html` in your browser to see the slides.

## Exporting to PDF

Using Conda and [decktape](https://github.com/astefanutti/decktape), it's not too hard to convert slides to PDF.

First, create a conda environment and install decktape there, using npm.
```bash
# Create the environment
conda create -n decktape nodejs
# Activate it
conda activate decktape
# Install decktape itself
npm install -g decktape
```
Now, as long as this environment is activated (which you can do any time with `conda activate decktape`), the executable `decktape` will be in your path.

To use it for exporting, `cd` into the folder with your slides.
Open the slides in your browser, however you usually do that (probably just opening `slides.html`) and copy the URL.
Then run the following line, but replacing `<url>` with the URL you copied.

```bash
decktape remark "<url>" slides.pdf --chrome-arg=--disable-web-security --size=320x240
```

The `slides.pdf` file will contain your slides.
