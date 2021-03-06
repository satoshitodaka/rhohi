class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :require_no_authentication, only: [:cancel]
  prepend_before_action :authenticate_scope!, only: [:update, :destroy]
  prepend_before_action :set_minimum_password_length, only: [:new, :edit]
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  before_action :creatable?, only: [:new, :create]
  before_action :editable?, only: [:edit, :update]

  def edit
    if by_admin_user?(params)
      self.resource = resource_class.to_adapter.get!(params[:id])
    else
      authenticate_scope!
      super
    end
  end

  # PUT /resource
  def update
    self.resource = if by_admin_user?(params)
                      resource_class.to_adapter.get!(params[:id])
                    else
                      resource_class.to_adapter.get!(send(:'current_#{resource_name}').to_key)
                    end

    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
    resource_updated = if by_admin_user?(params)
                         update_resource_without_password(resource, account_update_params)
                       else
                         update_resource(resource, account_update_params)
                       end

    yield resource if block_given?

    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
        :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      bypass_sign_in resource, scope: resource_name	unless by_admin_user?(params)
      respond_with resource, location: after_update_path_for(resource)
    else	
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :company_id, :birthday, :admin])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :company_id, :birthday, :admin])
  end

  def by_admin_user?(params)
    params[:id].present? && current_user_is_admin?
  end

  def current_user_is_admin?
    user_signed_in? && current_user.has_role?(:admin)
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    if current_user_is_admin?
      new_user = User.last
      user_path(new_user)
    else
      super(resource)
    end
  end

  # The path used after update.
  def after_update_path_for(resource)
    if current_user_is_admin?
      users_path
    else
      super(resource)
    end
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  def sign_up(resource_name, resource)
    sign_in(resource_name, resource) unless current_user_is_admin?
  end

  def update_resource_without_password(resource, params)
    resource.update_without_password(params)
  end

  def creatable?
    if !user_signed_in?
      redirect_to root_url
      flash[:danger] = '???????????????????????????????????????????????????????????????????????????????????????'
    elsif !current_user_is_admin?
      redirect_to root_url
      flash[:danger] = '?????????????????????????????????????????????'
    end
  end

  def editable?
    raise CanCan::AccessDenied unless user_signed_in?
    return unless params[:id].present? && !current_user_is_admin?

    redirect_to root_url
    flash[:danger] = '?????????????????????????????????????????????'
  end
end