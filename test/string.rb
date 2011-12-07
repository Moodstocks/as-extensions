require "as-extensions"

T = ASE::Test
T::stats(true)

s = "abcde"
T::assert_equal("a",s.first)
T::assert_equal("a",s.head)
T::assert_equal("abcd",s.init)
T::assert_equal("e",s.last)
T::assert_equal("bcde",s.tail)

s = "abcde"
T::assert_equal("x",s.first = "x")
T::assert_equal("xbcde",s)

s = ""
T::assert_raise(IndexError){ s.first = "x" }

s = "abcde"
T::assert_equal("x",s.head = "x")
T::assert_equal("xbcde",s)

s = ""
T::assert_raise(IndexError){ s.head = "x" }

s = "abcde"
T::assert_equal("xxx",s.init = "xxx")
T::assert_equal("xxxe",s)

s = "abcde"
T::assert_equal("x",s.last = "x")
T::assert_equal("abcdx",s)

s = ""
T::assert_raise(IndexError){ s.last = "x" }

s = "abcde"
T::assert_equal("xxx",s.tail = "xxx")
T::assert_equal("axxx",s)

T::stats(false)
