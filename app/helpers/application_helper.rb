module ApplicationHelper

  def full_title(page_title)
    base_title = "Job Planet Tunisia"
    page_title.empty? ?  base_title : "#{page_title} | #{base_title} "
  end

  def tag_cloud(tags, classes)
    max = tags.sort_by(&:count).last
    tags.each do |tag|
      index = tag.count.to_f / max.count * (classes.size - 1)
      yield(tag, classes[index.round])
    end
  end

  def gravatar_for(user, size = 30, title = user.name)
    image_tag gravatar_image_url(user.email, size: size), title: title, class: 'img-rounded'
  end

  def mailbox
    @mailbox ||= current_user.mailbox
  end

end
