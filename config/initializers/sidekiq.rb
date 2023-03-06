redis_config = { url: ENV.fetch("SIDEKIQ_REDIS_URL", '') }

Sidekiq.configure_server do |config|
  config.redis = redis_config
end

Sidekiq.configure_client do |config|
  config.redis = redis_config
end
