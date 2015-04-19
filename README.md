# Herr's Shopping List Manager

A CLI tool that easily allows to compare prices for products among different stores.

## Installation

This project has the following dependencies you need to have installed:
* [Lua File System](https://keplerproject.github.io/luafilesystem/manual.html)
* [Lua-csv](https://github.com/geoffleyland/lua-csv)
* [Lcurses](http://www.pjb.com.au/comp/lua/lcurses.html#installation)

This project was made with lua 5.1, but should also run on lua 5.2 and luaJIT.

When you have all the dependencies, simply clone the project to a folder of
your choice by running following command:

```bash
  git clone https://github.com/HerrSubset/hslm
```
To install the project, simply run:
```bash
  sudo make install
```

## Usage
Currently, the program only lets you compare prices for one project at a time.
You can start the program with ``hslm`` and you'll find an empty screen. There
are three commands to do things now:

* ``update [storename] [itemname] [price]`` allows you to set the price for a
specific item in a certain store. In case the item and/or the store doesn't
exist yet, it will be created.

* ``remove <item/store> [name]`` allows you to remove an item with the given.
For example, you would run ``remove item cpu`` if you want to remove the entire
row of prices for the item cpu.

* Finally, you can use ``q``, ``back`` or ``exit`` to quit the program.
