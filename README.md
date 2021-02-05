This is not a fork. This is a repository of scripts to automatically build
[Foundry376/Mailspring](https://github.com/Foundry376/Mailspring)
into telemetry-free binaries with a community-driven default configuration.

Usage:

```sh
sudo apt install ripgrep moreutils build-essential clang libx11-dev libxkbfile-dev \
                 execstack fakeroot g++-4.8 git libgnome-keyring-dev libgconf-2-4 \
                 libsecret-1-dev xvfb rpm libxext-dev libxtst-dev libxkbfile-dev curl
bash build.sh
```

