# PathUtilities

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/path_utilities`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'path_utilities'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install path_utilities

## Usage

Given a model like this

```ruby
class User
  include Mongoid::Document

  field :login
  field :password
  field :name
end
```

Add a form for validating it

```ruby
class FormUser
  include PathUtilities::Form

  properties [:login, :name, :password], :user

  validates_uniqueness_of :login
  validates_presence_of :name, :password
end
```

Perform user validation

```ruby
class MyController < ApplicationController
  before_action :build, on: [:new, :create]

  def create
    if @form.validate(params[:user])
      @form.save
      redirect_to sign_in_path
    else
      render :new
    end
  end

  def build
    @form = FormUser.new(user: User.new)
  end
end
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/path_utilities/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
