# Dotfiles

My personal dotfiles, managed as a bare Git repository.

Configuration files are tracked directly in `$HOME`, so no symlinks are required. The bare repository itself is stored in `$HOME/.cfg`.

This setup is based on the Atlassian article, [The best way to store your dotfiles: A bare Git repository](https://www.atlassian.com/git/tutorials/dotfiles).

## Alias

I use the following shell alias to manage the repository (this is also in `.bashrc`):

```sh
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

Examples:

```sh
config status
config add .bashrc
config commit -m "Update bash config"
config push
```

## Setting up on a new machine

Clone the bare repository:

```sh
git clone --bare <repo-url> "$HOME/.cfg"
```

Define the alias, if not using the `.bashrc` that already contains it:

```sh
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

If needed, append the alias to your `.bashrc` (again, this repo's `.bashrc` already has it):

```sh
echo "alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.bashrc
```

Check out the files:

```sh
config checkout
```

If Git reports that existing files would be overwritten, move or back up those files and run `config checkout` again.

Hide untracked files from `config status`:

```sh
config config --local status.showUntrackedFiles no
```

If using the pre-commit hook, it may need to be set as executable:

```sh
chmod +x ~/.githooks/pre-commit
```

## Resources

- [ANSI text generator](https://patorjk.com/software/taag/#p=display&f=ANSI+Shadow)
- [The best way to store your dotfiles: A bare Git repository](https://www.atlassian.com/git/tutorials/dotfiles)

