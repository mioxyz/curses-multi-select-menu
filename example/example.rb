#!/bin/ruby
require 'curses_multi_select_menu'

puts "you have selected: " + CursesMultiSelectMenu::invoke("Select multiple lines", %x(ls -lah $HOME).split("\n")).join(", ");
