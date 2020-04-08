require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TravelerBlog
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.time_zone = 'Tokyo'
    # config.active_record.default_timezone = :local
    # デフォルトのlocaleを日本語(:ja)にする
    config.i18n.default_locale = :ja
    # 複数のローケルファイルが読み込まれる
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    
    #field_with_errorを自動挿入しない
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| html_tag }
  end
end
