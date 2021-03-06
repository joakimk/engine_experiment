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

The example app is an e-commerce application.

### Usage

Setup:

    script/bootstrap

Run specs for code that has changed:

    rake

Run all the specs:

    rake spec:ci

Run tests in an engine:

    cd engines/customers; rake spec:local

Run tests in an engine and upstream engines:

    cd engines/customers; rake

Start a web server with only the public site (and it's dependencies):

    ENGINES=public rails s

Create a new engine:

    rake create_engine[lab]

See the dependency trees:

    rake deps

When using turbux in vim you can set it to run rspec with **script/turbux_rspec** and it will run the spec within the correct engine.

### Refactoring an existing app into this pattern

I'm working on a branch in one of our apps at work where I've used this code. What I did was to copy `lib/engine_deps.rb`, `lib/engine_loader.rb`, `lib/tasks/no_rails/engine.rb`, `engines/base` and `engines/template` to the application and hook it up in `Gemfile` and `config/application.rb`.

The specs I've extracted so far actually run faster without spork in the engine than they did with spork in the main app.

I imagine a good way to go about refactoring an app into this pattern would be to take one slice at a time. Extract models into a domain engine (like Content) and controllers and views into a web engine (e.g. AdminContent or PublicContent).

### Todo

* See if it's possible to use the dummy app in development-mode too, would make changes much faster in a large app.
* See if the dummy app can boot faster. There are quite a few things that can be done to rails boot.
* Support for parallel spec runs is probably a good idea. When changing "base", it will take way too long time to run all the tests.
  - Some test pain is good though as it forces you to move things out of base.
* Don't require downstream engines to depend on all upstream ones
* How to handle gems with git refs?
* Dummy app logging is in the wrong place (spec/log)
* Figure out how versions are handled? Is it bad that an engine might use v2 of a gem in tests but v1 when used with the main app?
* Make it simpler to require common tools? rspec, capybara, etc
* Assets: check that pre-processing and pre compilation works.
* How to use spork with this? Is it even needed?
* Cleanup, simplification.
* Migrations: run migrations within each engine?
* Table prefixes?
* Authentication and shared spec helper for that.
* Cross-linking, path helpers where parts don't depend on eachother (admin -> public)
  - Possibly by having sub controller register links, dynamically generate link sections, etc.

### Other people using engines with similar goals in mind

* Almost exactly the same idea applied to a long project where they found it worked:
  - [Rocky Mountain Ruby 2013 How I architected my big Rails app for success! by Ben Smith](http://www.youtube.com/watch?v=uDaBtqEYNBo&noredirect=1)
  - Ideas
    - "git whatchanged" to figure out what tests to run
    - mapper classes somewhat like minimapper to discourage direct use of AR
    - models in their own engines as they are shared deps but controllers often are not
      - web engines at the "controller level" and domain engines at the "domain level" mirroring the layers in MVC
    - engine for admin assets
    - having a template engine and simple scripts to create new engines from it, less friction
    - avoiding circular deps by using mapper methods like project_mapper.find_all_for_user_id(5) instead of user.projects
    - namespaced tables (social_net_, content_)
    - only change one table per migration (with the idea that you could move all migrations belonging to a single table to another engine if need be).
      - seems to me that this could be accomplished by loading schema and I tend to avoid depending on old migrations working, in fact I tend to remove them after a while.

* [GoGaRuCo 2013 - SOA without the tears](http://www.youtube.com/watch?v=HV3BH2K5BQ8&noredirect=1)
  - Same idea, but loads engines after the app. Can have hidden deps.
  - They solve dependencies using injected lambdas but does not hide the fact behind nice apis for some reason.
    - Seems simpler to me to solve this by having a dependency own things like translations shared between engines.

* http://confreaks.com/videos/1263-rockymtnruby2012-wrangling-large-rails-codebases
  - Basically the same idea but depending on the host app instead of being loaded before it.
  - Cool idea with setting migration paths.

* [http://www.youtube.com/watch?v=Mfogs7jxd5Y](Nickel City Ruby 2013 Smash the Monolith: Refactoring into SOAs by Corey Ehmke)
  - More general ideas about application architecture and breaking apart monolithic applications. Also mentions engines as a way to do that.


## Credits and license

By Joakim Kolsjö under the MIT license:

>  Copyright (c) 2013 Joakim Kolsjö
>
>  Permission is hereby granted, free of charge, to any person obtaining a copy
>  of this software and associated documentation files (the "Software"), to deal
>  in the Software without restriction, including without limitation the rights
>  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
>  copies of the Software, and to permit persons to whom the Software is
>  furnished to do so, subject to the following conditions:
>
>  The above copyright notice and this permission notice shall be included in
>  all copies or substantial portions of the Software.
>
>  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
>  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
>  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
>  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
>  THE SOFTWARE.
