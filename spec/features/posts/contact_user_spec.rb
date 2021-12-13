require "rails_helper"

RSpec.feature "Contact user", :type => :feature do
    let(:user) { create(:user) } 
    let(:category) { create(:category, name: 'Arts', branch: 'hobby') }
    let(:post) { create(:post, category_id: category.id) }

    context 'logged in user' do
        before(:each) do
            sign_in user 
        end
        
        scenario "successfully sends a message to a post's author", js: true do
            visit post_path(post)
            expect(page).to have_selector('.contact-user form')

            fill_in('message_body', with: 'a'*20)
            find('form .send-message-to-user').trigger('click')

            expect(page).not_to have_selector('.contact-user form')
            expect(page).to have_selector('.contacted-user', 
                                          text: 'Message has been sent')
        end

        scenario "sees an already contacted mesage", js: true do 
            create(:private_conversation_with_messages,
                   recipient_id: post.user.id,
                   sender_id: user.id)
            
            visit post_path(post)
            expect(page).to have_selector('.contact-user .contacted-user',
                                          text: 'You are already in touch with this user')
        end
    end

    context "user is not logged in" do
        scenario "sees a login is required to contact user" do
            visit post_path(post)
            expect(page).to have_selector('div', text: 'To contact the user you have to Login') 
        end 
    end
end