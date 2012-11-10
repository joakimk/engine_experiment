**Work in progress** | **Lab project**

## Engine experiment

I want to see if it's practical to build a large rails app composed of multiple engines.

I'm building a dependency graph within the application to be able to only load the required engines. A worker process should not load an admin interface, a test of the cms should not load background workers.

The main goals are:
* Faster turnaround time for new features. It should be like you're working on smaller rails apps... because, well, you do.
* Less memory usage in production. Only load the parts you need.

Future benefits:
* Be able to split an application into many small ones.

## Example app

The example app is an e-commerce application (I've actually never built one, but it's a common enough domain I think).

## Usage

Setup:

    script/bootstrap

See the dependency trees:

    rake deps

Run the host app and all the specs:

    rake

Run tests in an engine:

    cd engines/customers; rake

Run tests in downstream engines:

    cd engines/customers; rake spec:downstream

Start a web server with only the public site (and it's dependencies):

    ENGINES=public rails s

When using turbux in vim you can set it to run rspec with **script/turbux_rspec** and it will run the spec within the correct engine.

## Thoughts on refactoring an app into this pattern

* Introduce a base engine, make it load before the app and extract the most common code.
  - I think it's important to keep this engine very slim (to load fast) and limit it to code that very rarely changes (when it changes you'll have to re-run all downstream tests).
* Introduce more specific engines.
  - Try to put slow-loading or slow-to-test code as far down into the dependency tree as possible.

## Todo

* Ensure code reloading works in dev.
* Write a bit about "why don't you just make gems for all of it right away" (why that's not practical and how this enables you to do that in the future).
* DRY gemspecs
* Assets.
* Locales.
* Authentication and shared spec helper for that.
* Cross-linking, path helpers where parts don't depend on eachother (admin -> public)
  - Possibly by having sub controller register links, dynamically generate link sections, etc.
* Simple test setup while using guard and spork.
* Be able to work in development mode in the browser for a specific engine? (still slow to load all of them in a large app)
* CI setup, only run the tests that are needed. Parallel tests, etc.
* no-rails tests.
* Cleanup, simplification.
* Evaluate if the overhead is too much.
* Anything I haven't thought of yet :)

## Related

* http://confreaks.com/videos/1263-rockymtnruby2012-wrangling-large-rails-codebases
  - Basically the same idea but depending on the host app instead of being loaded before it.
  - Cool idea with setting migration paths.
