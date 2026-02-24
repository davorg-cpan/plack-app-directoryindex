# Copilot Instructions for plack-app-directoryindex

## Repository Overview

This repository contains `Plack::App::DirectoryIndex`, a Perl CPAN module that extends
`Plack::App::Directory` to serve static files with support for default directory index
files (e.g. `index.html`). Unlike the parent class, when a directory is requested this
module first checks for a configured index file and serves it if present; otherwise it
falls back to a directory listing rendered via `WebServer::DirIndex`.

## Repository Layout

```
lib/Plack/App/DirectoryIndex.pm   # The sole source module
t/directory_index.t               # Test suite (Test::More + Plack::Test)
t/share/                          # Shared test fixtures directory
Makefile.PL                       # Build configuration (ExtUtils::MakeMaker)
Changes.md                        # Changelog (Keep a Changelog format)
README.md                         # Brief project description
.github/workflows/perltest.yml    # CI: test, coverage, perlcritic, complexity
.github/workflows/copilot-setup-steps.yml  # Copilot agent setup steps
```

## Language and Toolchain

- **Language**: Perl 5 (requires Perl ≥ 5.38.0)
- **Build system**: `ExtUtils::MakeMaker` via `Makefile.PL`
- **Dependency manager**: `cpanm` (App::cpanminus)
- **Test framework**: `Test::More` with `Plack::Test`

## Key Dependencies

| Module | Role |
|---|---|
| `Plack` | PSGI web framework (base classes `Plack::App::Directory`, `Plack::App::File`) |
| `WebServer::DirIndex` | Generates the HTML directory-listing page |
| `Test::More` | Test harness (build/test only) |

## Setup

Install all runtime and development dependencies:

```sh
cpanm --installdeps --with-develop --notest .
```

Generate the `Makefile` from `Makefile.PL`:

```sh
perl Makefile.PL
```

## Building

```sh
make
```

## Running Tests

Run the full test suite:

```sh
make test
```

Or directly with `prove`:

```sh
prove -l t/
```

Individual test file:

```sh
perl -Ilib t/directory_index.t
```

## Linting / Code Quality

CI runs `perlcritic` (strict Perl Best Practices linting). To run it locally:

```sh
perlcritic lib/
```

CI also checks McCabe complexity:

```sh
# Installed via cpanm Perl::Critic::Policy::Modules::ProhibitExcessMainComplexity
perlcritic --severity 1 lib/
```

## CI Workflows

CI is handled by GitHub Actions, reusing shared workflows from
`PerlToolsTeam/github_workflows`. The jobs triggered on `push`/`PR` to `main` are:

| Job | Workflow | Purpose |
|---|---|---|
| `test` | `cpan-test.yml` | Run tests on ubuntu-latest and macos-latest with latest Perl |
| `coverage` | `cpan-coverage.yml` | Measure test coverage and report to Coveralls |
| `perlcritic` | `cpan-perlcritic.yml` | Static analysis with Perl::Critic |
| `complexity` | `cpan-complexity.yml` | McCabe complexity check |

## Module Architecture

`Plack::App::DirectoryIndex` is a minimal subclass that overrides only `serve_path`:

1. If the requested path is a directory **and** a directory index file exists there,
   redirect to and serve that file via the parent class.
2. If the path is already a file, delegate to `Plack::App::Directory::serve_path`.
3. Otherwise, build a `WebServer::DirIndex` object and render an HTML directory listing.

### Configuration Attributes (via `Plack::Util::Accessor`)

| Attribute | Default | Description |
|---|---|---|
| `root` | current directory | Document root (inherited from `Plack::App::File`) |
| `dir_index` | `'index.html'` | Index filename; set to `''` to disable |
| `pretty` | false | Use enhanced CSS for directory listings |

## Making Changes

- The main logic lives entirely in `lib/Plack/App/DirectoryIndex.pm`.
- Update `Changes.md` following the Keep a Changelog format when making user-visible changes.
- Bump `$VERSION` in `lib/Plack/App/DirectoryIndex.pm` for releases (Semantic Versioning).
- Tests are in `t/directory_index.t`; add new `test_psgi` blocks to cover new behaviour.
- The `t/share/` directory is used as the document root during tests; the `.marker` file
  keeps it in source control. Tests create and remove temporary files (e.g. `index.html`)
  inside this directory as needed.

## Common Errors and Workarounds

- **`MYMETA.*` and `Makefile` are git-ignored**: These are generated artefacts produced
  by `perl Makefile.PL`. Do not add them to the repository.
- **Missing `WebServer::DirIndex`**: If tests fail with `Can't locate WebServer/DirIndex.pm`,
  run `cpanm --installdeps --notest .` to install dependencies.
- **Perl version requirement**: The module requires Perl ≥ 5.38.0. Ensure the correct
  Perl version is active (use `perlbrew` or `plenv` to manage versions locally).
  The Copilot setup workflow installs Perl 5.40 via `shogo82148/actions-setup-perl`.
