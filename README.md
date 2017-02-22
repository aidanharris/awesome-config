# awesome-config
My config files for the Awesome window manager

## Usage

```bash
git clone https://github.com/aidanharris/awesome-config ~/.config/awesome
cd ~/.config/awesome
git submodule update --init
```
## Applications Menu

First make sure xdg_menu is installed on your system.

```bash
git update-index --assume-unchanged archmenu.lua # Don't track changes to archmenu.lua - We don't want a list of all our applications appearing in a remote git repository somewhere...
xdg_menu --format awesome --root-menu /etc/xdg/menus/arch-applications.menu >~/.config/awesome/archmenu.lua
```
