class Authorization < ActiveRecord::Base
  belongs_to :teacher
  validates_presence_of :teacher_id, :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider

  def self.find_from_hash(hash)
    find_by_provider_and_uid(hash['provider'], hash['uid'])
  end

  def self.create_from_hash(hash, teacher=nil)
    teacher ||= teacher.create_from_hash!(hash)
    Authorization.create(:teacher => teacher,
                         :uid => hash['uid'],
                         :provider=> hash['provider'])


end
