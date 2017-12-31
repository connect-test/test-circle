Sidekiq.configure_server do |config|
  config.redis = { size: 5, url: ENV.fetch('sidekiq_redis_url') }
end

Sidekiq.configure_client do |config|
  config.redis = { size: 1, url: ENV.fetch('sidekiq_redis_url') }
end
