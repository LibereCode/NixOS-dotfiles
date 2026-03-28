# NixOS-dotfiles

Hyprland NixOS dotfiles, on an old-shit-laptop.

## ABOUT

Have no Idea what I am doing, but at least it works now.
I installed it with [minimal-ISO](https://nixos.org/download/#minimal-iso-image) (cli).
I use [Flakes](https://nixos.wiki/wiki/flakes) and [Home-manager](https://nix-community.github.io/home-manager/)

### Brick

Sadly, when I tried to first tried to `git push`, I did a 
couple of mistakes:

1. Ran `git rebase ...`, which removed my shit
2. Tried to restore with `git checkout <prev commit>`,
    but only managed to wipe the prev files from even them.3. Just changed to `git merge` and it worked, but damage al  ready done...

Lesson learned? Use `git merge` istead of `git rebase` 
    (when wanting to pull-to-push a new remote)

### THIS BRANCH

This is the first working NixOS config on my oldshitlaptop
