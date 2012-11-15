ø =
    id: (x) -> x

    flip: (f) -> (x, y) -> f(y, x)
    curry: (f, args...) -> (args_...) -> f(args..., args_...)
    apply: (f, args...) -> f(args...)
    comp: (f, g) -> (args...) -> f(g(args...))

    unshift: (x, xs) ->
        # Very verbose because JavaScript's Array constructor is moronic
        if xs.length is 0 then [x] else new Array(x, xs...)
    head: (xs) -> xs[0]
    tail: (xs) -> xs[1..]
    last: (xs) -> xs[xs.length - 1]
    init: (xs) -> xs[..xs.length - 2]
    null: (xs) -> xs.length is 0

    foldl: (f, z0, xs0) ->
        lgo = (z, xs) ->
            if ø.null(xs)
                z
            else
                lgo(f(z, ø.head(xs)), ø.tail(xs))
        lgo(z0, xs0)
    foldl1: (f, xs) -> ø.foldl(f, ø.head(xs), ø.tail(xs))
    sum: (xs) -> ø.foldl1(ø.add, xs)
    product: (xs) -> ø.foldl1(ø.multiply, xs)
    reverse: (xs) -> ø.foldl(ø.flip(ø.unshift), [], xs)

    map: (f, xs) -> f(x) for x in xs
    filter: (f, xs) -> x for x in xs when f(x)
    land: (xs) ->
        for x in xs
            return false unless x
        true
    lor: (xs) -> !ø.null(ø.filter(ø.id, xs))
    all: (f, xs) -> ø.comp(ø.land, ø.curry(ø.map, f))(xs)
    any: (f, xs) -> ø.comp(ø.lor, ø.curry(ø.map, f))(xs)

    succ: (x) -> x + 1
    pred: (x) -> x - 1
    even: (a) -> a % 2 is 0
    odd: (a) -> a % 2 isnt 0

    and: (a, b) -> a and b
    or: (a, b) -> a or b
    not: (a) -> not a

    add: (a, b) -> a + b
    subtract: (a, b) -> a - b
    multiply: (a, b) -> a * b
    divide: (a, b) -> a / b
    mod: (a, b) -> a % b
    negate: (a) -> -a

module.exports = ø
