if Rails.env.production? || Rails.env.staging?
  ActionMailer::Base.add_delivery_method :cloudmailin, Mail::SMTP,
                                         address: ENV['CLOUDMAILIN_HOST'],
                                         port: 587,
                                         domain: ActionMailer::Base.default_url_options[:host],
                                         user_name: ENV['CLOUDMAILIN_USERNAME'],
                                         password: ENV['CLOUDMAILIN_PASSWORD'],
                                         authentication: 'plain',
                                         enable_starttls_auto: true
end