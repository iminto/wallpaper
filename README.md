# wallpaper
A small app written by vala. Just use this example to learn vala step by step and experience linux GUI coding.

# make
```
sudo apt-get install valac
sudo apt-get instal libsoup2.4-dev libjson-glib-dev
valac --pkg libsoup-2.4 --pkg posix --pkg gio-2.0 --pkg json-glib-1.0 -o wallpaper ./Bing.vala ./GetScreen.vala 
./wallpaper
```

# tip 
different desktops use different commands.
```
-- deepin:
gsettings set com.deepin.wrap.gnome.desktop.background picture-uri file:/// 
-- cinnamon:
gsettings set org.cinnamon.desktop.background picture-uri file:///
-- xfce
xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/workspace0/last-image -s 
```
# config
see config.json 
desktop: select your desktop enviroment,now support deepin,cinnamon and xfce. 
api:select which api/website you'll  used to download wallpaper. 
frequency:how long do you wish to change the wallpaper,default 30 means changing wallpaper every 30 minutes. 
order: 1 means rank by order,2 means rand by random.
