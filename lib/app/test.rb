require 'gmail'

gmail = Gmail.connect("maxwell.dupond@gmail.com", "AndresErwan2018")

email = gmail.compose do
  to "maxwell.dupond@gmail.com"
  subject "Having fun in Puerto Rico!"
  body "Spent the day on the road..."
end
email.deliver! # or: gmail.deliver(email)

gmail.logout
 