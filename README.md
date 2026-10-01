# Dotfiles

My personal dotfiles, managed as a bare Git repository.

Configuration files are tracked directly in `$HOME`, so no symlinks are required. The bare repository itself is stored in `$HOME/.cfg`.

The configuration is intended to be usable on both Linux and Windows, but Windows setups will need Git Bash installed in order to run commands and use certain scripts.

This setup is based on the Atlassian article, [The best way to store your dotfiles: A bare Git repository](https://www.atlassian.com/git/tutorials/dotfiles).

## Shell alias

I use the following shell alias to manage the repository (this is also in `.bashrc`):

```bash
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

Examples:

```bash
config status
config add .bashrc
config commit -m "Update bash config"
config push
```

## Setting up on a new machine

Clone the bare repository:

```bash
git clone --bare <repo-url> "$HOME/.cfg"
```

Define the alias, if not using the `.bashrc` that already contains it:

```bash
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

If needed, append the alias to your `.bashrc` (again, this repo's `.bashrc` already has it):

```bash
echo "alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.bashrc
```

Check out the files:

```bash
config checkout
```

If Git reports that existing files would be overwritten, move or back up those files and run `config checkout` again.

Hide untracked files from `config status` (only for this repository):

```bash
config config --local status.showUntrackedFiles no
```

If using the pre-commit hook, it may need to be set as executable:

```bash
chmod +x ~/.githooks/pre-commit
```

## Additional tools

### git-summary

`~/bin/git-summary` is a simple Bash utility that scans a directory of Git repositories and reports working tree status and stashes for each. It can also optionally run a fetch on each repository, reporting the results if there was anything to fetch.

The script may need to be set as executable:

```bash
chmod +x ~/bin/git-summary
```

Usage:

```bash
git-summary
git-summary -fb
```

### Git aliases

#### `lg`

Display a compact graph of all branches and tags:

```bash
git config --global alias.lg 'log --all --decorate --graph --oneline'
```

Usage:

```bash
git lg
git lg -20
```

#### `lgd`

Display the commit date in addition to the compact graph:

```bash
git config --global alias.lgd 'log --all --decorate --graph --date=short --pretty=format:"%C(yellow)%h%Creset %C(magenta)%ad%Creset%C(auto)%d%Creset %s"'
```

```bash
git lgd
git lgd -20
```

## Resources

- [ANSI text generator](https://patorjk.com/software/taag/#p=display&f=ANSI+Shadow)
- [The best way to store your dotfiles: A bare Git repository](https://www.atlassian.com/git/tutorials/dotfiles)

