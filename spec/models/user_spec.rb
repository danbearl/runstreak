require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#current_streak_days" do
    it 'returns the length of the current streak' do
      @user = Fabricate(:user)

      3.times do |n|
        Run.create(user_id: @user.id, ran_on: Date.today - n, distance: 1)
      end

      expect(@user.current_streak_days).to eq(3)
    end

    it 'returns 0 if no runs in the past day' do

      @user = Fabricate(:user)

      3.times do |n|
        Run.create(user_id: @user.id, ran_on: Date.today - n - 3, distance: 1)
      end

      expect(@user.current_streak_days).to eq(0)
    end
  end

  describe '#current_streak_distance' do
    it 'returns the total distance of the current streak' do
      @user = Fabricate(:user)

      3.times do |n|
        Run.create(user_id: @user.id, ran_on: Date.today - n, distance: 2)
      end

      expect(@user.current_streak_distance).to eq(6)
    end

    it 'returns 0 if no runs in the past day' do

      @user = Fabricate(:user)

      3.times do |n|
        Run.create(user_id: @user.id, ran_on: Date.today - n - 3, distance: 1)
      end

      expect(@user.current_streak_distance).to eq(0)
    end
  end

  describe '#current_streak_average' do
    it 'returns the average miles per day in the current streak' do
      @user = Fabricate(:user)

      3.times do |n|
        Run.create(user_id: @user.id, ran_on: Date.today - n, distance: n + 1)
      end

      expect(@user.current_streak_average).to eq(2)
    end
  end

  describe '#longest_streak' do
    it 'returns the length in days of the longest streak' do
      @user = Fabricate(:user)

      3.times do |n|
        Run.create(user_id: @user.id, ran_on: Date.today - n, distance: 1)
      end

      4.times do |n|
        Run.create(user_id: @user.id, ran_on: Date.today - n - 10, distance: 1)
      end

      expect(@user.longest_streak).to eq(4)
    end
  end
end
