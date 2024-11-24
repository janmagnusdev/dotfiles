# Credit

Stolen from https://gitlab.com/sscherfke/dotfiles

## Adding SSH Key to system specific configuration

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
