require 'elasticsearch/model'
class Job < ActiveRecord::Base
  searchkick
  belongs_to :user
  belongs_to :category

    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

  Job.import
end
