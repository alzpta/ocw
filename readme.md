Documentation
=============

Starting server
---------------

This application uses Middleman to render static content and precompile assets.
It also runs a compiled version of the code using Phonegap.

```sh
gem install middleman
```

To start the server use the following command:

```sh
cd path/to/app
middleman server
```

Installing javascript libraries
-------------------------------

Modify the file bower.json to include the desired library (refer to bower documentation) and use the following command to update the repository:

```sh
bower install
```

Building and deploying
----------------------

```sh
cd path/to/app
middleman build
```

This will generate a ```www``` folder with static asset