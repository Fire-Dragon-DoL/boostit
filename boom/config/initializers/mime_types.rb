# frozen_string_literal: true
# Be sure to restart your server when you modify this file.

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf
Mime::Type.unregister 'application/vnd.api+json'
Mime::Type.register 'application/vnd.api+json', :jsonapi
