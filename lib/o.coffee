ø =

#### Identity functions

    # `id` returns its argument.
    id: (x) -> x

    # `list` returns a list of the given arguments.
    #
    #     ø.list(1, 2, 3) # => [1, 2, 3]
    #
    # This function is an alternative to `new Array()`, which behaves
    # differently when it is given only one argument.
    list: (xs...) -> xs

#### Generic higher-order functions

    # `flip` takes a binary function and returns a new function with
    # the arguments interchanged.
    flip: (f) -> (x, y) -> f(y, x)

    # `curry` takes a function and a variable number of arguments, and
    # returns a new function with those arguments bound to the first
    # arguments of the given function.
    #
    #     var logAll = ø.curry(ø.map, console.log);
    curry: (f, args...) -> (args_...) -> f(args..., args_...)

    # `apply` applies the given arguments to the given function.
    apply: (f, args...) -> f(args...)

    # `comp` returns a new function by composing the two given
    # functions.
    comp: (f, g) -> (args...) -> f(g(args...))

#### Manipulating lists

    # `unshift` returns a new list by prepending the first argument.
    unshift: (x, xs) -> ø.list(x, xs...)

    # `head` returns the first element of the list.
    head: (xs) -> xs[0]

    # `tail` returns the list sans its first element.
    tail: (xs) -> xs[1..]

    # `last` returns the last element of the list.
    last: (xs) -> xs[xs.length - 1]

    # `init` returns the list sans its last element.
    init: (xs) -> xs[..xs.length - 2]

    # `null` returns `true` iff the list is empty.
    null: (xs) -> xs.length is 0

    # `elem` returns `true` iff the first argument occurs in the list.
    elem: (x, xs) -> ø.any(ø.curry(ø.eq, x), xs)

    # `length` returns the length of the list.
    length: (xs) -> xs.length

    # `glue` concatenates two lists.
    glue: (xs, ys) -> ø.list(xs..., ys...)

    # `map` applies a function to all elements of the list, returning
    # a new list with the return values of the function.
    map: (f, xs) -> f(x) for x in xs

    # `filter` returns a list of all the elements in the given list for
    # which the given function returns `true`.
    filter: (f, xs) -> x for x in xs when f(x)

    # `land` returns `true` iff all elements in the list are `true`.
    land: (xs) ->
        for x in xs
            return false unless x
        true

    # `lor` returns `true` if at least one element in the list is `true`.
    lor: (xs) -> not ø.null(ø.filter(ø.id, xs))

    all: (f, xs) -> ø.comp(ø.land, ø.curry(ø.map, f))(xs)

    any: (f, xs) -> ø.comp(ø.lor, ø.curry(ø.map, f))(xs)

#### Folding

    # `foldl` does a left-associative fold of a structure.
    foldl: (f, z0, xs0) ->
        lgo = (z, xs) ->
            if ø.null(xs) then z
            else lgo(f(z, ø.head(xs)), ø.tail(xs))
        lgo(z0, xs0)

    # `foldl1` is the same as `foldl` except it uses the head of the
    # list as the initial value.
    foldl1: (f, xs) -> ø.foldl(f, ø.head(xs), ø.tail(xs))

    # `foldl` does a right-associative fold of a structure.
    foldr: (f, z, xs) ->
        go = (ys) ->
            if ys.length is 0 then z
            else f(ø.head(ys), go(ø.tail(ys)))
        go(xs)

    # `foldr1` is the same as `foldr` except it uses the head of the
    # list as the initial value.
    foldr1: (f, xs) ->
        if xs.length is 1
            ø.head(xs)
        else
            f(ø.head(xs), foldr1(f, ø.tail(xs)))

    # `sum` and `product` are pretty self-explanatory.
    sum: (xs) -> ø.foldl1(ø.add, xs)
    product: (xs) -> ø.foldl1(ø.multiply, xs)

    # `reverse` reverses the given list.
    reverse: (xs) -> ø.foldl(ø.flip(ø.unshift), [], xs)

    # `concat` concatenates the lists in the given list.
    #
    #     ø.concat([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
    #         # => [1, 2, 3, 4, 5, 6, 7, 8, 9]
    concat: (xss) -> ø.foldr(ø.glue, [], xss)

    concatMap: (f, xs) -> ø.foldr(ø.comp(ø.glue, f), [], xs)

#### Basic mathematics

    # `succ` and `pred` respectively return the successor and
    # predecessor of the given value.
    succ: (x) -> x + 1
    pred: (x) -> x - 1

    # `even` and `odd` return whether their arguments are even or odd,
    # respectively.
    even: (a) -> a % 2 is 0
    odd: (a) -> a % 2 isnt 0

#### Operators

# These functions map to JavaScript's operators. They are useful in
# certain higher-order situations. For example, if you want to compare
# all elements in a list and return a new list of Booleans, you can use
# `eq`:
#
#     ø.map(ø.curry(ø.eq, 42), my_list)

    and: (a, b) -> a and b
    or: (a, b) -> a or b
    not: (a) -> not a

    add: (a, b) -> a + b
    subtract: (a, b) -> a - b
    multiply: (a, b) -> a * b
    divide: (a, b) -> a / b
    mod: (a, b) -> a % b
    negate: (a) -> -a

    eq: (x, y) -> x is y
    neq: (x, y) -> x isnt y
    gt: (x, y) -> x > y
    gte: (x, y) -> x >= y
    lt: (x, y) -> x < y
    lte: (x, y) -> x <= y

module.exports = ø
