require 'rails_helper'

RSpec.describe User, :type => :model do

  describe 'validations', focus do
    it { should validate_presence_of :username }
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
  end

end
