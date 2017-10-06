require 'rails_helper'

describe RegisterUser do
  let(:data){ Hash.new }
  let(:new_user){ User.new}
  subject{ described_class.new data }

  it "prepares new user from data" do
    expect(subject.klass).to receive(:new).with(data)
    subject.build_new_user
  end

  it "saves the new user" do
    expect(subject).to receive(:build_new_user).and_return(new_user)
    expect(new_user).to receive(:save!)
    subject.commence!
  end

end
