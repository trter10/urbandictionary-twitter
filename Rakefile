task :default do
  sh "rspec *_spec.rb"
end

task :start do
  sh "heroku config:set UPDATE_TWITTER=true"
end

task :stop do
  sh "heroku config:unset UPDATE_TWITTER"
end