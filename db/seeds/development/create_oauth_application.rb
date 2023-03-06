if Doorkeeper::Application.count.zero?
  app = Doorkeeper::Application.create(
    name: 'Authentication',
    redirect_uri: 'urn:ietf:wg:oauth:2.0:oob',
    scopes: %w[read write],
    uid: ENV.fetch("CLIENT_ID", ''),
    secret: ENV.fetch("CLIENT_SECRET", '')
  )
  puts "Client id: #{app.uid}"
  puts "Client secret: #{app.secret}"
end
