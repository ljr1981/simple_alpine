note
	description: "Tests for SIMPLE_ALPINE"
	author: "Larry Rix"
	date: "$Date$"
	revision: "$Revision$"
	testing: "covers"

class
	LIB_TESTS

inherit
	TEST_SET_BASE

feature -- Test: Element Creation

	test_div_make
			-- Test Alpine div element creation.
		note
			testing: "covers/{ALPINE_DIV}.make"
		local
			element: ALPINE_DIV
		do
			create element.make
			assert_attached ("element created", element)
		end

	test_div_to_html
			-- Test HTML rendering.
		note
			testing: "covers/{ALPINE_DIV}.to_html"
		local
			element: ALPINE_DIV
			html: STRING
		do
			create element.make
			html := element.to_html
			assert_false ("html not empty", html.is_empty)
			assert_string_contains ("has div tag", html, "div")
		end

end
