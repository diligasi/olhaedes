Faker::Config.locale = :'pt-BR'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
