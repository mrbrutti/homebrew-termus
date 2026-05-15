# homebrew-termus

Homebrew tap for [termus](https://github.com/mrbrutti/termus) — a terminal
music player that algorithmically generates ambient, jazz, lo-fi, classical,
drone, bells, lullaby, and phase music in real time.

## Install

```bash
brew tap mrbrutti/termus
brew install termus
termus
```

The default `general` SoundFont (32 MB) auto-downloads on first run.

For optimal per-genre sound (Tyros 4 for jazz, Fairy Tale Bank for bells,
Timbres of Heaven for classical, etc.), opt into the larger catalog:

```bash
termus --sf2-strategy=optimal
```

## Upgrade

```bash
brew update
brew upgrade termus
```

## Build from HEAD

To track the development branch instead of the latest release:

```bash
brew install --HEAD termus
```

## License

The formula in this repo is BSD-2-clause (Homebrew's tap convention).
termus itself is MIT — see [LICENSE in the main repo](https://github.com/mrbrutti/termus/blob/main/LICENSE).
