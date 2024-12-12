# Credit

Stolen from https://gitlab.com/sscherfke/dotfiles

## Adding SSH Key to system specific configuration

`$HOME/.gitconfig-system-specific` is loaded, but not committed to this repo.  
Therefore, sensitive information and config might be stored here.

E. g., git commit signing configuration:

```txt
[gpg]
    format = "ssh"
[gpg "ssh"]
    allowedSignersFile = "~/.ssh/allowed_signers"
[commit]
    gpgsign = true
[user]
    signingkey = "~/.ssh/id_rsa.pub"
[log]
    showSignature = false
```
