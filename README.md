# Slides

This github project is for publishing my slides using github pages.

You can visit from [here](https://matts966.github.io/slides).

The `index.html` of the root of this project is a symlink to the file in the `slides-src/index-export`.

We can publish slides by the steps below

1. editing the file `title.md` in the `slides-src` directory.
2. exporting the markdown file to html using vscode-reveal.
3. adding the relative link of the exported directory to the `index.md` in the `slides-src` directory.
4. Commiting and pushing the changes.

Note that vscode-reveal's html export function can not copy the image files. So we should copy it from `slides-src/images` directory.