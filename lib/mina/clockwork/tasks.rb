require 'mina/bundler'

namespace :clockwork do
  set_default :clockwork_dir, -> { "#{deploy_to}/#{current_path}" }
  set_default :clockwork_file, -> { "#{deploy_to}/#{current_path}/clock.rb"  }
  set_default :clockwork_identifier, -> { File.basename(clockwork_file, '.rb') }
  set_default :clockwork_pid_dir, -> { "#{deploy_to}/#{shared_path}/tmp/pids" }
  set_default :clockwork_log_dir, -> { "#{deploy_to}/#{shared_path}/log"  }
  set_default :clockworkd_cmd, -> { "#{bundle_prefix} clockworkd" }
  set_default :clockworkd_full_cmd, -> { %[cd #{deploy_to}/#{current_path} && #{clockworkd_cmd} \\
-c '#{clockwork_file}' \\
-i '#{clockwork_identifier}' \\
-d '#{clockwork_dir}' \\
--pid-dir '#{clockwork_pid_dir}' \\
--log --log-dir '#{clockwork_log_dir}'] }

  desc 'Start clockworkd'
  task start: :environment do
    queue %[echo '-----> Start clockwork']
    queue! "#{clockworkd_full_cmd} start"
  end

  desc 'Stop clockworkd'
  task stop: :environment do
    queue %[echo '-----> Stop clockwork']
    queue! "#{clockworkd_full_cmd} stop"
  end

  desc 'Restart clockworkd'
  task restart: :environment do
    queue %[echo '-----> Restart clockwork']
    queue! "#{clockworkd_full_cmd} restart"
  end
end
