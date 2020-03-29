require 'rails_helper'

describe Post do
  describe '#create' do

    it "titleが空では登録できないこと" do
      post = build(:post, title: "")
      post.valid?
      expect(post.errors[:title])
    end

    it "contentが空では登録できないこと" do
      post = build(:post, content: "")
      post.valid?
      expect(post.errors[:content])
    end
  end
end