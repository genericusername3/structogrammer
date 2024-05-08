# structogrammer

Draw Nassi-Shneiderman diagrams, also called structograms, in Typst.

## Basic Usage

Import with:
```typ
#import "@preview/structogrammer:0.1.0": structogram
```

You can then draw structograms, like so:
```typ
#structogram(
  width: 30em,
  title: "merge_sort(list)",
  (
    (If: "list empty", Then: (Break: "exit (return list)")),
    "left = []",
    "right = []",
    (For: "element with index i", In: "list", Do: (
      (If: "i < list.length / 2", Then: (
        "left.add(element)"
      ), Else: (
        "right.add(element)"
      ))
    )),
    "left = merge_sort(left)",
    "right = merge_sort(right)",
    (Break: "return with merge(left, right)")
  )
)
```
which yields:
![The structogram specified by the code above](example.svg)

## Advanced usage

`structogram()` takes the following named arguments:
- `columns`:        If you already allocated wide and narrow columns, `to-elements`
                    can use them. Useful for sub-specs, as you'd usually generate
                    allocations first and then do another recursive pass to fill them. <br>
                    The default, `auto` does exactly this on the highest recursion level.
- `stroke`:         The stroke to use between cells, or for control blocks.
                    Note: to avoid duplicate strokes, every cell only adds strokes to
                    its top and left side. Put the resulting cells in a container with
                    bottom and right strokes for a finished diagram. See `structogram()`. <br>
                    Default: `0.5pt + black`
- `inset`:          How much to pad each cell. <br> Default: `0.5em`
- `segment-height`: How high each row should be. <br> Default: `2em`
- `narrow-width`:   The width that narrow columns will be. Needed for diagonals in
                    conditional blocks. <br>
                    Default: 1em

A `spec` (the positional argument to `structogram()`) can be one of the following:
- `none` or an emtpy [`array`](https://typst.app/docs/reference/foundations/array/) `()`:
  An empty cell,
  taking up at least a narrow column
- a [`string`](https://typst.app/docs/reference/foundations/str/) or [`content`](https://typst.app/docs/reference/foundations/content/):
  A cell containing that string or content,
  taking up at least a wide column
- A [`dictionary`](https://typst.app/docs/reference/foundations/dictionary/):
  Control block ([see below](#control-blocks))
- An [`array`](https://typst.app/docs/reference/foundations/array/) of specs:
  The cells that each element produced,
  stacked on top of each other. Wide columns
  are aligned to wide columns of other element
  specs and narrow columns consumed as needed.

### Control blocks

Specs can contain the following control blocks, as dictionaries:
#### `If`/`Then`/`Else`:

  A conditional with the following keys:

  - `If`: The condition on which to branch
  - `Then`: A diagram spec for the "yes"-branch
  - `Else`: A diagram spec for the "no"-branch

  `Then` and `Else` are both optional, but at least one must be present

  Examples:

  - `(If: "debug mode", Then: ("print debug message"))`
  - `(If: "x > 5", Then: ("x = x - 1", "print x"), Else: "print x")`

  Columns: Takes up columns according to its contents next to one another,
  inserting narrow columns for empty branches

#### `For`/`Do`, `For`/`To`/`Do`, `For`/`In`/`Do`, `While`/`Do`, `Do`/`While`:

  A loop, with the loop control either at the top or bottom.

  - `For`/`Do` formats the control as "For $For",
  - `For`/`To`/`Do` as "For $For to $To",
  - `For`/`In`/`Do` as "For each $For in $In",
  - `While`/`Do` and `Do`/`While` as "While $While".

  Order of specified keys matters.

  Examples:
  - `(While: "true", Do: "print \"endless loop\"")`  (regular while loop)
  - `(Do: "print \"endless loop\"", While: "true")`  (do-while loop)
  - `(For: "item", In: "Container", Do: "print item.name")`

  Columns: Inserts a narrow column left to its content.

#### Method call (`Call`)

  A block indicating that a subroutine is executed here.
  Only accepts the key `Call`, which is the string name

  Example:

  - `(Call: "func()")`

  Columns: One wide column

#### Break/Return (`Break`)

  A block indicating that a subroutine is executed here.
  Only accepts the key `Break`, which is the target to break to

  Examples:

  - `(Break: "")`
  - `(Break: "to enclosing loop")`

  Columns: One wide column