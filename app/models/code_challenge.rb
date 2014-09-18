class CodeChallenge < ActiveRecord::Base
  GOALS = %w(speed memory_usage)
  SLUG_CHARACTERS_RANGE = [*('0'..'9'), *('a'..'z'), *('A'..'Z')]

  belongs_to :submitter, class_name: "User"

  validates :submitter, :left_code_sample, :right_code_sample, :goal,
    presence: :true
  validates :goal, inclusion: GOALS, if: :goal?

  before_validation :generate_slug, on: :create

  def self.random
    order("random()")
  end

  def self.unused
    where(displayed: false)
  end

  def to_param
    slug
  end

  def submitted_by?(user)
    submitter == user
  end

  def left_wins?
    left_time_msec.to_i < right_time_msec.to_i
  end

  def right_wins?
    !left_wins?
  end

  def pick(side)
    update_column :displayed, true
    @pick = ([side] & %w(left right)).first
  end

  def correct?
    (@pick == "left" && left_wins?) || (@pick == "right" && right_wins?)
  end

  private

  def generate_slug
    while slug.nil? || CodeChallenge.where(slug: slug).exists?
      self.slug = Array.new(5) { SLUG_CHARACTERS_RANGE.sample }.join
    end
  end
end
