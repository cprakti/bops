# Upgrades

The following are ideas on how to improve the repo. They are not prioritized.

- Add Ruby install instructions
- Add volta setup instructions
- Add Postgres setup instructions
- Add prettier for Ruby and run on all files
- Avoid using `before` and `let` in specs and have each spec encapsulate what it needs
- Use `described_class` in specs
- Remove `test/`
- Apply TypeScript
- Alphabetize method calls
- Add [swagger-blocks](https://github.com/fotinakis/swagger-blocks) and remove Postman references
- Create `sdk/` and align Swagger definitions with TypeScript `interfaces`
- Add to `.gitignore` -- `*.log`, `node_modules`, `.DS_Store`, `tmp`
- Change `README.md` to use `bundle exec`
- Add more scripts to `package.json`
- Add rubocop
- Add `routes_spec.rb`
- Add [lint-staged](https://www.npmjs.com/package/lint-staged)
- Add [husky](https://www.npmjs.com/package/husky)
- Add more info on vite in `README.md`, such as ignoring `vite v2.9.8 dev server running at:` and using `localhost:3000`
- Add another sanity-check for vite (such as telling them to change some text, save, and `localhost:3000` should reflect changes)
- Add GitHub Actions
- Add PR template
