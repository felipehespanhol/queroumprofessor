#require 'omniauth'
Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :twitter, 'CONSUMER_KEY', 'CONSUMER_SECRET'
  provider :twitter, '31W0dLZzOL64OlSkSIAVA', 'VA57S7fwuZAOfPT5Ilr1nm2qC0QLFI3Y8t6EF9luk'
  #provider :facebook, 'APP_ID', 'APP_SECRET'
  #provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'
end
