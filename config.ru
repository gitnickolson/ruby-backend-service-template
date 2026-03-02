# frozen_string_literal: true

map '/' do
  run ->(_env) { [200, { 'Content-Type' => 'text/plain' }, ['Wowei']] }
end

map '/healthz' do
  run ->(_env) { [200, { 'Content-Type' => 'text/plain' }, ['OK diggi']] }
end
