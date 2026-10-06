# Contributing

Thanks for helping! This is a small single-script tool; keep it dependency-free.

## Workflow

1. Fork / branch from `main`: `git checkout -b feat/short-description`
2. Make changes in `bin/whoison`
3. `make lint && make test` — both must pass
4. Update `CHANGELOG.md` under **Unreleased**
5. Open a PR; CI must be green

## Conventions

- **Commits:** [Conventional Commits](https://www.conventionalcommits.org/) — `feat:`, `fix:`, `docs:`, `test:`, `chore:`
- **Versioning:** [SemVer](https://semver.org/); bump `VERSION` in `bin/whoison` and tag `vX.Y.Z`
- **Shell style:** bash 3.2 compatible (stock macOS), passes `shellcheck`, no root required
- Wrap variables next to multibyte text in braces: `"${u}（"` — `$u（` breaks in bash
