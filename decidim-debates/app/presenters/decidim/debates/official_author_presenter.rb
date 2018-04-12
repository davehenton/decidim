# frozen_string_literal: true

module Decidim
  module Debates
    #
    # A dummy presenter to abstract out the author of an official debate.
    #
    class OfficialAuthorPresenter
      def name
        I18n.t("decidim.debates.models.debate.fields.official_debate")
      end

      def nickname
        ""
      end

      def badge # This method has been extended in lib/decidim/extends/presenters/official_author_presenter_extend.rb
        ""
      end

      def profile_path
        ""
      end

      def avatar_url
        ActionController::Base.helpers.asset_path("decidim/default-avatar.svg")
      end

      def deleted?
        false
      end
    end
  end
end
