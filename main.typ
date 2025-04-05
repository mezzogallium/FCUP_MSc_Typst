#import "fcup_template.typ": *

#show: template.with(
  // Fill in:
  /*
  thesis_title: [],
  thesis_author: [],
  year: [],
  supervisor: [],
  co-supervisor: [],
  ext-supervisor: [],
  faculty: [],
  department: [],
  thesis_type: [],
  course_name: [],
  theme_fig: [], 
  Logo1: [], 
  Logo2: [],
  Dedication: [],
  Acknowledge: [],
  Resumo: [],
  palavras-chave: [],
  Abstract: [],
  keywords: [],
  header-title: [],
  show-table-list: true
  */
  )

= Chapter Title Here

Welcome to the tutorial on how to use this thesis model. This is not to teach you how to use #typst-logo. For that read a tutorial. But this aims to teach you how to do the basic stuff you will need in order to produce a decent document. We can start with a section and a section epigraph:


== Citations

#block-quote([Python is a truly wonderful language. When somebody comes up with a good idea it takes about 1 minute and five lines to program something that almost does what you want. Then it takes only an hour to extend the script to 300 lines, after which it still does almost what you want.], 
[Dr. Jack Jansen, maintainer of MacPython])


You can add extra info to you references, like @Fienup1982[section 3]. You can also call them by author, like saying #cite(<Fienup1982>, form: "author") @Fienup1982. #margin-note-s[You can make personal notes like this.]

// Note: Using @ is the recommended way to cite or reference labelled objects in Typst

Also a random displayquote thing:

#displayquote([
  How can we image an object that’s behind or enclosed on a medium where light does not propagate trivially? How can we manipulate light propagating in these media?
])


== Figures

Let us start with a figure with two subfigures like in @TwoSubfigs.

#figure(
  grid(columns: 2, rows: 2, column-gutter: 6pt, row-gutter: 0pt, align: left, inset: 6pt,
  image("Img/20160517_123603.jpg"),
  image("Img/20160517_123609.jpg"),
  text(size: 9pt)[#h(11.5%) (a) FCUP’s fat cat doing what cats do.],
  text(size: 9pt)[#h(11.5%) (b) FCUP’s fat cat resting.]),
  caption: [FCUP’s fat cat.],
) <TwoSubfigs>

Or two figures side by side like @Subfig1 and @Subfig2.

#grid(columns: 2, column-gutter: 6pt, inset: 6pt,
  [#figure(image("Img/20160517_123603.jpg"),
    caption: [FCUP’s fat cat doing what
cats do.]) <Subfig1>],
  [#figure(image("Img/20160517_123609.jpg"),
    caption: [FCUP’s fat cat.]) <Subfig2>]
)

Or a figure with some text on the side, like @Subfig3, or even a figure wrapped around in text, as seen on @Subfig4.

#grid(columns: 2, column-gutter: 6pt, inset: 6pt,
  align(horizon)[And here we have some text related to this
image. The text can occupy the same space
as the image would normally do.],
  [#figure(image("Img/20160517_123609.jpg"),
    caption: [FCUP’s fat cat.]) <Subfig3>]
)

// The easiest way to wrap text around figures for now is to use grids

#text(red)[This is where the float goes with text wrapping around it. You may embed tabular en-
vironment inside wraptable environment and customize as you like:] Ultrices dui sapien eget mi proin sed libero. Ornare lectus sit amet est placerat in egestas erat imperdiet. Tortor dignissim convallis aenean et. Quam adipiscing vitae proin sagittis nisl rhoncus mattis. Vivamus at augue eget arcu dictum varius duis. Cursus turpis massa tincidunt dui. 
#v(-8pt)
#grid(columns: (1fr, 1.25fr), column-gutter: 6pt, inset: (0pt,8pt),
[Leo in vitae turpis massa sed. Tempor orci eu lobortis elementum. Turpis egestas integer eget aliquet nibh praesent tristique magna. Sed blandit libero volutpat sed cras ornare arcu dui. Feugiat sed lectus vestibulum mattis ullamcorper velit sed ullamcorper. Interdum velit euismod in pellentesque massa ],
  [#figure(image("Img/20160517_123609.jpg"),
    caption: [FCUP’s fat cat.]) <Subfig4>]
)
#v(-12pt)
placerat duis ultricies lacus. Ac ut consequat semper viverra nam. Dis parturient montes
nascetur ridiculus mus. Mattis pellentesque id nibh tortor.

=== SVGs

// Note: Typst natively supports SGV images, just place them like any other image file
How to make a #typst-logo document with vector images, where the text in the images has exactly the same font and size as in normal text? This article describes how this is done using the ‘PDF/EPS/PS + LaTeX’ output feature of Inkscape 0.48. Inkscape can export the graphics to PDF/EPS/PS, and the text to a LaTeX file. When the LaTeX file is input in the LaTeX document, the PDF/EPS/PS image is included with overlaid text. Because typesetting of the text is done by LaTeX, LaTeX commands can be used in images, such as writing equations, references and shorthand macros. 

_(requires Inkscape version 0.48 or higher; this document discusses features up to Inkscape 0.49)_


#figure(
  image("Img/image-normal.svg"), caption: 
  flex-caption(long: [The test SVG image, as it is seen in Inkscape (exported to PDF without LaTeX option).], short: [The test SVG image, as it is seen in Inkscape.])
) <SVG>

// flex-caption allows you to define a short and a long version of a figure's caption. The short is shown in the figure outline.

\
$ E = m c^2 $

\

=== Tables

You can also create tables, and show the Table list at the start of the document.

#figure(
  table(
    columns: 3, rows: 2,
    table.header("1", "2", "3"),
    [A], [B], [C]
  ),
  caption: flex-caption(
    short: [Short table caption],
    long: [Looooooooooooong table caption]
  )
)

==== Automatic export

(‘write18’ must be enabled, see the `epstopdf` package documentation. Add `-shell-escape` to the command line when calling `pdflatex`. #text(red)[And inkscape must be discoverable by the
OS]),

Whenever the SVG file is updated, it is possible to have LaTeX automatically call Inkscape to export the image to PDF and LaTeX again. This simplifies the workflow to

- Modify the SVG image in Inkscape;
- Save the SVG (Ctrl+S, no need to export to PDF);
- Recompile LaTeX document. pdfLaTeX will notice the SVG file has changed, and will automatically do the export for you.

#figure(
  image("Img/image2.png", width: 73%), placement: auto,
  caption: [The test image, exported to PDF with LaTeX option.]
)

== Math

The following equation uses a custom mathematical operator defined in line 88 of preamble.tex:

$ limits("meshgrid")_(sans(bold(x))_1, sans(bold(x))_2) thin sans(bold(x))_1 = mat(a_1, b_1, c_1;
                                    a_1, b_1, c_1)\
  limits("meshgrid")_(sans(bold(x))_1, sans(bold(x))_2) thin sans(bold(x))_2 = mat(a_1, b_1, c_1;
                                    a_1, b_1, c_1)\ $

The following equation uses the custom ceil and floor operator defined in line 86 of the stock preamble.tex:

$ x = floor(y/2) + ceil(w/2) $

And this is an equation with multiple lines:

$ I_0 = I' + I'' cos(Psi)\

I_(pi\/2) = -I'' sin(Psi)\

I_pi = I' - I'' cos(Psi)\

I_(3 pi\/2) = I'' sin(Psi) $

And this is some random Python code:

```py
def Hello():
    """
     Meaningful docstring with in-depth explanation of this function
    """
    print(``Hello World !!'')

if __name__ == '__main__':
    Hello()
```

== Abreviations

Use acronyms like this: #h(6pt) @ANN, @RI:long
// Acronyms should be defined in the glossary at the top of the document. The first time you @ reference an entry, it will spell it out with the long + (short) version. After that, just the short appears. Check glossy package docs for extra features


#special-heading(outlined: true)[References]
#bibliography("Bibliography.bib", title: none, style: "ieee-with-url.csl")

#special-heading[Appendix Title Here]
Write your Appendix content here.