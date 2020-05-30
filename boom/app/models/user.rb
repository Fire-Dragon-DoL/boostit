require 'securerandom'

class User < ApplicationRecord
  devise :database_authenticatable, :registerable

  validates_format_of :email, with: Devise.email_regexp, allow_blank: true, if: :email_changed?
  validates_presence_of :password, if: :password_required?
  validates_confirmation_of :password, if: :password_required?
  validates_length_of :password, within: Devise.password_length, allow_blank: true

  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end

  def email_required?
    true
  end

  module Sample
    def self.email
      id = SecureRandom.uuid

      "#{id}@domain.com"
    end

    def self.password
      SecureRandom.urlsafe_base64(16)
    end

    def self.invalid_email
      'a'
    end

    def self.too_short_password
      'a'
    end
  end
end
