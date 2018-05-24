# frozen_string_literal: true
# This module is use to add customs methods to the original "proposal_vote.rb"

module VoteProposalExtend
  def initialize(proposal, current_user, weight)
    @proposal = proposal
    @current_user = current_user
    @weight = weight
  end

  def build_proposal_vote
    @vote = @proposal.votes.find_or_initialize_by(author: current_user)
    @vote.update_attributes!(weight: @weight)
  end
end

Decidim::Proposals::VoteProposal.class_eval do
  prepend(VoteProposalExtend)
end
