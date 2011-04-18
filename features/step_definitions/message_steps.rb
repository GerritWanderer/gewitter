When /^I click "([^"]*)" in the (\d+)(?:st|nd|rd|th) message row$/ do |link, pos|
  within("ol li:nth-child(#{pos.to_i}) span.actions") do
    click_link link
  end
end
Then(/^I should see all my messages$/) do
  messages = find_models("message", "user_id: 1")
  messages = messages.sort_by { |w| w["created_at"] }
  counter = 0
  messages.each do |message|
    counter+=1
    Then %{I should see "#{message.user.username}"}
    Then %{I should see "#{message.text}"}
  end
end
Then(/^I should see the subscribed messages$/) do
  messages = find_models("message", "user_id: 2")
  messages = messages.sort_by { |w| w["created_at"] }
  counter = 0
  messages.each do |message|
    counter+=1
    Then %{I should see "#{message.user.username}"}
    Then %{I should see "#{message.text}"}
  end
end

When /^I fill in "([^"]*)" with to much letters$/ do |field|
  When %{I fill in "#{field}" with "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum tortor odio, accumsan eu ullamcorper ut, vehicula eu purus. Mauris commodo, nisl at sollicitudin egestas, tellus arcu aliquam lectus, ultrices tincidunt diam quam et magna. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus."}
end
