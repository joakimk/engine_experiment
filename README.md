**Work in progress** | **Lab project**

## Engine experiment

I want to see if it's practial to build a large rails app composed of multiple engines.

I'm looking to build a dependency graph within the application so that you only load the engines you need. A worker process should not load an admin interface, a test of the cms should not load background workers.

The main goals are:
* Faster turnaround time for new features. It should be like you're working on smaller rails apps... because, we'll, you do.
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

## Todo

* More sub-engines, one for each part of the dependency tree.
* Assets.
* Locales.
* Routes / Controllers / Views / Layouts.
* no-rails tests.
* Simple test setup while using guard and spork.
* CI setup, only run the tests that are needed. Parallel tests, etc.
* Cleanup, simplification.
* Evaluate if the overhead is too much.
* Anything I haven't thought of yet :)
