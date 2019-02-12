set :clockwork_dir,        -> { "#{fetch(:current_path)}" }
set :clockwork_file,       -> { "#{fetch(:current_path)}/clock.rb"  }
set :clockwork_identifier, -> { File.basename(fetch(:clockwork_file), ".rb") }
set :clockwork_pid_dir,    -> { "#{fetch(:shared_path)}/tmp/pids" }
set :clockwork_log_dir,    -> { "#{fetch(:shared_path)}/log" }

set :clockworkd_cmd,       -> {
  if set?(:bundle_prefix)
    "#{fetch(:bundle_prefix)} clockworkd"
  elsif set?(:bundle_bin)
    "#{fetch(:bundle_bin)} exec clockworkd"
  else
    "clockworkd"
  end
}

set :clockworkd_full_cmd,  -> {
%[cd #{fetch(:current_path)} && #{fetch(:clockworkd_cmd)} \\
-c '#{fetch(:clockwork_file)}' \\
-i '#{fetch(:clockwork_identifier)}' \\
-d '#{fetch(:clockwork_dir)}' \\
--pid-dir '#{fetch(:clockwork_pid_dir)}' \\
--log --log-dir '#{fetch(:clockwork_log_dir)}']
}

namespace :clockwork do
  # mina clockwork:start
  desc "Start clockwork daemon"
  task start: :remote_environment do
    comment "Starting clockwork daemon"
    command "#{fetch(:clockworkd_full_cmd)} start"
  end

  # mina clockwork:stop
  desc "Stop clockwork daemon"
  task stop: :remote_environment do
    comment "Stopping clockwork daemon"
    command "#{fetch(:clockworkd_full_cmd)} stop"
  end

  # mina clockwork:restart
  desc "Restart clockwork daemon"
  task restart: :remote_environment do
    comment "Restarting clockwork daemon"
    command "#{fetch(:clockworkd_full_cmd)} restart"
  end
end
