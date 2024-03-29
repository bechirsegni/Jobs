class Job < ActiveRecord::Base

  def to_param
    "#{id} #{title}".parameterize
  end

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


  belongs_to :user
  belongs_to :category
  has_many :taggings, :dependent => :destroy
  has_many :tags, through: :taggings

  def self.tagged_with(name)
    Tag.find_by_name!(name).jobs
  end

  def self.tag_counts
    Tag.select("tags.*, count(taggings.tag_id) as count").
        joins(:taggings).group("taggings.tag_id")
  end

  def tag_list
    tags.map(&:name).join(", ")
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
end
