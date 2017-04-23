block = {}

block.new = (model, x, y, tag) ->
    b = {:model, :tag}
    world\add b, x, y, b.model.width * 2, b.model.height * 2
    b.draw = =>
        @model\draw!

    b.vertices = b.model.vertices
    b

block