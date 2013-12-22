**Work in progress** | **Lab project**

## Engine experiment

I want to see if it's practical to build a large rails app composed of multiple engines.

I'm building a dependency graph within the application to be able to only load the required engines. A worker process should not load an admin interface, a test of the cms should not load background workers.

The main goals are:
* Faster turnaround time for new features. It should be like you're working on smaller rails apps... because, well, you do.
* Less memory usage in production. Only load the parts you need.

Future benefits:
* Be able to split an application into many small ones.

### Example app

The example app is an e-commerce application (I've actually never built one, but it's a common enough domain I think).

### Usage

Setup:

    script/bootstrap

See the dependency trees:

    rake deps

Run the host app and all the specs:

    rake

Run tests in an engine:

    cd engines/customers; rake

Run tests in upstream engines:

    cd engines/customers; rake spec:upstream

Run tests from the root of the app:

    rake spec:content

Start a web server with only the public site (and it's dependencies):

    ENGINES=public rails s

When using turbux in vim you can set it to run rspec with **script/turbux_rspec** and it will run the spec within the correct engine.

### Thoughts on refactoring an app into this pattern

* Introduce a base engine, make it load before the app and extract the most common code.
  - I think it's important to keep this engine very slim (to load fast) and limit it to code that very rarely changes (when it changes you'll have to re-run all upstream tests).
* Introduce more specific engines.
  - Try to put slow-loading or slow-to-test code as far down into the dependency tree as possible.


### Why not extract into gems or separate apps right away?

Before you can make a separate thing it needs to be an isolated bit of functionality. Using engines you can start to isolate parts of an app. When a part of an app is isolated you can make it into a gem or a separate app, but you don't need to. There are several advantages to having the engines within the same repository. This includes having only one thing to deploy, no versioning, CI can run faster by only running the tests that apply to a given change, etc.

### Todo

* Assets: check that pre-processing and pre compilation works.
* Migrations: run migrations within each engine?
* Authentication and shared spec helper for that.
* Cross-linking, path helpers where parts don't depend on eachother (admin -> public)
  - Possibly by having sub controller register links, dynamically generate link sections, etc.
* Simple test setup while using guard and spork.
* Cleanup, simplification.
* Evaluate if the overhead is too much.
* Anything I haven't thought of yet :)

### Related

* http://confreaks.com/videos/1263-rockymtnruby2012-wrangling-large-rails-codebases
  - Basically the same idea but depending on the host app instead of being loaded before it.
  - Cool idea with setting migration paths.

* Almost exactly the same idea applied to a long project where they found it worked:
  - [Rocky Mountain Ruby 2013 How I architected my big Rails app for success! by Ben Smith](http://www.youtube.com/watch?v=uDaBtqEYNBo&noredirect=1)
  - Ideas
    - "git whatchanged" to figure out what tests to run
    - mapper classes somewhat like minimapper to discourage direct use of AR
    - models in their own engines as they are shared deps but controllers often are not
    - engine for admin assets
    - having a template engine and simple scripts to create new engines from it, less friction
    - avoiding circular deps by using mapper methods like project_mapper.find_all_for_user_id(5) instead of user.projects
    - namespaced tables (social_net_, content_)
    - only change one table per migration (with the idea that you could move all migrations belonging to a single table to another engine if need be).
      - seems to me that this could be accomplished by loading schema and I tend to avoid depending on old migrations working, in fact I tend to remove them after a while.
