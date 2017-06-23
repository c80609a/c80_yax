# C80Yax

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/c80_yax`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's `Gemfile`:

```ruby
gem 'c80_yax'
```

Add dependencies to app's `Gemfile`:

```ruby
gem 'rails', '4.2.0'
gem 'mysql2', '~> 0.3.18'

gem 'execjs'
gem 'therubyracer'

gem 'activeadmin'
gem 'devise'
gem 'cancan' # or cancancan
gem 'draper'
gem 'pundit'

gem 'font-awesome-rails'
gem 'friendly_id'
gem 'babosa'

gem 'bootstrap-select-rails'
gem 'c80_md'
gem 'c80_yax'

```

And then execute:

    $ bundle

Add to app's `active_admin.js.coffee`:

```coffee
#= require bootstrap
#= require bootstrap-select
#= require c80_yax
```

Add to app's `active_admin.scss`:

```scss
@import "font-awesome";
@import "bootstrap-sprockets";
@import "bootstrap";
@import "bootstrap-select";
@import "mat_design";
@import "c80_yax_backend";
```

Add to app's `application_controller.rb`:

```ruby
helper C80Yax::Engine.helpers
```

Add to app's `routes.rb`:

```ruby
    mount C80Yax::Engine => '/'
```

## Usage



