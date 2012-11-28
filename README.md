ø
=

ø is a functional programming library written in CoffeeScript that you
can use in JavaScript and CoffeeScript.

Installation
------------

Add ø to your dependencies in `package.json`:

    {
        "dependencies": {
            "o-lib": "0.1.x"
        }
    }

And then run:

    $ npm install

Usage
-----

    var ø = require('o-lib');
    console.log(ø.filter(ø.odd, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]));

This will print all odd numbers from one to ten.
