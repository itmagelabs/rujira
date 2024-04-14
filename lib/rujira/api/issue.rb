# frozen_string_literal: true

module Rujira
  module Api
    # TODO
    # https://docs.atlassian.com/software/jira/docs/api/REST/8.17.1/#api/2/issue
    class Issue < Item
      def self.get(id_or_key)
        entity = Entity.build do
          path "rest/api/2/issue/#{id_or_key}"
        end
        new(entity.commit)
      end

      def self.del(id_or_key)
        entity = Entity.build do
          path "rest/api/2/issue/#{id_or_key}"
          method :DELETE
        end
        entity.commit
      end

      def self.create(**data)
        entity = Entity.build do
          path 'rest/api/2/issue'
          method :POST
          data data if data
        end
        new(entity.commit)
      end
    end
  end
end
