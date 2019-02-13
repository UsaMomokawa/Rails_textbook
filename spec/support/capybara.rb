# どのドライバーを使うかを設定
Capybara.configure do |capybara_config|
  capybara_config.default_driver = :selenium_chrome
end
# Capybaraに設定したドライバーの設定
Capybara.register_driver :selenium_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('headless') # ヘッドレスモードをonにするオプション
  options.add_argument('--disable-gpu') # 暫定的に必要
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

# JavaScriptを扱えるようにする
Capybara.javascript_driver = :selenium_chrome_headless

# 任意の場所でスクショを取る
def take_screenshot
  page.save_screenshot "#{Rails.root}/tmp/capybara/screenshot-#{DateTime.now}.png"
end

# login_asメソッドを使えるようにする
include Warden::Test::Helpers
