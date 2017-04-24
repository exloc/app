namespace :env do
  desc "Export a new .env.example file"
  task :export do
    Keyring.export
  end
end
