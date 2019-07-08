class UserForm
  include ActiveModel::Model

  attr_accessor(
    :user,
    :user_id,
    :name,
    :email,
    :old_password,
    :password,
    :password_confirmation
  )

  validate  :check_old_password, if: :passwords_present?
  validates :password, confirmation: true, if: :passwords_present?
  validates :name,  presence: true
  validates :email, presence: true

  def initialize(attr={})
    super
    set_attribute if self.user.present?
  end

  def update
    return false if invalid?
    update_user
  end

  def self.model_name
    ActiveModel::Name.new(self, nil, 'User')
  end

  private

  def set_attribute
    @name  ||= self.user.name
    @email ||= self.user.email
  end

  def check_old_password
    if !@user.valid_password?(@old_password)
      errors.add(:old_password, 'is incorrect')
    end
  end

  def passwords_present?
    @old_password.present? || @password.present?
  end

  def update_user
    @user.update(user_params)
  end

  def user_params
    params = {
      name: @name,
      email: @email
    }

    if passwords_present?
      params.merge!(
        password: @password,
        password_confirmation: @password_confirmation
      )
    end

    params
  end
end
