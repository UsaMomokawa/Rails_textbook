# turn on testmode for Omniauth
OmniAuth.config.test_mode = true

# set env
Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook]

# set default authentication hashes
def set_omniauth
  OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
    :provider => 'facebook',
    :uid => 'mock_uid_12345',
    :info => {
      :email => 'mock_mail@example.com',
      :name => 'Mock User'
    },
  })
end

def set_invalid_omniauth
  OmniAuth.config.mock_auth[:facebook] = :invalid_credentials_message
end
