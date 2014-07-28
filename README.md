# Mina Clockwork

Clockwork deployment scenario for mina. It uses `clockworkd` to start clockwork daemon.

## Installation

Via Bundler:

```ruby
# Gemfile
gem 'mina-clockwork', require: false
```

## Usage example

```ruby
# config/deploy.rb

require 'mina/clockwork'

set :clockwork_file, -> { "#{deploy_to}/#{current_path}/app/clockwork.rb" }
set :clockwork_identifier, -> { rails_env }
... other options

task deploy: :environment do
  deploy do
    invoke 'clockwork:stop'
    invoke 'git:clone'
    ...

    to :launch do
      ...
      invoke 'clockwork:start'
    end
  end
end
```

## Tasks

```
mina clockwork:restart  # Restart clockworkd
mina clockwork:start    # Start clockworkd
mina clockwork:stop     # Stop clockworkd
```

## Configuration

* `clockwork_dir` - Working dir (Default: current deployment path)
* `clockwork_file` - Clock file (Default: [current deployment path]/clock.rb)
* `clockwork_identifier` - Identifier for clockworkd process (Default: name of clock file)
* `clockwork_pid_dir` - Dir for pid file (Default: [shared path]/tmp/pids)
* `clockwork_log_dir` - Dir for log files (Default: [shared path]/log)

## Contributing

Feel free to contribute!
