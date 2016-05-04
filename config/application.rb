require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module Blog
  class Application < Rails::Application
    config.generators do |g|
      g.test_framework :rspec
    end

    config.autoload_paths << Rails.root.join('lib')

    config.i18n.load_path += Dir[Rails.root.join('config', 'locales',
                                                 '**', '*.{rb,yml}')]

    config.filter_parameters += [:password]

    config.action_mailer.default_url_options = { host: Settings.host }

    config.time_zone = 'Europe/Moscow'
    config.i18n.default_locale = :ru
    config.active_record.raise_in_transactional_callbacks = true

    config.to_prepare do
      ActsAsTaggableOn::Tag.class_eval do
        has_many :posts, through: :taggings, source: :taggable,
                         source_type: 'Post'
        update_index 'posts#post', :posts
      end

      ActsAsTaggableOn::Tagging.class_eval do
        update_index('posts#post') { taggable if taggable_type == 'Post' }
      end
    end
  end
end
