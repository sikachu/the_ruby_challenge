require "benchmark"

class CodeChallenge < ActiveRecord::Base
  GOALS = %w(speed memory_usage)
  SLUG_CHARACTERS_RANGE = [*('0'..'9'), *('a'..'z'), *('A'..'Z')]

  belongs_to :submitter, class_name: "User"

  validates :submitter, :left_code_sample, :right_code_sample, :goal,
    presence: :true
  validates :goal, inclusion: GOALS, if: :goal?

  before_validation :generate_slug, on: :create
  before_save :test_left_code_sample_speed, if: :left_code_sample_changed?
  before_save :test_right_code_sample_speed, if: :right_code_sample_changed?

  def self.random
    order("random()")
  end

  def self.unused
    where(displayed_at: nil)
  end

  def to_param
    slug
  end

  def submitted_by?(user)
    submitter == user
  end

  def left_wins?
    left_time_usec.to_i < right_time_usec.to_i
  end

  def right_wins?
    !left_wins?
  end

  def displayed?
    !displayed_at.nil?
  end

  def pick(side)
    @pick = ([side] & %w(left right)).first
  end

  def correct?
    (@pick == "left" && left_wins?) || (@pick == "right" && right_wins?)
  end

  def test_left_code_sample_speed
    self.left_time_usec = test_code_speed(left_code_sample)
  end

  def test_right_code_sample_speed
    self.right_time_usec = test_code_speed(right_code_sample)
  end

  private

  def generate_slug
    while slug.nil? || CodeChallenge.where(slug: slug).exists?
      self.slug = Array.new(5) { SLUG_CHARACTERS_RANGE.sample }.join
    end
  end

  def test_code_speed(code)
    quietly do
      # TODO: This is consider unsafe
      result = Benchmark.bmbm { |t| t.item { eval(code) }}
      result.first.real * 1_000_000
    end
  rescue
    0
  end
end
