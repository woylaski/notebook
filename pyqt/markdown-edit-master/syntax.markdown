
line\n===       -> <h1>line</h1>                  // header level 1

# line          -> <h1>line</h1>                  // header level 1
## line         -> <h2>line</h2>                  // header level 2
### line        -> <h3>line</h3>                  // header level 3
#### line       -> <h4>line</h4>                  // header level 4
##### line      -> <h5>line</h5>                  // header level 5
###### line     -> <h6>line</h6>                  // header level 6

---             -> <hr />                         // horizontal ruler

**text**        -> <strong>text</strong>          // strong emphasis
__text__        -> <strong>text</strong>          // strong emphasis

*text*          -> <em>text</em>                  // emphasis
_text_          -> <em>text</em>                  // emphasis

~~text~~        -> <del>text</del>                // strikeout

<url>           -> <a href="url">url</a>          // inline link

[text](url)     -> <a href="url">text</a>         // named link

![text](url)    -> <img alt="text" src="url" />   // image

> line          -> <blockquote>line</blockquote>  // quote block (adjacent '</blockquote><blockquote>' merge)

`text`          -> <code>text</code>              // inline code

```block```     -> <pre>block</pre>               // fenced preformated block

\d+. line       -> <ol><li>line</li></ol>         // ordered list (adjacent '</ol><ol>' merge)

* line          -> <ul><li>line</li></ul>         // bullet list (adjacent '</ul><ul>' merge)
- line          -> <ul><li>line</li></ul>         // bullet list (adjacent '</ul><ul>' merge)
+ line          -> <ul><li>line</li></ul>         // bullet list (adjacent '</ul><ul>' merge)

| text |        -> <tr><td>text</td></tr>         // table row with N columns (wrap adjacent rows in '<table>')

\r              -> '\n'                           // fix newlines CR->LF
\t              -> '&nbsp;&nbsp;&nbsp;&nbsp;'     // turn tabs into 4 unbreakable spaces
\s+             -> ' '                            // collapse multiple spaces between words

\s*\.\s*        -> '. '                           // fix period (0 space before, 1 space after)
\s*,\s*         -> ', '                           // fix comma (0 space before, 1 space after)
\s*\;\s*        -> '&nbsp;; '                     // fix semi-colon (1 unbreakable space before, 1 space after)
\s*\:\s*        -> '&nbsp;: '                     // fix colon (1 unbreakable space before, 1 space after)
\s*\?\s*        -> '&nbsp;? '                     // fix question mark (1 unbreakable space before, 1 space after)
\s*\!\s*        -> '&nbsp;! '                     // fix exclamation mark (1 unbreakable space before, 1 space after)
\s*\.\.\.\s*    -> '... '                         // fix suspension mark (0 space before, 1 space after)

--              -> '&dash;'                       // convert 2 dash to long dash

^text           -> '<sup>text</sup>'              // handle supertext

<               -> '&lt;'                         // html entitize 'lower than'
>               -> '&gt;'                         // html entitize 'greater than'
&               -> '&amp;'                        // html entitize 'ampersand'

