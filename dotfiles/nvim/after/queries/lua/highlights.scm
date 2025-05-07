; highlight TODO and NOTE inside comments
((comment) @comment.todo (#match? @comment.todo "TODO"))
((comment) @comment.note (#match? @comment.note "NOTE"))
