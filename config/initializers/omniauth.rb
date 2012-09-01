#require 'omniauth'
Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :twitter, 'CONSUMER_KEY', 'CONSUMER_SECRET'
  provider :twitter, '330532583-d84dvTsLMEUvlpnd6dsY28ReCMKXWF9PJqBSxh68', '4HZu5xEJnMyGxudCy84XI0PO6ZY2WZXzkvQmS68dzLM'
  #provider :facebook, 'APP_ID', 'APP_SECRET'
  #provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'
end
