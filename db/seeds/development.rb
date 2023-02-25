files = %w[
  create_oauth_application
  create_users
]

p '----------------- Start -----------------'
files.each do |filename|
  puts
  p "***************** #{filename.humanize} *****************"
  require Rails.root.join('db', 'seeds', "#{Rails.env}/#{filename}.rb")
end
p '----------------- Finish -----------------'
