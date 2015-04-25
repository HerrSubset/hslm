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
### Overview Screen
The program is started by typing ``hslm`` in the command line and you'll find
an empty overview screen. This is the overview screen, where all your different price
comparisons are listed. You can use the following commands to perform actions
in this screen:

* ``create [name]`` creates a new price comparison project and immediately
takes you to the corresponding page.

* ``delete [name]`` deletes one of your price comparison projects.

* To select an existing project, just type its name.

* To return to the command line, type ``q``, ``back`` or ``exit``.

### Price Comparison Screen
This screen shows you the items and what they cost in different stores. There's
also a column with the lowest price per item, and a row with the totals of
every column. The way you interact with this screen is through the following
commands:

* ``update [storename] [itemname] [price]`` allows you to set the price for a specific item in a certain store. In case the item and/or the store doesn't exist yet, it will be created.

* ``remove <item/store> [name]`` allows you to remove an item with the given name.
For example, you would run ``remove item cpu`` if you want to remove the entire
row of prices for the item cpu.

* Finally, you can use ``q``, ``back`` or ``exit`` to return to the overview
screen.

There's no need to save your work, it's being taken care of on the fly.
