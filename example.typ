#import "structogrammer/main.typ": structogram

#set page(width: auto, height: auto, margin: 4pt, fill: rgb("0000"))
#set text(lang: "de")

// #set text(font: "IBM Plex Mono")

#structogram(
  title: "method_title()",
  (
    // Regular chaining
    (
      "do this first",
      "then this",
    ),
    // Conditionals
    (
      If: "condition",
      Then: "do this",
      Else: "or this",
    ),
    (
      If: "condition",
      Then: "or this",
    ),
    (
      If: "condition",
      Else: "or this",
    ),
    // While loops
    (
      While: "condition",
      Do: "repeat this"
    ),
    (
      Do: "repeat this",
      While: "condition",
    ),
    // For loops
    (
      For: "element",
      In: "container",
      Do: "repeat this",
    ),
    (
      For: "i = 0",
      To: "6",
      Do: "repeat this",
    ),
    (
      For: "<?>",
      Do: "repeat this",
    ),
    // Nesting
    (
      For: "element",
      In: "container",
      Do: (
        If: "condition",
        Then: (
          "A",
          (
            While: "true",
            Do: "do something"
          )
        )
      )
    ),
    // Call
    (Call: "method Name"),
    // Break
    (Break: "target"),
    // Normal block again
    "block",
  ),
)