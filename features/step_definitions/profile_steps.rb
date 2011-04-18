Then(/^I should see the 5 newest profiles$/) do
  users = find_models("user")
  users = users.sort_by { |u| u["created_at"] }
  users.slice!(0,5)
  counter = 0
  users.each do |user|
    counter+=1
    Then %{I should see "#{user.username}"}
  end
end
