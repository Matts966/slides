# Slides

This github project is for publishing my slides using github pages.

The `index.html` of the root of this project is a symlink to the file in the `slides-src/index-export`.

By editing the file `title.md` in the `slides-src` directory, exporting the markdown file to html using vscode-reveal, and adding the relative link of the exported directory to the index.md,  I can publish my slides.

Note that vscode-reveal's html export function can not copy the image files. So I should copy it from `slides-src/images` directory.