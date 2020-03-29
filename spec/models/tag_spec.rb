require 'rails_helper'

describe Tag do
  describe '#create' do
    it "tagが空では登録できないこと" do
      tag = build(:tag, name: "")
      tag.valid?
      expect(tag.errors[:name])
    end
  end
end
