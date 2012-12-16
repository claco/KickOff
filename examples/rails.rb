requires 'rails'

name = options[:name]

rails name do
  generate :model, 'name:string', '--rspec'
end

files '**/*.rb' do
  prepend '# -*- encoding: utf-8 -*-'
end
