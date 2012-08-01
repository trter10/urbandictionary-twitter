task :default do
  sh "bundle exec rspec -rspec_helper"
end

task :start do
  sh "heroku config:set UPDATE_TWITTER=true"
end

task :stop do
  sh "heroku config:unset UPDATE_TWITTER"
end

task :diff do
  sh "git diff heroku/master..head"
end
