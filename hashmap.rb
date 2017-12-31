# Vineet Shah
# KPCB Fellows Hashmap Implementation
# 09/03/2017

# The Hashmap class will provide an implemenation of a hashmap of fixed length.
# It accepts Strings as keys which point to data object references

# This implementation will use an implemented LinkedList to handle collisions 
# and will utilize Ruby's built in hash method to hash our string keys

class Hashmap
	# The constructor for the Hashmap class
	# Params:
	# 	size => The fixed size of the Hashmap to define
	# Properties of Hashmap Object:
	# 	size => The fixed size of the Hashmap that was defined 
	#   total => The total number of elements stored in the Hashmap
	#   arr => The array that is being used to store the data
	def initialize(size)
		raise ArgumentError, "Please try again with a valid size" if size <= 0
		@size = size
		@total = 0
		@arr = Array.new(size)
	end

	# The set method for the Hashmap class
	# This method will add a (key, value) pair to the Hashmap
	# Params:
	# 	key => the key as a string to be inserted into the Hashmap
	#   value => the value associated with the key
	def set(key, value)
		# Do not modify object if key already exists or if total exceeds size
		return false if key==nil || value == nil || get(key) != nil || @total >= @size
		# Get the hash of our key
		index = key.hash % @size
		# If something exists at that location then we must add a node to our 
		# LinkedList otherwise we create a list at that location
		if @arr[index]
			@arr[index].add(key, value)
		else
			@arr[index] = LinkedList.new(key, value)
		end 
		# Increase the total by 1 and return true
		@total += 1
		return true
	end

	# The get method for the Hashmap class
	# This method will return the value associated with the key parameter
	# Params:
	# 	key => the key we want to find the respective associated value with
	def get(key)
		return nil if !key
		# Get the hash of our key
		index = key.hash % @size
		# If location in array is empty then return nil otherwise find the 
		# key and return associated value from the list
		return nil if !@arr[index]
		return @arr[index].find(key)
	end


	# The delete method for the Hashmap class
	# This method will delete a key from the Hashmap and return the value 
	# associated with the key parameter
	# Params:
	# 	key => the key we want to delete
	def delete(key)
		# If key does not exist then return nil otherwise delete node from list
		# and decrease total number of items in Hashmap by 1
		return nil if key == nil || !get(key)
		index = key.hash % @size
		@total -= 1
		return @arr[index].delete(key)
	end

	# The load method for the Hashmap class
	# This method will return the load factor for the Hashmap which is defined
	# as the total number of elements divided by its size
	def load()
		return @total/@size
	end

	############################################################################
	# Helper Classes
	# Inner Node Class
	# The Node class is what our LinkedList is composed of
	class Node
		# Getters and Setters for the three properties
		attr_accessor :key, :value, :next

		# The constructor for the Node class
		# Params:
		# 	key => The key that is used to store our object
		#   val => The value associated with the key
		#   next => The next node that it points to
		# Properties of Node Object:
		# 	key => The key that is used to store our object
		#   val => The value associated with the key
		#   next => The next node that it points to
		def initialize(key, value, next_node)
			@key = key
			@value = value
			@next = next_node
		end
	end

	# Inner LinkedList Class
	# The LinkedList class is what is used for when collisions occur in our 
	# Hashmap and is made up of Nodes from the Nodes Helper Class
	class LinkedList
		# The constructor for the LinkedList class
		# Params:
		# 	key => The key that is used to store our object
		#   val => The value associated with the key
		# Properties of Node Object:
		# 	head => A node object that is the beginning of our LinkedList
		def initialize(key, value)
    		@head = Node.new(key, value, nil)
  		end

  		# The add method for the LinkedList Class
  		# This method will add a Node to the beginning to our LinkedList
  		# Params:
  		# 	key => The key that we want to store in our node
  		# 	value => The value that we want to store in our node
  		def add(key, value)
  			# Create new node for key, value to be added and set next to head 
  			# and then set head to the new node
  			n = Node.new(key, value, @head)
  			@head = n
  		end

  		# The find method for the LinkedList Class
  		# This method will find a Node with a key in our LinkedList and return
  		# the value stored in that Node
  		# Params:
  		# 	key => The key that we want to find in our LinkedList
  		def find(key)
  			# Start at beginning of the List
  			current = @head
  			# Go through list until nil
			while current
				# If matching key is found return value at node
				if current.key == key
					return current.value
				end
				# Go to next node
				current = current.next
			end
  		end

  		# The delete method for the LinkedList Class
  		# This method will remove a Node with a key in our LinkedList and return
  		# the value stored in that Node
  		# Params:
  		# 	key => The key that we want to remove from our LinkedList
  		def delete(key)
  			# Keep track of a previous and current
  			prev = nil
  			current = @head
  			# Go through the LinkedList until we haven't found the key and move
  			# both pointers forward
  			while current && current.key != key
  				prev = current
  				current = current.next
  			end
  			# If prev is nil then only one Node in the LinkedList
  			if prev == nil
  				@head = current.next
  			else 
  				# Set the next of the previous node to the next of the current 
  				# node to remove it from our List
  				prev.next = current.next
  			end
  			# Store val and then set current to nil to avoid dangling pointer
  			val = current.value
  			current = nil
  			# Return the stored val
 			return val
    	end
	end
end
