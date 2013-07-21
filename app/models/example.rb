class Example < ActiveRecord::Base
  def self.test
    @ex = Example.new
    @ex.test = 'test 2'
    @ex.save
  end
end
