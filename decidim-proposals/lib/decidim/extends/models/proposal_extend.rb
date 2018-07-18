# frozen_string_literal: true
# This module is use to add customs methods to the original "proposal.rb"

module ProposalExtend
  def up_voted_by?(user)
    votes.where(author: user,  proposal: self, weight: 1).any?
  end

  def neutral_voted_by?(user)
    votes.where(author: user,  proposal: self, weight: 0).any?
  end

  def down_voted_by?(user)
    votes.where(author: user,  proposal: self, weight: -1).any?
  end

  def users_to_notify_on_proposal_created
    get_all_users_with_role
  end

  def users_to_notify_on_comment_created
    get_all_users_with_role
  end
end

Decidim::Proposals::Proposal.class_eval do
  prepend(ProposalExtend)
  # Votes weight
  has_many :up_votes, -> { where(weight: 1) }, foreign_key: "decidim_proposal_id", class_name: "ProposalVote", dependent: :destroy
  has_many :down_votes, -> { where(weight: -1) }, foreign_key: "decidim_proposal_id", class_name: "ProposalVote", dependent: :destroy
  has_many :neutral_votes, -> { where(weight: 0) }, foreign_key: "decidim_proposal_id", class_name: "ProposalVote", dependent: :destroy

end
