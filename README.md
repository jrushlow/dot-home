# Dot Home

A collection of configuration files I use across my dev setup...

## Automation

_`install.sh` is tailored to meet my specific needs. Running this script IS a DESTRUCTIVE process. You shouldn't run this script unless you really know what you're doing. Even then, create backups of your files - don't rely soley on the `--backup` option._

- Requires Bash `>4.0`

To create symlinks to: 
- .gitconfig
- .gitignore_global
- .zshrc
- .zsh_custom

Run: 
```bash
./install.sh -o  # -o | --overwrite will replace existing files
```

This creates symlinks in your `$HOME` dir to the files in this repo

## Submodules

While my ssh (repo) setup doesn't have any sensitive information within it, I still don't trust myself not to accidentally do a `commit -m "super secret key" && git push` - so that repo is _private_.

### For me:
1) 
```bash
git submodule init
git submodule update
```

2) Go find your thumbdrive that has sensitive information

3) Copy the private keys to the appropiate location...
