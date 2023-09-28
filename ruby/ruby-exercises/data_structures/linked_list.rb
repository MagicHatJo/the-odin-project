class Node
	attr_accessor :data, :next

	def initialize(data = nil)
		@data = data
		@next = nil
	end
end

class LinkedList
	attr_accessor :head, :tail
	attr_reader   :size

	def initialize()
		@head = nil
		@tail = nil
		@size = 0
	end

	def append(data)
		node = Node.new(data)

		if @head.nil?
			@head = node
			@tail = node
		else
			@tail.next = node
			@tail = @tail.next
		end
		@size += 1
	end

	def prepend(data)
		node = Node.new(data)
		node.next = head
		@head = node
		@tail = node if @tail.nil?
		@size += 1
	end

	def at(index)
		curr = @head
		index.times { curr = curr.next unless curr == @tail }
		return curr
	end

	def pop()
		return nil if @head.nil?
		
		out = @tail
		if @size == 1
			@head = nil
			@tail = nil
		else
			curr = @head
			curr = curr.next until curr.next == @tail
			curr.next = nil
			@tail = curr
		end
		@size -= 1
		return out
	end

	def contains?(data)
		curr = @head
		until curr.nil? do
			return true if curr.data == data
			curr = curr.next
		end
		return false
	end

	def find(data)
		i = 0
		curr = @head
		until curr.nil? do
			return i if curr.data == data
			curr = curr.next
			i += 1
		end
		return nil
	end

	def to_s()
		curr = @head
		until curr.nil? do
			print "#{curr.data} -> "
			curr = curr.next
		end
		puts "nil"
	end

	def insert_at(data, index)
		return nil if index < 0

		if index == 0
			self.prepend(data)
		else
			curr = @head
			(index - 1).times { curr = curr.next unless curr.next.nil? }
			node = Node.new(data)
			node.next = curr.next
			curr.next = node
			@tail = node if curr == @tail
		end
		@size += 1
	end

	def remove_at(index)
		return nil if index < 0 || index >= @size

		if index == 0
			@head = head.next
		else
			curr = @head
			(index - 1).times { curr = curr.next }
			@tail = curr if curr.next == @tail
			curr.next = curr.next.next
		end
		@size -= 1
	end
end