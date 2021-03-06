# frozen_string_literal: true

require "decidim/has_class_extends"

module MeetingExtend
  include Decidim::HasClassExtends

  def users_to_notify_on_comment_created
    # get_all_users_with_role
    followers
  end

  def users_to_notify_on_comment_authorized
    followers
  end
end

Decidim::Meetings::Meeting.class_eval do
  prepend(MeetingExtend)
end
