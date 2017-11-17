class TwitterUser < ApplicationRecord
    #引数に関連するユーザーが存在すればそれを返し、存在しまければ新規に作成する
  def self.find_or_create_from_auth_hash(auth_hash)
#OmniAuthで取得した各データを代入していく
    provider = auth_hash[:provider]
    uid = auth_hash[:uid]
    nickname = auth_hash[:info][:nickname]

    TwitterUser.find_or_create_by(provider: provider, uid: uid) do |user|
      user.nickname = nickname
    end
  end
end
