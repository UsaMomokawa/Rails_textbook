class ApplicationController < ActionController::Base

  before_action :set_locale

  # palamsでlocale情報を取得する
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  # default_url_optionsをオーバーライドし、全リンクにlocale情報をセット
  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end
end
