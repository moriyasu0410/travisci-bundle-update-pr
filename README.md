# Travisci::Bundle::Update::Pr

Create GitHub PullRequest of bundle update in Travis CI.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'travisci-bundle-update-pr'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install travisci-bundle-update-pr

## Getting Started

Set your GitHub Personal access tokens to `$GITHUB_ACCESS_TOKEN`.
https://docs.travis-ci.com/user/environment-variables/#Defining-Variables-in-Repository-Settings
Remember to keep your GitHub Personal access tokens secret.

Or GitHub Personal access tokens should be encrypted.
https://docs.travis-ci.com/user/encryption-keys/

```yaml
# .travis.yml
env:
  global:
    - secure: "ZYJeLUxLbTlEtcpNF1yKCuDYisK4epfddwB+z5woE0YnJwE/iSENzrjpfbMSD3rEvim1MY0LYLXaJw9EnUirTpElFQ7lXJZ1U924fubNdMiLqpypEmZ7G5NcNcMtv1VRyim4ZiHSzKX+DgWSz3v0+a9HEF0UOXhpF+w8th+Zg3l3x+eWclT1R7JKWAUs8l/8xUPspTXk5P6NoOnLuJaelS6BtwiEt8Bwn03uru3/+l9G4Dau/VTX/WQi8NippIida5GAvHoEFvFCptg4ucICUjjQAqCK0moKn5Ltr18SHa+MtJnp4rBaPkPvTlH9iaZuw0Pm8bGJPgrSAApfZwncopvNBSUrJv1kDT11b8MPR0Jq7VRxXUAf8wMYt4c/CYRR1gNqDi9QTaD111iIliFepNEcowXhNzG4pHmG/vM7oStcFjTpdY6SMW377tsDEh/O7z+jlW7DNeCI/AFKBAfsPZDDoXM1a+iA5WEKD46195li1WM5+221nOPilIzkvxiyJM68CZF5Yv6HkZXtSyc17AvWba/8t5+TBPu0GchTNe3AQ/JRgi0bGA7EkPonNavBh199HLo1/pG/zpUmLSxDP5hV7DxMoF8V1liHNFNZn0Qr9UeKC/JCx6s27zwEqSr9nU40+siP1ea8BCQW2n++aMQ9dmXZAJOqITNfWNayaMc="
```

In such as `before_script` Lifecycle.

```yaml
# .travis.yml
before_script:
  - ./scripts/travisci-bundle-update-pr.sh
```

In the case of Cron jobs run builds.
Cron Jobs are not enabled by default.
https://docs.travis-ci.com/user/cron-jobs/

```bash
# .travisci-bundle-update-pr.sh
#!/bin/bash
set -ev

if [ "${TRAVIS_EVENT_TYPE}" = "cron" ]; then
    gem install travisci-bundle-update-pr
    travisci-bundle-update-pr TravisCI travisci@travisci-bundle-update-pr.com
fi
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mediba-moritake/travisci-bundle-update-pr. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

