# Mina + Clockwork

Clockwork deployment scenario for mina. It uses `clockworkd` executable to start
clockwork daemon on the server. `clockworkd` is the part of the [`clockwork`](https://github.com/Rykian/clockwork).

*Important!* You will need both `clockwork` and `daemons` gems available on the server!

## Installation

```ruby
# Gemfile

gem "mina-clockwork"

group :production do
  gem "daemons"  # for `clockworkd`
end
```

## Configuration

```ruby
# config/deploy.rb

require "mina/clockwork"

... set configuration options here if you need ...

task deploy: :environment do
  deploy do
    invoke :"clockwork:stop"
    ...

    to :launch do
      ...
      invoke :"clockwork:start"
    end
  end
end
```

Use these options to configure the plugin:

* `clockwork_dir` - Daemon working dir (Default: current deployment path)
* `clockwork_file` - Clock file (Default: [current deployment path]/clock.rb)
* `clockwork_identifier` - Identifier of the `clockworkd` process (Default: name of the clock file)
* `clockwork_pid_dir` - Dir for `*.pid` file (Default: [shared path]/tmp/pids)
* `clockwork_log_dir` - Dir for `*.log` files (Default: [shared path]/log)

Example:

```ruby
set :clockwork_file, -> { "#{fetch(:current_path)}/my_clock_file.rb"  }
```

## Tasks

```
mina clockwork:restart  # Restart clockwork daemon
mina clockwork:start    # Start clockwork daemon
mina clockwork:stop     # Stop clockwork daemon
```


## Contributing

Feel free to contribute!
