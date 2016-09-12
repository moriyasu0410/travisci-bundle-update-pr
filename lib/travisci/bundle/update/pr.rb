require 'travisci/bundle/update/pr/version'
require 'octokit'

module Travisci
  module Bundle
    module Update
      module Pr
        def self.start(git_username: nil, git_email: nil, git_branch: nil, path: nil)
          raise "travisci-bundle-update-pr can be executed only in Travis CI." unless ENV['TRAVIS']
          raise "$TRAVIS_REPO_SLUG undefined." unless ENV['TRAVIS_REPO_SLUG']
          raise "$GITHUB_ACCESS_TOKEN undefined." unless ENV['GITHUB_ACCESS_TOKEN']

          unless system("cd #{ENV['TRAVIS_BUILD_DIR']}/#{path} && bundle update")
            raise "Unable to execute `bundle update`"
          end
          unless `cd #{ENV['TRAVIS_BUILD_DIR']} && git status -s 2> /dev/null`.include?('Gemfile.lock')
            return
          end

          time = Time.now.strftime('%Y%m%d%H%M%S')
          branch = "bundle-update-#{time}"
          system("cd #{ENV['TRAVIS_BUILD_DIR']} && git config --global user.name #{git_username}")
          system("cd #{ENV['TRAVIS_BUILD_DIR']} && git config --global user.email #{git_email}")
          system("cd #{ENV['TRAVIS_BUILD_DIR']} && git init")
          system("cd #{ENV['TRAVIS_BUILD_DIR']} && git checkout -b #{branch}")
          system("cd #{ENV['TRAVIS_BUILD_DIR']}/#{path} && git add Gemfile.lock")
          system("cd #{ENV['TRAVIS_BUILD_DIR']} && git commit -m '$ bundle update'")
          system("cd #{ENV['TRAVIS_BUILD_DIR']} && git push --force --quiet \"https://${GITHUB_ACCESS_TOKEN}@github.com/#{ENV['TRAVIS_REPO_SLUG']}.git\" #{branch}:#{branch} > /dev/null 2>&1")

          title = "bundle update #{time}"
          body  = "This PullRequest is generated in Travis CI."

          client = Octokit::Client.new(access_token: ENV['GITHUB_ACCESS_TOKEN'])
          client.create_pull_request("#{ENV['TRAVIS_REPO_SLUG']}", git_branch, branch, title, body)
        end
      end
    end
  end
end
