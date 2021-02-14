state = {
    current: {}
}

state.change = (a) =>
    @current = a
    a\load!

state.update = (dt) =>
    @current\update dt

state.draw = =>
    @current\draw!

state.keypressed = (key) =>
    @current\key_press key

state.mousemoved = (x, y) =>
    @current\mouse_moved x, y

state.mousepressed = (x, y, mouse) =>
    @current\mouse_press mouse, x, y

state
