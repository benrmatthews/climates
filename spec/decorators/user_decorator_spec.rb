require 'spec_helper'

describe UserDecorator do
  describe '.decorate' do
    let(:user) { OpenStruct.new }

    it 'calls UserDecorator::Unavailable when passed object is nil' do
      expect(UserDecorator::Unavailable).to receive(:new).with(nil)
      UserDecorator.decorate nil
    end

    it 'calls regular decorator when passed object exists' do
      expect(UserDecorator).to receive(:new).with(user)
      UserDecorator.decorate user
    end
  end
end
