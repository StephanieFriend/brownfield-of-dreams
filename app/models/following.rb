class Following < ApplicationRecord
  validate :no_narcissism
  belongs_to :following_user, class_name: "User"
  belongs_to :followed_user, class_name: "User"

  private
  def no_narcissism
    if following_id == followed_id
      errors.add :user, "User cannot follow themselves"
      return false
    end
    true
  end
end