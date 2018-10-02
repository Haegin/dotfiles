# Ptah - The Highline BETA Laptop Setup Tool

Ptah aims to get you up and running with your new laptop as fast as possible.
It'll install some useful software and set up a terminal environment that
doesn't make you want to tear your eyes out.

## How do I install it?

### The fast way

Open the Terminal and run this:

```
sh -c "$(curl -sSL https://highlinebeta.github.io/ptah/setup.sh)"
```

You'll need to watch as it'll prompt for your password during the installation.

### The secure way

If you don't like the idea of running untrusted code straight from the internet
then we commend your paranoia. Either download the script above, read it to
work out what it's doing and run it when you're happy nothing malicious will
happen, or follow the steps below.

1. Open the Terminal
2. Install the XCode Command Line tools by running `xcode-select --install` and
   following the prompts
3. Run `git clone https://github.com/HighlineBETA/ptah.git .dotfiles`
4. Run the ptah setup script: `./.dotfiles/bin/setup`
5. Follow the prompts from the script. You'll need to enter your password when
   prompted.

## What software is installed?

- Google Chrome
- Slack
- Adobe Reader
- GPG Suite
- Keybase (for sharing secure information such as passwords)
- VS Code (our default text editor)
- ITerm 2 (our default terminal app)

We also install a range of command line tools:

- Zsh (our default shell)
- Git
- Wget
- Z
- Direnv (used for configuring environment variables in all our projects)
- Antibody (the Zsh plugin manager)
- Ripgrep (a faster replacement for grep with some very nice modernisations)
- Exa (a modern ls replacement)
- Fd (a modern fd replacement with similar modernisations to ripgrep)
