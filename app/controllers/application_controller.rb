class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :authenticate_user! # Garante que o usuário esteja logado

  def after_sign_in_path_for(resource)
    root_path # Ou qualquer outra página que você queira redirecionar após o login
  end
end
