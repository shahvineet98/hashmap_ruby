#!/usr/local/bin/ruby

require "minitest/autorun"
require_relative "hashmap.rb"

class Tests < Minitest::Test
    def setup
        @map = Hashmap.new(5)
        @obj = ["I am a random data object"]
        assert_raises(ArgumentError) { @map = Hashmap.new(0) }
    end

    def test_set
        assert_equal(false, @map.set(nil, nil))
        assert(@map.set("key1", 1))
        assert(@map.set("key2", @obj))
        assert_equal(false, @map.set("key1", 1))
        assert_equal(false, @map.set("key1", "Hello"))
        assert(@map.set("key3", @obj))
        assert(@map.set("key4", @obj))
        assert(@map.set("key5", @obj))
        assert_equal(false, @map.set("beyondCapacity", @obj))
        assert(1, @map.load())
    end

    def test_get
        @map.set("key1", 1)
        @map.set("key2", @obj)

        assert_equal(1, @map.get("key1"))
        assert_equal(["I am a random data object"], @map.get("key2"))
        assert_nil(@map.get("key3"))
        assert_nil(@map.get(nil))
    end

    def test_delete
        @map.set("key1", 1)
        @map.set("key2", @obj)

        assert_equal(1, @map.delete("key1"))
        assert_nil(@map.get("key1"))
        assert_nil(@map.delete("key1"))
        assert_nil(@map.delete(nil))
    end

    def test_load
        @map.set("key3", 3)
        @map.set("key4", 4)
        @map.set("key5", 5)
        @map.set("key6", 6)
        assert(1, @map.load())
    end
end
