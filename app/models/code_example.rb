class CodeExample < ApplicationRecord
  belongs_to :user
  has_many :file_objects, dependent: :destroy
  accepts_nested_attributes_for :file_objects

  before_create :generate_unique_slug

  validates :user, presence: true
  validates :git,
    format: { with: URI::regexp(%w(http https)) },
    allow_nil: true
  validate :git_or_local_example

  def git_example?
    git.present?
  end

  def git_uri
    return URI(git) if git_example?
  end

  def github_example?
    git_example? && git.include?("github.com")
  end

  def local_example?
    name.present? && content.present?
  end

  def to_param
    slug
  end

  def import_from_api
    if github_example?
      logger.info "Importing #{git}"
      attrs = GitHub::Repository.new(git).to_code_example_attributes
      assign_attributes(attrs)
      save!
    # elsif ex.gitlab_example?
      # import from gitlab
    else
      logger.info "#{slug} is not an importable git example. Skipping..."
    end
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
