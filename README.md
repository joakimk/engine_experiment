**Work in progress** | **Lab project**

## Engine experiment

I want to see if it's practial to build a large rails app composed of multiple engines.

I'm looking to build a dependency graph within the application so that you only load the engines you need. A worker process should not load an admin interface, a test of the cms should not load background workers.

The main goals are:
* Faster turnaround time for new features. It should be like you're working on smaller rails apps... because, well, you do.
* Less memory usage in production. Only load the parts you need.

Future benefits:
* Be able to split an application into many small ones.

## Example app

The example app is an e-commerce application (I've actually never built one, but it's a common enough domain I think).

Possible dependency tree:

    base -> admin                      -> cms
    base -> products, admin            -> inventory
    base -> customers, admin           -> crm
    base -> customers, products, admin -> statistics
    base -> customers, products        -> public

    admin: admin views, etc.
    public: public site.

## Usage

Run the host app:

    rake

Run tests in an engine:

    cd engines/customers; rake

Run tests in downstream engines (all engines depend on base, so all tests will be run):

    cd engines/base; rake spec:downstream

## Thoughts on refactoring an app into this pattern

* Introduce a base engine, make it load before the app and extract the most common code.
  - I think it's important to keep this engine very slim (to load fast) and limit it to code that very rarely changes (when it changes you'll have to re-run all downstream tests).
* Introduce more specific engines.
  - Try to put slow-loading or slow-to-test code as far down into the dependency tree as possible.

## Todo

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
