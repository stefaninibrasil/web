require_relative 'config/app'

class Teste
    include App
end

puts Teste.new.envs