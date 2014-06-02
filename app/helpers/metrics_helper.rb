module MetricsHelper
  # Beta
  # BETA_SIGNUP = "beta_signup"

=begin
  def self.track(event, properties, user = nil)
    if user
      properties["session_user_id"] = user.id
      properties["distinct_id"] = user.id
    end

    mp = MetricsHelper::mixpanel
    mp.track(properties["distinct_id"], event, properties)

    puts "\e[33mMETRICS:\e[0m Sent #{event} with properties: #{properties}" if Rails.env.development?
  end

  def self.mixpanel
    key = Rails.env.production? ? MIXPANEL_PRODUCTION_KEY : MIXPANEL_DEVELOPMENT_KEY
    Mixpanel::Tracker.new(key)
  end

  # People Metrics Section
  def self.send_user_to_mixpanel(user)
    return if Rails.env.test?
    mp = MetricsHelper::mixpanel(user)
    mp.people.set("#{user.id}", {
      "$email"            => user.email,
      "$first_name"       => user.first_name,
      "$last_name"        => user.last_name,
      "$name"             => user.full_name,
      "$created"          => user.created_at.to_date,
      "title"             => user.title,
      "portrait_url"      => user.avatar.blank? ? user.portrait_url : user.avatar.url(:large),
      "receive_emails"    => user.receive_emails
    });
    puts "\e[33mMETRICS:\e[0m Sent user #{user.full_name} to mixpanel" if Rails.env.development?
  end
=end

end