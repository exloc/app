# http://weblog.rubyonrails.org/2006/12/19/using-custom-mime-types/
# Be sure to restart your server when you modify this file.

# ~/.gem/ruby/2.4.1/gems/rack-2.0.1/lib/rack/mime.rb
#
# MIME_TYPES = {
#   # ...
#   ".gz"        => "application/x-gzip",
#   ".tar"       => "application/x-tar",
#   ".tbz"       => "application/x-bzip-compressed-tar",
#   ".zip"       => "application/zip",
#   # ...
# }

# Add new mime types for use in **respond_to** blocks:
# Mime::Type.register "text/richtext", :rtf
# Mime::Type.register "text/markdown", :markdown
# Mime::Type.register "application/pdf", :pdf
# Mime::Type.register "application/pdf", :gz
# Mime::Type.register "application/xml", :plist_xml, [], ["xml.plist"]
# Mime::Type.register "application/tar+gzip", :targz, [], ["tar.gz"]

Mime::Type.register "application/octet-stream", :tarball  # http://stackoverflow.com/a/6783972/2675670
Mime::Type.register "application/zip", :zip
