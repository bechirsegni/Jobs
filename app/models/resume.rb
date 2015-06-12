require 'elasticsearch/model'
class Resume < ActiveRecord::Base
  searchkick

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  Resume.import

  def self.search(query)
    __elasticsearch__.search(
        {
            query: {
                multi_match: {
                    query: query,
                    fields: ['title^10']
                }
            }
        }
    )
  end

  belongs_to :user, dependent: :destroy
  has_many :skillings , dependent: :destroy
  has_many :skills, through: :skillings , dependent: :destroy

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
