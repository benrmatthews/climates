class SupportStatus
  attr_accessor :support

  def initialize(support)
    self.support = support
  end

  def to_s
    StatusRange.find_by_score(score).name
  end

  private

  def score
    time_diff = Time.zone.now - Time.zone.at(support.created_at)
    score_booster = support.discussed? ? 0 : 12.hours
    time_diff + score_booster
  end

  class StatusRange < Struct.new(:name, :range)
    def self.all
      [
        new('new',      0..1.day),
        new('ok',       1.day..2.days),
        new('worrying', 2.days..4.days),
        new('critical', 4.days..Float::INFINITY)
      ]
    end

    def self.find_by_score(score)
      all.find { |r| r.range.include?(score) }
    end
  end
end
