class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:nickname, :name_last_kanji, :name_first_kanji, :name_last_kana, :name_first_kana,
                                             :birth_date])
  end
end
