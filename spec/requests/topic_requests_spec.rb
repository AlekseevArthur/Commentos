# Frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Topics requests', type: :request do
  context 'from unauthorized user should' do
    it 'not add topic' do
      post '/topics', params: { topic: { name: '1', text: '1' } }
      expect(Topic.count).to eq(0)
    end

    it 'not add comment' do
      create(:topic)
      post "/topics/#{Topic.first.id}/comments", params: { text: '1' }
      expect(Comment.count).to eq(0)
    end
  end

  context 'from authorized user should' do
    let(:user) { create :user }

    it 'not add topic' do
      post '/topics', params: { topic: { name: '1', text: '1' } }
      expect(Topic.count).to eq(0)
    end

    it 'add comment' do
      sign_in user
      create(:topic)
      post "/topics/#{Topic.first.id}/comments", params: { comment: { text: '1' } }
      expect(Comment.first).to_not eq(nil)
    end

    it 'delete own comment' do
      sign_in build(:user)
      create(:comment)
      comment = Comment.first
      expect(Comment.count).to eq(1)
      delete "/topics/#{Topic.first.id}/comments/#{comment.id}"
      expect(Comment.count).to eq(0)
    end

    it 'not delete another\'s comment' do
      sign_in create(:tony_hawk)
      create(:comment)
      comment = Comment.first
      expect(Comment.count).to eq(1)
      delete "/topics/#{Topic.first.id}/comments/#{comment.id}"
      expect(Comment.count).to eq(1)
    end
  end

  context 'from admin should' do
    it 'add topic' do
      sign_in create(:admin)
      expect(Topic.count).to eq(0)
      post '/topics', params: { topic: { name: '1', text: '1' } }
      expect(Topic.count).to eq(1)
    end

    it 'delete topic' do
      sign_in build(:admin)
      expect(Topic.count).to eq(0)
      topic = create(:topic)
      expect(Topic.count).to eq(1)
      delete "/topics/#{topic.id}"
      expect(Topic.count).to eq(0)
    end

    it 'add comment' do
      sign_in create(:admin)
      create(:topic)
      expect(Comment.count).to eq(0)
      post "/topics/#{Topic.first.id}/comments", params: { comment: { text: '1' } }
      expect(Comment.count).to eq(1)
    end

    it 'delete admin comment' do
      sign_in build(:admin)
      create(:topic)
      admin_com = create(:comment_from_admin)
      expect(Comment.count).to eq(1)
      delete "/topics/#{Topic.first.id}/comments/#{admin_com.id}"
      expect(Comment.count).to eq(0)
    end

    it 'delete any comment' do
      sign_in build(:admin)
      create(:topic)
      tony_com = create(:comment_from_tony_hawk)
      expect(Comment.count).to eq(1)
      delete "/topics/#{Topic.first.id}/comments/#{tony_com.id}"
      expect(Comment.count).to eq(0)
    end
  end
end
