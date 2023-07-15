# Contributing Guide

- Contributing to `musie_flutter` is fairly easy. This document shows you how to get started

## Submitting changes

- Fork the repo
  - <https://github.com/niteshsh4rma/musie_flutter/fork>
- Check out a new branch based and name it to what you intend to do:
  - Example:
    ````
    $ git checkout -b feat|fix|docs:BRANCH_NAME
    ````
    If you get an error, you may need to fetch fooBar first by using
    ````
    $ git remote update && git fetch
    ````
  - Use one branch per fix / feature
- Commit your changes
  - Please provide a git message that explains what you've done
  - Please make sure your commits follow the `feat|fix|docs:TITLE` convention
  - Commit to the forked repository
  - Example:
    ````
    $ git commit -am 'Add some fooBar'
    ````
- Push to the branch
  - Example:
    ````
    $ git push origin BRANCH_NAME
    ````
- Make a pull request
  - Make sure you send the PR to the <code>fooBar</code> branch
  - GitHub Actions is watching you!

If you follow these instructions, your PR will land pretty safely in the main repo!