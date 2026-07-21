# Web Audit Action

[![Test](https://github.com/ElJijuna/web-audit-action/actions/workflows/test.yml/badge.svg)](https://github.com/ElJijuna/web-audit-action/actions/workflows/test.yml)
[![Latest release](https://img.shields.io/github/v/release/ElJijuna/web-audit-action)](https://github.com/ElJijuna/web-audit-action/releases)
[![License](https://img.shields.io/github/license/ElJijuna/web-audit-action)](LICENSE)
[![Marketplace](https://img.shields.io/badge/Marketplace-Web%20Audit%20Report-blue?logo=github)](https://github.com/marketplace/actions/web-audit-report)

A GitHub composite Action that audits a repository's dependencies (via `npm audit` or the equivalent command for `yarn`/`pnpm`/`bun`) and pushes the resulting JSON report to a separate repository (`MonitoringTool-DB` by default), so audit history can be tracked centrally across multiple projects.

## How it works

1. Checks out the calling repository.
2. Installs dependencies with the package manager selected via the `runtime` input.
3. Downloads and runs [`web-audit-report.sh`](https://github.com/ElJijuna/Bash-Scripts/blob/main/web-audit-report.sh) from the `ElJijuna/Bash-Scripts` repository, which runs the audit and writes a JSON report.
4. Uploads the report as a workflow artifact.
5. If `token` is set: clones the destination repository (`db_repo`, same owner/org as the calling repository) using it, downloads the report artifact into the clone, and commits/pushes it, skipping the commit if the report is unchanged. If `token` is omitted, this publish step is skipped and the run only produces the workflow artifact.

The audit logic itself lives in `Bash-Scripts`, not in this repo — this action only handles orchestration (installing deps, running the script, and publishing the result).

## Prerequisites

- **A destination repository** (`MonitoringTool-DB` by default, or whatever you set `db_repo` to) must already exist under the same GitHub owner/org as the repository running this action (the action clones `https://github.com/<owner>/<db_repo>.git`, where `<owner>` is `github.repository_owner`) — only required if you pass `token`.
- **A push token** for that repository, passed as the `token` input (e.g. a repo secret). It needs write access to the destination repository specifically — a classic PAT with the `repo` scope, or a fine-grained PAT with Contents: Read and write on that repository.
- **`pnpm` or `bun` must be installed separately** if you use those runtimes. GitHub's `ubuntu-latest` runner ships with Node.js, npm, and Yarn preinstalled, but not pnpm or bun — add a setup step (e.g. `pnpm/action-setup` or `oven-sh/setup-bun`) before this action in your workflow if you set `runtime: pnpm` or `runtime: bun`.

## Inputs

| Name    | Description                                                                                                                  | Required | Default             |
|---------|------------------------------------------------------------------------------------------------------------------------------|----------|---------------------|
| runtime | Package manager: `npm`, `yarn`, `pnpm`, or `bun`                                                                             | No       | `npm`               |
| token   | Token with push access to the destination repo. Omit to skip publishing (report is still generated/uploaded as an artifact). | No       | -                   |
| db_repo | Name of the destination repository (same owner/org as the caller)                                                            | No       | `MonitoringTool-DB` |
