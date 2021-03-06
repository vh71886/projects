require "./item.rb"

class List
    attr_reader :label

    def initialize(label)
        @label = label
        @items = []     # Instances of Item
    end

    def label=(new_label)
        @label = new_label
    end

    def add_item(title, deadline, description=nil)
        description ||= ""
        if Item.valid_date?(deadline)
            @items << Item.new(title, deadline, description)
            return true
        end
        false
    end

    def size
        @items.length
    end

    def valid_index?(idx)
        idx < @items.length && idx >= 0
    end

    def swap(idx1, idx2)
        if valid_index?(idx1) && valid_index?(idx2)
            @items[idx1], @items[idx2] = @items[idx2], @items[idx1]
            return true
        end
        false
    end

    def [](idx)
        @items[idx]
    end

    def priority
        self[0]
    end

    def print
        puts "Index |  Deadline   |  Item"
        @items.each.with_index do |item, i|
            puts "#{i}     |  #{item.deadline} |  #{item.title}"
        end
    end

    def print_full_item(idx)
        if valid_index?(idx)
            puts "#{self[idx].title}  |  #{self[idx].deadline} | #{self[idx].description}"
        end
    end

    def print_priority
        print_full_item(0)
    end

    # playing with recursion
    def up(idx, amt)
        return false if !valid_index?(idx)
        amt ||= 1
        if amt == 1 || idx == 1
            swap(idx, idx - 1)
        elsif idx > 0
            swap(idx, idx - 1)
            up(idx - 1, amt - 1)
        end
        true
    end

    def down(idx, amt)
        return false if !valid_index?(idx)
        amt ||= 1
        while amt > 0 && idx < @items.length - 1
            swap(idx, idx + 1)
            idx += 1
            amt -= 1
        end
        true
    end

    def sort_by_date!
        @items.sort_by! { |item| item.deadline }
    end
end