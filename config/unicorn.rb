worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3) # 子プロセスいくつ立ち上げるか
timeout 15 #15秒Railsが反応しなければWorkerをkillしてタイムアウト
preload_app true #後述

# 同一マシンでNginxとプロキシ組むならsocketのが高速ぽい(後述ベンチ)
# # listen /path/to/rails/tmp/unicorn.sock
listen 3000

before_fork do |server, worker|
  old_pid = "#{ server.config[:pid] }.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end#

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end

def rails_root
  require 'pathname'
  Pathname.new(__FILE__) + "../../"
end

