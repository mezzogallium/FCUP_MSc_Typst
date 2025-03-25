# FCUP MSc Thesis Layout
## Typst Version

by André Santos ([up202002763@up.pt](mailto:up202002763@up.pt))

This is a Typst replica of the FCUP MSc Thesis Layout originally made in Overleaf (LaTeX). Typst is arguably much easier to understand and use nowadays, and with a free account, students can write their whole thesis with instantaneous compilation, right on their browsers.

You can read [this quick guide](https://typst.app/docs/guides/guide-for-latex-users/) which gets you up to speed on the syntax if you're already familiar with LaTeX.

**Disclaimer: this template was not created by the faculty.** I am just a student looking for a better solution, not affiliated with whoever makes such decisions officially.

## Recently fixed
- Start of page numberings is now according to the original template (preamble starts at "ii" and body at "1")
- Introduced `flex-caption` which allows you to shorten long figure captions for the outline
- `in-outline` state is now handled in the template file, you no longer need the `#in-outline.update()` lines in your main.typ file 


- Level 1 Headings (chapters) and uses of `special-heading` now already include pagebreaks automatically
- Header title has smaller spacing between lines for longer, multi-line titles. Use of linebreaks with "\" is encouraged
- Fixed justification not applying to Abstract sections

## Currently not working

- Not possible at the time to implement backreferences in the bibliography, to produce links to the pages in the document where the source was cited - ex: "[Cited on page 6]". This may be possible in the future

## How to use

To use the template, all you need to do is fill in the details at the top of the document file `main.typ`, in the `template.with()` function call. Most argument names are self-explanatory; as for the others:

 - `theme_fig`: a figure to be inserted at the top of the 2nd cover page, related to the thesis' theme.
 - `Logo1` and `Logo2`: company/research unit logos at the bottom of the 2nd cover page

If you don't want to use these features, just pass empty content `[]` or `none` to these arguments.

 - `header_title`: a (probably shorter) version of your title to appear in the page headers (under "FCUP")

Used packages:

 - [glossy](https://typst.app/universe/package/glossy/) >= 0.6.0 - for the Abbreviation list
    
 - [drafting](https://typst.app/universe/package/drafting) - for the margin notes
    
## Custom functions created for the template

 - `special-heading(outlined: false)[Heading]` - creates formatted unnumbered section headings (outlined argument is for including/excluding from table of contents)
 - `block-quote([Quote], [Attribution])` - makes a quote block, right aligned, with a divider and attribution at the bottom
 - `displayquote[Quote]` - to make a centered block without attribution
 - `margin-note-s[Note text]` - makes a pre-formatted margin note
 - `flex-caption(long: [], short: [])` - inserting in `caption:` argument of a figure allows you to define a long and a short version of the caption. The short will be used in the figure outline

## About
 
The goal was to replicate the original layout as closely as possible, while maintaining the document "clean" enough. This was not always possible, but nevertheless an effort was made to keep most of the heavy-lifting and messy code out of the way, in a separate template file. The default content does not make much sense, since it is about LaTeX features. Nevertheless, you can still use it to learn how some things are done in Typst. 

Some things are not exactly the same, if you look hard enough. This is sometimes due to limitations, and others because the original template has very nonsensical layout choices and inconsistencies (page margins and indentations change for no reason between sections, the Bibliography is called "References" in the outline, etc...). 

Additionally, the citation style is not exactly the same. The LaTeX template uses a modified IEEEtran for use with specifically the natbib LaTeX package. Here I just used the default IEEE style, with URLs added.

Finally, if you really want, you can figure out what code to change in the template file to customize it to your liking pretty easily.

If you need extra math symbols, operators, etc., for more complex equation typesetting, check out the really good [Physica](https://typst.app/universe/package/physica/) package.
To use it, all you need to do is import it at the start of the document: 

```
#import "@preview/physica:0.9.4": *
```

Finally, there are also handy packages for those who use a lot of scientific notation numbers / units: [zero](https://typst.app/universe/package/zero) and [unify](https://typst.app/universe/package/unify).

*Good luck with your thesis!*