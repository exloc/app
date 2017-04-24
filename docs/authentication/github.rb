# from a binding.pry in SessionsController#create

File.open("github-auth.json", "w") do |file|
  file.puts JSON.pretty_generate(request.env["omniauth.auth"])
end
