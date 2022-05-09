Rails.application.config.middleware.insert_before 0, Rack::Cors do
  origins = [
    "localhost:3000",
    "http://localhost:3000",
    "http://bs-local.com:3000"
  ].freeze

  allow do
    origins origins
    resource "*",
      headers: :any,
      credentials: true,
      methods: %i[get post put patch delete options head]
  end
end
