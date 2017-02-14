set :clockwork_dir,        -> { "#{fetch(:current_path)}" }
set :clockwork_file,       -> { "#{fetch(:current_path)}/clock.rb"  }
set :clockwork_identifier, -> { File.basename(clockwork_file, '.rb') }
set :clockwork_pid_dir,    -> { "#{fetch(:shared_path)}/tmp/pids" }
set :clockwork_log_dir,    -> { "#{fetch(:shared_path)}/log" }
set :clockworkd_cmd,       -> { "#{fetch(:bundle_prefix)} clockworkd" }
set :clockworkd_full_cmd,  -> { %[cd #{fetch(:current_path)} && #{fetch(:clockworkd_cmd)} \\
-c '#{fetch(:clockwork_file)}' \\
-i '#{fetch(:clockwork_identifier)}' \\
-d '#{fetch(:clockwork_dir)}' \\
--pid-dir '#{fetch(:clockwork_pid_dir)}' \\
--log --log-dir '#{fetch(:clockwork_log_dir)}'] }

namespace :clockwork do
  # mina clockwork:start
  desc 'Start clockworkd'
  task start: :environment do
    comment 'Start clockwork'
    command "#{fetch(:clockworkd_full_cmd)} start"
  end

  # mina clockwork:stop
  desc 'Stop clockworkd'
  task stop: :environment do
    comment 'Stop clockwork'
    command "#{fetch(:clockworkd_full_cmd)} stop"
  end

  # mina clockwork:restart
  desc 'Restart clockworkd'
  task restart: :environment do
    comment 'Restart clockwork'
    command "#{fetch(:clockworkd_full_cmd)} restart"
  end
end
