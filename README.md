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

## Installing Neovim

This repo contains Neovim config files intended to be used with LazyVim. I also use Neovide as a Neovim GUI client.

Install Neovim and Neovide using the system package manager (both are available through `winget` on Windows).

> [!NOTE]
> I have noticed that in some situations, Neovide will not work correctly if installed through a
> package manager on Linux. Building it from source instead should fix these issues.
> The [Neovide website](https://neovide.dev/installation.html#linux-source) has simple instructions for this using Cargo.

Install the [LazyVim starter](https://www.lazyvim.org/installation), using the default location it recommends. LazyVim will install its default plugins on first launch.

Using Noice (included in LazyVim) with Neovide can produce errors about `ext_messages` and `ext-cmdline`. To fix these, add `--no-startup-message-capture` to Neovide's launch command.

## Font installation

My Neovim config uses `JetBrainsMonoNL Nerd Font`, which includes icons that are used throughout Neovim. Install this font from the [Nerd Fonts website](https://www.nerdfonts.com).

To use a different font, you will need to change `vim.o.guifont` in `.config/nvim/init.lua`.

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

If you would like to use the pre-commit hook in this repository, it will first need to be set as executable:

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

