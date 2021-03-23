class Host < ApplicationRecord
  has_many :listings

  def hello
    puts 'Hello World!'
  end
end
