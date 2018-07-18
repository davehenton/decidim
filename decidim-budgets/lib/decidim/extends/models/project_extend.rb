module ProjectExtend
  def users_to_notify_on_comment_created
    get_all_users_with_role
  end
end

Decidim::Budgets::Project.class_eval do
  prepend(ProjectExtend)
  geocoded_by :address, http_headers: ->(project) { { "Referer" => project.component.organization.host } }
end