# wallpaper
A small app written by vala. Just use this example to learn vala step by step and experience linux GUI coding.

# make
```
sudo apt-get install valac
sudo apt-get instal libsoup2.4-dev libjson-glib-dev
valac --pkg libsoup-2.4 --pkg posix --pkg gio-2.0 --pkg json-glib-1.0 -o wallpaper ./Bing.vala ./GetScreen.vala 
./wallpaper
```
