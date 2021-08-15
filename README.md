# Windows dofiles (Configuration repo)

This is still a work in progress and completely untested on real usages.

The idea is to be able to very easily set up everything I need on a windows machine.
Configuration files are symlinked.

### Usage (In order to be able to properly run this, the dotfiles-common repository is also needed):
```
mkdir ~/.repos
mkdir ~/.repos/rezzmk
git clone https://github.com/rezzmk/dotfiles-common.git ~/.repos/rezzmk/dotfiles-common
git clone https://github.com/rezzmk/dotfiles-windows.git ~/.repos/rezzmk/dotfiles-windows
```

TODO:
- Add chocolatey/scoop to install most of my tools in one run
- Finish adding the configuration files I need
