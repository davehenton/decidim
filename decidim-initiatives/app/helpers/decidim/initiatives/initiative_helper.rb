# frozen_string_literal: true

module Decidim
  module Initiatives
    # Helper method related to initiative object and its internal state.
    module InitiativeHelper
      include Decidim::SanitizeHelper

      # Public: The state of a proposal in a way a human can understand.
      #
      # state - The String state of the proposal.
      #
      # Returns a String.
      def humanize_proposal_state(state)
        I18n.t(state, scope: "decidim.initiatives.admin_states", default: :created)
      end

      # Public: The css class applied based on the initiative state to
      #         the initiative badge.
      #
      # initiative - Decidim::Initiative
      #
      # Returns a String.
      def state_badge_css_class(initiative)
        return "success" if initiative.accepted?
        "warning"
      end

      # Public: The state of an initiative in a way a human can understand.
      #
      # initiative - Decidim::Initiative.
      #
      # Returns a String.
      def humanize_state(initiative)
        I18n.t(initiative.accepted? ? "accepted" : "expired",
               scope: "decidim.initiatives.states",
               default: :expired)
      end

      # Public: The state of an initiative from an administration perspective in
      # a way that a human can understand.
      #
      # state - String
      #
      # Returns a String
      def humanize_admin_state(state)
        I18n.t(state, scope: "decidim.initiatives.admin_states", default: :created)
      end

      def popularity_tag(initiative)
        content_tag(:div, class: "extra__popularity popularity #{popularity_class(initiative)}".strip) do
          5.times do
            concat(content_tag(:span, class: "popularity__item") {})
          end

          concat(content_tag(:span, class: "popularity__desc") do
            I18n.t("decidim.initiatives.initiatives.vote_cabin.supports_required",
                   total_supports: initiative.scoped_type.supports_required)
          end)
        end
      end

      def popularity_class(initiative)
        return "popularity--level1" if popularity_level1?(initiative)
        return "popularity--level2" if popularity_level2?(initiative)
        return "popularity--level3" if popularity_level3?(initiative)
        return "popularity--level4" if popularity_level4?(initiative)
        return "popularity--level5" if popularity_level5?(initiative)
        ""
      end

      def popularity_level1?(initiative)
        initiative.percentage.positive? && initiative.percentage < 40
      end

      def popularity_level2?(initiative)
        initiative.percentage >= 40 && initiative.percentage < 60
      end

      def popularity_level3?(initiative)
        initiative.percentage >= 60 && initiative.percentage < 80
      end

      def popularity_level4?(initiative)
        initiative.percentage >= 80 && initiative.percentage < 100
      end

      def popularity_level5?(initiative)
        initiative.percentage >= 100
      end
    end
  end
end
