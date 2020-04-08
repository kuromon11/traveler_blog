# Gemfile.lockを見てcapistranoのバージョンを入れる
lock "~> 3.12.1"

# 自身のアプリ名を記述
set :application, 'traveler_blog'
# どのリポジトリからアプリをpullするかを指定する
set :repo_url,  'git@github.com:kuromon11/traveler_blog.git'
# バージョンが変わっても共通で参照するディレクトリを指定
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

set :rbenv_type, :user
set :rbenv_ruby, '2.5.1'

# どの公開鍵を利用してデプロイするか
set :ssh_options, auth_methods: ['publickey'],
                  keys: ['~/.ssh/TravelerBlog.pem']
# プロセス番号を記載したファイルの場所
set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }
# Unicornの設定ファイルの場所
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
set :keep_releases, 5
# master.key用のシンボリックリンクを追加
set :linked_files, %w{ config/master.key }
# 元々記述されていた after 「'deploy:publishing', 'deploy:restart'」以下を削除して、次のように書き換え
after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    # unicornを完全に停止する
    invoke 'unicorn:stop'
    invoke 'unicorn:start'
  end

  desc 'upload master.key'
  task :upload do
    on roles(:app) do |host|
      if test "[ ! -d #{shared_path}/config ]"
        execute "mkdir -p #{shared_path}/config"
      end
      upload!('config/master.key', "#{shared_path}/config/master.key")
    end
  end
  before :starting, 'deploy:upload'
  after :finishing, 'deploy:cleanup'
end