class Example < ActiveRecord::Base
  def self.test
    @ex = Example.new
    @ex.test = 'test 3'
    @ex.save
  end
end
