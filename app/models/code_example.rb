class CodeExample < ApplicationRecord
  belongs_to :user

  before_create :generate_unique_slug

  validates :user, presence: true
  validate :git_or_local_example

  def git_example?
    git.present?
  end

  def git_uri
    return URI(git) if git_example?
  end

  def local_example?
    name.present? && content.present?
  end

  def to_param
    slug
  end

  private
  def git_or_local_example
    if !git_example? && !local_example?
      errors.add(:base, :not_git_or_local_example, message: "must be a git or local example")
    end
  end

  def generate_unique_slug
    result = git_uri ? git_uri.path.parameterize : name.parameterize

    if self.class.find_by(slug: result)
      next_id = self.class.maximum(:id).next
      result = "#{result}-#{next_id}"
    end

    self.slug ||= result
    return slug
  end
end
