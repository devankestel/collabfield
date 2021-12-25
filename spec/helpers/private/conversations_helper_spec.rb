require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the Private::ConversationsHelper. For example:
#
# describe Private::ConversationsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe Private::ConversationsHelper, type: :helper do
  context "#load_private_messages" do
    let(:conversation) { create(:private_conversation) }

    it "returns load_messages partial path" do 
      create(:private_message, conversation_id: conversation.id)
      expect(helper.load_private_messages(conversation)).to eq(
        'private/conversations/conversation/messages_list/link_to_previous_messages'
      )
    end
    it "returns empty partial when there are no private messages" do
      expect(helper.load_private_messages(conversation)).to eq(
        'shared/empty_partial'
      ) 
    end 
  end
end
