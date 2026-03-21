# frozen_string_literal: true

require './lib/config/initialize'
require './lib/web/router'

map '/healthz' do
  run ->(_env) { [200, { 'Content-Type' => 'text/plain' }, ['OK']] }
end

run Web::Router.new
