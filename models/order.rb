class Order
	attr_accessor :id, :temp, :size, :toppings

	def self.open_connection
		conn = PG.connect(dbname: "beef")
	end

	def self.all
		conn = self.open_connection
		sql = "SELECT id, size, temp, toppings FROM orders ORDER BY id"
		result = conn.exec(sql)
		
		orders = result.map do |tuple|
			self.hydrate tuple
		end
		
		orders
	end

	def self.hydrate order_data
		order = Order.new
		toppings_list = order_data['toppings'].delete "{}"

		order.id = order_data['id']
		order.size = order_data['size']
		order.temp = order_data['temp']
		order.toppings = toppings_list


		order
	end

	def self.grab id
		conn = self.open_connection
		sql = "SELECT id, size, temp, toppings FROM orders WHERE id=#{id}"
		result = conn.exec(sql)

		orders = result.map do |tuple|
			self.hydrate tuple
		end

		orders[0]
	end

	def save
		conn = Order.open_connection
		sql = "INSERT INTO orders (temp, size, toppings) VALUES ('#{self.temp}' , '#{self.size}', '#{self.toppings}');"
		result = conn.exec(sql)

	end	

	def self.update id, temp, size, toppings
		conn = Order.open_connection
		sql = "UPDATE orders SET temp = '#{temp}', size = '#{size}', toppings = '#{toppings}' WHERE id=#{id}"
		result = conn.exec(sql)
	end

	def self.delete id
		conn = Order.open_connection
		sql = "DELETE FROM orders WHERE id=#{id}"
		result = conn.exec(sql)
	end
end