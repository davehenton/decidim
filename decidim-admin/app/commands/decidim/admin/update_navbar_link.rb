# frozen_string_literal: true

module Decidim
  module Admin
    # A command with all the business logic when updating a navbar link.
    class UpdateNavbarLink < Rectify::Command
      # Public: Initializes the command.
      #
      # form - A form object with the params.
      def initialize(form)
        @form = form
      end

      # Executes the command. Broadcasts these events:
      #
      # - :ok when everything is valid.
      # - :invalid if the form wasn't valid and we couldn't proceed.
      #
      # Returns nothing.
      def call
        return broadcast(:invalid) if form.invalid?

        update_navbar_link
        broadcast(:ok)
      end

      private

      attr_reader :form

      def update_navbar_link
        @navbar_link.update_attributes!(attributes)
      end

      def attributes
        {
          title: form.title,
          link: form.link,
          organization: form.organization
        }
      end
    end
  end
end
