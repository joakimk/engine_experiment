**Work in progress** | **Lab project**

Engine experiment

I want to see if it's practial to build a large rails app composed of multiple engines.

I'm looking to build a dependency graph within the application so that you only load the engines you need. A worker process should not load an admin interface, a test of the cms should not load the background workers.

The main goals are:
* Faster turnaround time for new features. It should be like you're working on smaller rails apps... because, we'll, you do.
* Less memory usage in production. Only load the parts you need.

Future benefits:
* Because it's are clear how the dependencies go, you can split the application into many applications. Say applications for CMS, CRM, Statistics, ...

The lab app is a e-commerce application (I've actually never built one, but it's a common enough domain I think).

Possible dependency tree:

    base -> products, admin            -> cms
    base -> customers, admin           -> crm
    base -> customers, products, admin -> statistics
    base -> customers, products        -> public

    admin: admin views, etc.
    public: public site.

Usage:

Run the host app:

    rake

Run tests in an engine:

    cd engines/customers; rake

Run tests in downstream engines:

    cd engines/base; rake
