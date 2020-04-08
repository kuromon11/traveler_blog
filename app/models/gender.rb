class Gender < ActiveHash::Base
  include ActiveHash::Associations
  self.data = [
    { id: 1, name: '男性' },
    { id: 2, name: '女性' }
  ]
end