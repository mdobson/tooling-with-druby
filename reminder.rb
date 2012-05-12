require 'drb/drb'
require 'growl'

class Reminder
	def initialize
		@item = {}
		@serial = 0
	end

	def [](key)
		@item[key]
	end

	def add(str)
		@serial += 1
		@item[@serial] = str
		Growl.notify do |n|
			n.message = "#{str} added"
			n.icon = :jpeg
		end
		@serial
	end

	def delete(key)
		@item.delete(key)
	end

	def to_a
		@item.keys.sort.collect do |key|
			[key, @item[key]]
		end
	end
end

front = Reminder.new
DRb.start_service('druby://localhost:12345',front)
puts DRb.uri
DRb.thread.join()