Category.create(name: "Хүүхдийн хувцас");
Category.create(name: "Эрэгтэй хувцас");
Category.create(name: "Эмэгтэй хувцас");
Category.create(name: "Бэлэн хувцас");
Category.create(name: "Ширхэг хувцас");
Category.create(name: "Ажлын хувцас");
admin = User.create!(email: 'admin@example.com', first_name: 'Admin', last_name: 'Super', role: 1, password: 'password', password_confirmation: 'password');
user1 = User.create!(email: 'user1@example.com', first_name: 'Member', last_name: 'Medium', role: 2, password: 'password', password_confirmation: 'password');
user2 = User.create!(email: 'user2@example.com', first_name: 'User', last_name: 'Medium', role: 3, password: 'password', password_confirmation: 'password');
product = Product.create!(category_id: 1, user_id: 1, name: 'product 1', price: 300000, total_amount: 500000, quantity: 1000, prev_quantity: 1000, unit: 1);
product1 = Product.create!(category_id: 1, user_id: 1, name: 'product 1', price: 300000, total_amount: 500000, quantity: 1000, prev_quantity: 1000, unit: 1);
product2 = Product.create!(category_id: 1, user_id: 1, name: 'product 1', price: 300000, total_amount: 500000, quantity: 1000, prev_quantity: 1000, unit: 1);

