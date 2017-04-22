block = {}

block.new = (model, x, y) ->
    b = {:model}
    world\add b, x, y, b.model.width * 2, b.model.height * 2
    b.draw = =>
        @model\draw!

    b.vertices = b.model.vertices
    b

block