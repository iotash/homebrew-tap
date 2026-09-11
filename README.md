# homebrew-tap

The Homebrew tap for [iota](https://github.com/iotash/iota) — an agent CLI for
the terminal.

```bash
brew install iotash/tap/iota
```

Or tap it once and install by name afterwards:

```bash
brew tap iotash/tap
brew install iota
```

`Formula/iota.rb` is generated: the iota release workflow
([cargo-dist](https://github.com/axodotdev/cargo-dist)) commits it here on every
`v*` tag, pointing at the macOS and Linux binaries attached to that GitHub
Release. Do not edit it by hand — the next release overwrites it.

Bugs and feature requests for iota itself belong in
[iotash/iota](https://github.com/iotash/iota/issues).
