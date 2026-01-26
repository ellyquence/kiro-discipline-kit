# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-01-25

### Added
- Initial release of Kiro Discipline Kit

#### Steering Files (7)
- `global.md` — Core engineering standards
- `architecture.md` — Living documentation requirements
- `backlog.md` — Task management enforcement
- `decomposition.md` — Component size limits (300 lines/file, 50 lines/function)
- `quality.md` — Quality gates and standards
- `typescript.md` — TypeScript/JavaScript rules
- `python.md` — Python-specific rules

#### Automated Hooks (6)
- `architecture-sync.kiro.hook` — Detects doc/code drift
- `task-hygiene.kiro.hook` — Enforces "no task, no code"
- `component-check.kiro.hook` — Validates size/coupling
- `doc-generation.kiro.hook` — Ensures doc coverage
- `test-on-save.kiro.hook` — Keeps tests in sync
- `security-scan.kiro.hook` — Audits dependencies

#### Templates (5)
- EARS notation requirements template
- C4 model architecture design template
- MoSCoW prioritized backlog template
- Component specification template
- Architecture Decision Record (ADR) template

#### Tooling
- `install-kiro-profile.sh` — Install script with symlink support

[1.0.0]: https://github.com/ellyquence/kiro-discipline-kit/releases/tag/v1.0.0
