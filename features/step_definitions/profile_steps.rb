Then(/^I should see the 10 latest messages$/) do
  messages = find_models("message")
  messages = messages.sort_by { |u| u["created_at"] }.reverse
  messages.each do |message|
    Then %{I should see "#{message.username}"}
  end
end
