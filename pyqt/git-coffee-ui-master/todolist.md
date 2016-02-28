TODOLIST
========

_This document lists the features that the application will need to implement..._



## General

The application actions / information are grouped inside modes. This section contains global actions / options that are common to all modes.

- Last repos used list
- Some help balloons in strategic places (can be disabled)
- Mono-window (one instance by repos)
- A welcome page when launched without argument
- No non-modal dialogs
- No menus (in menubar or in right-click context)
- No combo-box or any dropdown instance
- Same look in all desktop OSes
- Confirmation / information prompts on each important step (can be disabled)
- Use the `Mode`->`Tools`->`Workspace content`->`Context options` UI paradigm
- Nice and simplistic icons, understandable labels (instead of GIT commands verbatim)



## Repository

In repository mode, the actions and information visible are the ones that affect all the repository state.

- Open existing repos
- Create a new repos in directory (empty or not)
- Clone a remote URL
- View type : `normal` or `bare`
- Visualize size repartition
- Compute `.git` repos size
- View / edit `description`
- Add / remove / edit submodules



## Working directory

The working directory mode is the main mode used while developing. It's used to track changes, commit them or revert them, and push / pull updates.

- Change current branch
- Stash uncommited changes when needed
- Revert uncommited changes
- List files and their status (modified, added, removed etc)
- Ability to expand folders to see included files
- Folders are modified if one of their children is modified
- Button to create a new interactive commit
- Button for pulling from remote, in two-steps (fetch + checkout / merge)
- Button for pushing to remote, in two-steps (list commits + push)
- Button for reseting working directory to previous commit state
- Button for cleaning up untracked / ignored files
- Button to export working directory in archive
- Differenciate items with an icon for folder / submodule / file with mimetype
- Context options for selected file to diff / restore / remove / rename etc



## Commits

The commits mode is basically a graphical `git log` coupled with a `diff` viewer. But it also contains some commit-related operations.

- List commits with author, date and summary
- Ability to restrict to specific refspec, or hide some
- Quick scroll to refspecs (`HEAD`, tagname etc)
- Click to see details (full msg, deltas / hunks, parents etc)
- Context options for selected commit to rollback / rebase / cherrypick etc
- Filter commits by criteria (quick search)
- Reorder commits list by date asc / desc
- Nice visual graph of fork / merge



## Branches and remotes

The branches and remotes mode is a complete tool for managing local and remote branches, create new ones, affect upstream to local branch, and remove unused branches.

- List local and remote branches in two columns
- Link local branch to their remote with visual connector
- Group remote branches by remote server name
- Ability to add a new local-only branch
- Ability to create local branch from remote branch
- Ability to add a new remote or edit / remove existing ones
- Ability to push a local branch to create a remote branch
- Ability to remove or merge local branches



## Configuration

The configuration mode helps the user to configure repository options, as well as global options, for all aspects of GIT.

- Edit user name / mail for repos
- Edit some push / pull options
- Toggle filemode tracking flags
- Edit proxy settings
- Edit `SSH` keyring
