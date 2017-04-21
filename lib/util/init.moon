is_callable = (x) ->
    (nil != (getmetatable x).__call or "function" == type x)

combine = (...) ->
    _error = "expected function or nil - angery!?!1"

    n = select "#", ...

    return noop if n == 0

    if n == 1
        fn = select 1, ...

        return noop unless fn

        assert (is_callable fn), _error

        return fn

    funcs = {}

    for i = 1, n
        fn = select i, ...

        if fn != nil
        assert (is_callable fn), _error
        funcs[#funcs + 1] = fn

    (...) ->
        for f in *funcs
        f ...
