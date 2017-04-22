block = {}

block.new = (model, x, y) ->
    b = {:model}
    world\add b, x, y, b.model.width, b.model.height
    b.draw = =>
        @model\draw!
        love.graphics.setColor 255, 0, 255
        love.graphics.rectangle "fill", x, y, @model.width * 2, @model.height * 2

    b.vertices = b.model.vertices
    b

block