class CodeChallenge < ActiveRecord::Base
  GOALS = %w(speed memory_usage)
  SLUG_CHARACTERS_RANGE = [*('0'..'9'), *('a'..'z'), *('A'..'Z')]

  belongs_to :submitter, class_name: "User"

  validates :submitter, :left_code_sample, :right_code_sample, :goal,
    presence: :true
  validates :goal, inclusion: GOALS, if: :goal?

  before_validation :generate_slug, on: :create

  def to_param
    slug
  end

  def submitted_by?(user)
    submitter == user
  end

  private

  def generate_slug
    while slug.nil? || CodeChallenge.where(slug: slug).exists?
      self.slug = Array.new(8) { SLUG_CHARACTERS_RANGE.sample }.join
    end
  end
end
