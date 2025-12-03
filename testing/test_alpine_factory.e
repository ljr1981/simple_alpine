note
	description: "Tests for ALPINE_FACTORY helper methods"
	author: "Larry Rix with Claude"

class
	TEST_ALPINE_FACTORY

inherit
	TEST_SET_BASE

feature -- Test: Expression Builders

	test_toggle
			-- Test toggle expression.
		local
			l_factory: ALPINE_FACTORY
		do
			create l_factory
			assert_strings_equal ("toggle expression", "open = !open", l_factory.toggle ("open"))
		end

	test_set_true
			-- Test set_true expression.
		local
			l_factory: ALPINE_FACTORY
		do
			create l_factory
			assert_strings_equal ("set_true expression", "visible = true", l_factory.set_true ("visible"))
		end

	test_set_false
			-- Test set_false expression.
		local
			l_factory: ALPINE_FACTORY
		do
			create l_factory
			assert_strings_equal ("set_false expression", "visible = false", l_factory.set_false ("visible"))
		end

	test_ternary
			-- Test ternary expression.
		local
			l_factory: ALPINE_FACTORY
		do
			create l_factory
			assert_strings_equal ("ternary expression", "open ? 'block' : 'none'",
				l_factory.ternary ("open", "'block'", "'none'"))
		end

feature -- Test: Class Binding Helpers

	test_class_if
			-- Test class_if helper.
		local
			l_factory: ALPINE_FACTORY
		do
			create l_factory
			assert_strings_equal ("class_if expression", "{ 'active': isActive }",
				l_factory.class_if ("active", "isActive"))
		end

	test_class_multi
			-- Test class_multi helper.
		local
			l_factory: ALPINE_FACTORY
			l_result: STRING
		do
			create l_factory
			l_result := l_factory.class_multi (<<["active", "isActive"], ["hidden", "!isVisible"]>>)
			assert_has_substring ("class_multi has active", l_result, "'active': isActive")
			assert_has_substring ("class_multi has hidden", l_result, "'hidden': !isVisible")
		end

feature -- Test: Data Object Builders

	test_data_bool
			-- Test data_bool helper.
		local
			l_factory: ALPINE_FACTORY
		do
			create l_factory
			assert_strings_equal ("data_bool true", "open: true", l_factory.data_bool ("open", True))
			assert_strings_equal ("data_bool false", "open: false", l_factory.data_bool ("open", False))
		end

	test_data_string
			-- Test data_string helper.
		local
			l_factory: ALPINE_FACTORY
		do
			create l_factory
			assert_strings_equal ("data_string", "name: 'John'", l_factory.data_string ("name", "John"))
		end

	test_data_int
			-- Test data_int helper.
		local
			l_factory: ALPINE_FACTORY
		do
			create l_factory
			assert_strings_equal ("data_int", "count: 42", l_factory.data_int ("count", 42))
		end

	test_data_object
			-- Test data_object helper.
		local
			l_factory: ALPINE_FACTORY
			l_result: STRING
		do
			create l_factory
			l_result := l_factory.data_object (<<
				l_factory.data_bool ("open", False),
				l_factory.data_int ("count", 0)
			>>)
			assert_has_substring ("data_object has open", l_result, "open: false")
			assert_has_substring ("data_object has count", l_result, "count: 0")
			assert_has_substring ("data_object has braces", l_result, "{ ")
		end

feature -- Test: Magic Property Helpers

	test_refs
			-- Test $refs helper.
		local
			l_factory: ALPINE_FACTORY
		do
			create l_factory
			assert_strings_equal ("refs", "$refs.input", l_factory.refs ("input"))
		end

	test_store
			-- Test $store helper.
		local
			l_factory: ALPINE_FACTORY
		do
			create l_factory
			assert_strings_equal ("store", "$store.darkMode", l_factory.store ("darkMode"))
		end

	test_dispatch
			-- Test $dispatch helper.
		local
			l_factory: ALPINE_FACTORY
		do
			create l_factory
			assert_strings_equal ("dispatch", "$dispatch('close')", l_factory.dispatch ("close"))
		end

	test_dispatch_with_data
			-- Test $dispatch with data helper.
		local
			l_factory: ALPINE_FACTORY
		do
			create l_factory
			assert_strings_equal ("dispatch_with_data", "$dispatch('select', item)",
				l_factory.dispatch_with_data ("select", "item"))
		end

feature -- Test: Pre-built Patterns

	test_dropdown_data
			-- Test dropdown data pattern.
		local
			l_factory: ALPINE_FACTORY
		do
			create l_factory
			assert_has_substring ("dropdown has open", l_factory.dropdown_data, "open")
			assert_has_substring ("dropdown has false", l_factory.dropdown_data, "false")
		end

	test_dropdown_toggle
			-- Test dropdown toggle expression.
		local
			l_factory: ALPINE_FACTORY
		do
			create l_factory
			assert_strings_equal ("dropdown toggle", "open = !open", l_factory.dropdown_toggle)
		end

	test_tabs_data
			-- Test tabs data pattern.
		local
			l_factory: ALPINE_FACTORY
		do
			create l_factory
			assert_has_substring ("tabs has activeTab", l_factory.tabs_data ("home"), "activeTab")
			assert_has_substring ("tabs has home", l_factory.tabs_data ("home"), "home")
		end

	test_tabs_select
			-- Test tab selection expression.
		local
			l_factory: ALPINE_FACTORY
		do
			create l_factory
			assert_strings_equal ("tabs select", "activeTab = 'settings'",
				l_factory.tabs_select ("settings"))
		end

	test_tabs_is_active
			-- Test tab active check expression.
		local
			l_factory: ALPINE_FACTORY
		do
			create l_factory
			assert_strings_equal ("tabs is_active", "activeTab === 'home'",
				l_factory.tabs_is_active ("home"))
		end

	test_accordion_toggle
			-- Test accordion toggle expression.
		local
			l_factory: ALPINE_FACTORY
		do
			create l_factory
			assert_has_substring ("accordion toggle has index", l_factory.accordion_toggle (1), "1")
			assert_has_substring ("accordion toggle has null", l_factory.accordion_toggle (1), "null")
		end

	test_counter_data
			-- Test counter data pattern.
		local
			l_factory: ALPINE_FACTORY
		do
			create l_factory
			assert_has_substring ("counter has count", l_factory.counter_data (0), "count")
			assert_has_substring ("counter has value", l_factory.counter_data (10), "10")
		end

feature -- Test: Element Creation

	test_div_creation
			-- Test div element creation.
		local
			l_factory: ALPINE_FACTORY
			l_div: ALPINE_DIV
		do
			create l_factory
			l_div := l_factory.div
			assert ("div created", l_div /= Void)
			assert_has_substring ("is div", l_div.to_html_8, "<div")
		end

	test_button_text_creation
			-- Test button_text creation.
		local
			l_factory: ALPINE_FACTORY
			l_btn: ALPINE_BUTTON
		do
			create l_factory
			l_btn := l_factory.button_text ("Click me")
			assert_has_substring ("button has text", l_btn.to_html_8, "Click me")
		end

	test_input_text_creation
			-- Test input_text creation.
		local
			l_factory: ALPINE_FACTORY
			l_input: ALPINE_INPUT
		do
			create l_factory
			l_input := l_factory.input_text ("username")
			assert_has_substring ("input has type", l_input.to_html_8, "type=%"text%"")
			assert_has_substring ("input has name", l_input.to_html_8, "name=%"username%"")
		end

	test_template_creation
			-- Test template creation.
		local
			l_factory: ALPINE_FACTORY
			l_template: ALPINE_TEMPLATE
		do
			create l_factory
			l_template := l_factory.template
			assert_has_substring ("is template", l_template.to_html_8, "<template")
		end

feature {NONE} -- Implementation

	assert_strings_equal (a_tag: STRING; a_expected, a_actual: STRING)
			-- Assert strings are equal.
		do
			assert (a_tag + " [expected: " + a_expected + ", got: " + a_actual + "]",
				a_expected.same_string (a_actual))
		end

	assert_has_substring (a_tag: STRING; a_string, a_substring: STRING)
			-- Assert that a_string contains a_substring.
		do
			assert (a_tag, a_string.has_substring (a_substring))
		end

end
