Category.create(name: "Хүүхдийн хувцас")
Category.create(name: "Эрэгтэй хувцас")
Category.create(name: "Эмэгтэй хувцас")
Category.create(name: "Бэлэн хувцас")
Category.create(name: "Ширхэг хувцас")
Category.create(name: "Ажлын хувцас")
admin = User.create!(email: 'admin@example.com', first_name: 'Admin', last_name: 'Super', role: 1, password: 'password', password_confirmation: 'password')
user1 = User.create!(email: 'user1@example.com', first_name: 'Member', last_name: 'Medium', role: 2, password: 'password', password_confirmation: 'password')
user2 = User.create!(email: 'user2@example.com', first_name: 'User', last_name: 'Medium', role: 3, password: 'password', password_confirmation: 'password')
product = Product.create!(category_id: 1, user_id: 1, name: 'product 1', price: 45000, total_amount: 45000, quantity: 23, prev_quantity: 1000, unit: 1)
product1 = Product.create!(category_id: 2, user_id: 1, name: 'product 2', price: 300000, total_amount: 300000, quantity: 34, prev_quantity: 1000, unit: 1)
product2 = Product.create!(category_id: 3, user_id: 1, name: 'product 3', price: 100, total_amount: 100, quantity: 10, prev_quantity: 1000, unit: 1)


sms_prefix1 = SmsPrefix.create!(prefix: '99', operator: 'MOBICOM')
sms_prefix2 = SmsPrefix.create!(prefix: '95', operator: 'MOBICOM')
sms_prefix3 = SmsPrefix.create!(prefix: '94', operator: 'MOBICOM')
sms_prefix4 = SmsPrefix.create!(prefix: '85', operator: 'MOBICOM')

sms_prefix5 = SmsPrefix.create!(prefix: '89', operator: 'UNITEL')
sms_prefix6 = SmsPrefix.create!(prefix: '88', operator: 'UNITEL')
sms_prefix7 = SmsPrefix.create!(prefix: '86', operator: 'UNITEL')
sms_prefix8 = SmsPrefix.create!(prefix: '80', operator: 'UNITEL')

sms_prefix9 = SmsPrefix.create!(prefix: '920', operator: 'SKYTEL')
sms_prefix10 = SmsPrefix.create!(prefix: '96', operator: 'SKYTEL')
sms_prefix11 = SmsPrefix.create!(prefix: '91', operator: 'SKYTEL')
sms_prefix12 = SmsPrefix.create!(prefix: '90', operator: 'SKYTEL')


sms_prefix13 = SmsPrefix.create!(prefix: '921', operator: 'GMOBILE')
sms_prefix14 = SmsPrefix.create!(prefix: '98', operator: 'GMOBILE')
sms_prefix15 = SmsPrefix.create!(prefix: '97', operator: 'GMOBILE')
sms_prefix16 = SmsPrefix.create!(prefix: '93', operator: 'GMOBILE')