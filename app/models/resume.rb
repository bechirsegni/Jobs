class Resume < ActiveRecord::Base
  belongs_to :user
  has_many :skillings , dependent: :destroy
  has_many :skills, through: :skillings , dependent: :destroy

  has_attached_file :cv, styles: {thumbnail: "60x60#"}
  validates_attachment :cv, content_type: { content_type: "application/pdf" }


  def self.search(search)
    if search
      where(['title LIKE ?', "%#{search}%"])
    else
      all
    end
  end

  def self.location(location)
    if location
      where(['location LIKE ?', "%#{location}%"])
    else
      all
    end
  end

  def self.skilled_with(name)
    Skill.find_by_name!(name).resumes
  end

  def self.skill_counts
    Skill.select("skills.*, count(skillings.skill_id) as count").
        joins(:skillings).group("skillings.skill_id")
  end

  def skill_list
    skills.map(&:name).join(", ")
  end

  def skill_list=(names)
    self.skills = names.split(",").map do |n|
      Skill.where(name: n.strip).first_or_create!
    end
  end
end
