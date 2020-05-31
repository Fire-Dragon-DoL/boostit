# frozen_string_literal: true

require 'securerandom'

class User < ApplicationRecord
  devise :database_authenticatable, :registerable

  validates :email, format: { with: Devise.email_regexp, allow_blank: true, if: :email_changed? }
  validates :password, presence: { if: :password_required? }
  validates :password, confirmation: { if: :password_required? }
  validates :password, length: { within: Devise.password_length, allow_blank: true }

  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end

  def email_required?
    true
  end

  module Sample
    def self.random
      new_password = password
      ::User.new(
        email: email,
        password: new_password,
        password_confirmation: new_password
      )
    end

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
