# == Schema Information
#
# Table name: records
#
#  id         :bigint           not null, primary key
#  condition  :integer          not null
#  notes      :text
#  album_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :record do
    album
    condition { 9 }
    notes { "This record l.i.t.e.r.a.l.l.y. saved my life" }
  end
end
