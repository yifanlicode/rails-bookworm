# app/models/province.rb
class Province < ApplicationRecord
  has_many :addresses
end