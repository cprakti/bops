# Upgrades

The following are ideas on how to improve the repo.

## App/UI/UX

- Add a loading indicator for initial load
- Add a loading indicator for searching, such as the magnifying glass turning into the loading spinner
- Use `sessionStorage` for storing the query
- Add "X" to clear query
- Add virtualization for smoother scrolling experience
- Modify the table so on mobile the "Release Year" and "Condition" columns are much smaller

## Setup Instructions / Dev Onboarding

- Add Ruby install instructions
- Add volta setup instructions
- Add Postgres setup instructions
- Change `README.md` to use `bundle exec`
- Add more scripts to `package.json`
- Add more info on vite in `README.md`, such as ignoring `vite v2.9.8 dev server running at:` and using `localhost:3000`
- Add another sanity-check for vite (such as telling them to change some text, save, and `localhost:3000` should reflect changes)
- Add missing Postman info to `README.md`, such as setting `host` env var

## Specs/Tests

- Avoid using `before` and `let` in specs and have each spec encapsulate what it needs
- Use `described_class` in specs
- Remove `test/`
- Add `routes_spec.rb`
- Controller specs
- Add user interaction tests
- Add Cypress

## Code Quality/Unification

- Add prettier for Ruby and run on all files
- Add [swagger-blocks](https://github.com/fotinakis/swagger-blocks) and remove Postman references
- Create `sdk/` and align Swagger definitions with TypeScript `interfaces`
- Apply TypeScript
- Alphabetize method calls
- Add rubocop
- Add [lint-staged](https://www.npmjs.com/package/lint-staged)
- Add [husky](https://www.npmjs.com/package/husky)
- Set up React components to not need `import React from "react";`
- Add suggested VS Code extensions
- Use SWR or React Query instead of axios
- Add Redux and state management tests
- Add aliases, so you can do `~/lib/useDebounce`
- Add `doctoc` for better `*.md` file navigation

## Process

- Add GitHub Actions
- Add PR template
- Add suggestion to do Squash & Merge on PRs
- Add `guard` for faster spec feedback
- Add `bullet` to notify of N+1 risks
- Add LaunchDarkly for feature flags and/or canary releases

## Misc

- Add to `.gitignore` -- `*.log`, `node_modules`, `.DS_Store`, `tmp`
- Add shared snippets, such as `fc` to build a function component
- Add a proper fuzzy search using trigram or a 3rd party service
