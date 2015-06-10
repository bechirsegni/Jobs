require 'elasticsearch/model'
class Job < ActiveRecord::Base
  searchkick
  belongs_to :user

    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

  Job.import
end
