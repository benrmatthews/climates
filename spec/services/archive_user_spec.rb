require 'rails_helper'

describe ArchiveUser do

  describe '#commence!' do
    let(:user) { User.create }
    let(:skill) { Skill.create(user_id: user.id) }
    before { ArchiveUser.new(user).commence! }

    it 'sets archived_at field to time now' do
      expect(user.archived_at).to be_within(1.second).of(Time.zone.now)
    end

    it 'deletes user skills' do
      expect(user.skills).to be_empty
    end
  end
end
