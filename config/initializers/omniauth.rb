#require 'omniauth-deezer'
#require 'omniauth'
Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :twitter, 'CONSUMER_KEY', 'CONSUMER_SECRET'
  if Rails.env == "development" #Adriano's accounts on localhost:3000
    provider :twitter, '31W0dLZzOL64OlSkSIAVA', 'VA57S7fwuZAOfPT5Ilr1nm2qC0QLFI3Y8t6EF9luk'
    provider :google_oauth2, '276672130584.apps.googleusercontent.com', '2XlQhOq6Vo8nTDedQUADiTKA'
  elsif Rails.env == "production" #Felipe's accounts on queroumprofessor.com.br
    provider :twitter, 'hxPAUXG0wfLTInnOp3PmtA', '38DqvWwJduVwSY2KYAaoBHrdvlC712mnJXTVAFNj6Y'
    provider :google_oauth2, '717960285215.apps.googleusercontent.com', 'N6aFFL6LL-h43zTFj3_O9GiB'
    proviver :facebook, '433960636667257', 'a32ce6494961c9d25478455a59d5e8ce'
  end
  #provider :facebook, 'APP_ID', 'APP_SECRET'
  #provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'
end
