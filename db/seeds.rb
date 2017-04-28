# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin_attributes = {
  provider: "github",
  uid: "1299034"
}

admin = User.find_or_initialize_by(admin_attributes)
admin.role = "admin"
admin.save!


exlocs = %w(
  https://github.com/exloc/example
  https://github.com/exloc/parse-mailto-with-regex
  https://github.com/radavis/local-events
  https://github.com/radavis/hosts
  https://github.com/radavis/github-card
  https://github.com/radavis/foundation-cdn-boilerplate
)

exlocs.each do |exloc|
  ex = CodeExample.find_or_create_by(git: exloc)
  ex.user = admin
  ex.save!
  CodeExampleImportJob.perform_now(ex.slug)
end
