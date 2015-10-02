class User < ActiveRecord::Base
  include Authem::User
  has_many :runs, dependent: :destroy

  def current_streak_distance
      calc_unless_no_streak { streaks.first.inject(0.0) { |n, run| n + run.distance } }
  end

  def current_streak_days
    calc_unless_no_streak { streak_length(streaks.first) }
  end

  def current_streak_average
    calc_unless_no_streak { streaks.first.inject(0.0) { |n, run| n + run.distance } / streak_length(streaks.first) }
  end

  def longest_streak
    longest = 0
    streaks.each do |streak|
      new = streak.map { |run| run.ran_on }.uniq.count
      longest = new > longest ? new : longest
    end

    longest
  end

  def streaks
    streak_list = []
    streak = []

    last_date = Date.today
    self.runs.order(ran_on: :desc).each do |run|
      if last_date - run.ran_on > 1
        streak_list << streak
        streak = []
      end

      last_date = run.ran_on
      streak << run
    end

    streak_list << streak

    streak_list
  end

  private

  def streak_length(streak)
    streak.map { |run| run.ran_on }.uniq.count
  end

  def calc_unless_no_streak
    unless streaks.first.empty?
      yield
    else
      0
    end
  end

  def current_streak
    streaks.first
  end
end
