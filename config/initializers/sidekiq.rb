class Sidekiq::Extensions::DelayedMailer
  sidekiq_options queue: 'mail'
end