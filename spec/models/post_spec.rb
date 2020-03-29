require 'rails_helper'

describe Post do
  describe '#create' do
    # 1. nicknameが空では登録できないこと
    it "is invalid without a nickname" do
      post = build(:post, title: "")
      post.valid?
      expect(post.errors[:title])
    end


    # 3. emailが空では登録できないこと
    it "is invalid without a email" do
      post = build(:post, content: "")
      post.valid?
      expect(post.errors[:content])
    end
  end
end