pg-ffi
======

node.js ffi driver for libpq

## testing

Install the dev-dependencies:

```
    npm install
```

Create the test database:

```
    psql -U postgres -c 'CREATE DATABASE testing;'
```

Run the tests:

```
    npm test
```

## travis

[![Build Status](https://travis-ci.org/booo/pg-ffi.png)](https://travis-ci.org/booo/pg-ffi)
