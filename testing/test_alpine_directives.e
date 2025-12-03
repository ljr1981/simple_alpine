note
	description: "Tests for Alpine.js directive generation"
	author: "Larry Rix with Claude"

class
	TEST_ALPINE_DIRECTIVES

inherit
	TEST_SET_BASE

feature -- Test: x-data

	test_x_data_simple
			-- Test basic x-data attribute.
		local
			l_div: ALPINE_DIV
		do
			create l_div.make
			l_div.x_data ("{ open: false }").do_nothing
			assert_has_substring ("x-data attribute present", l_div.to_html_8, "x-data=")
			assert_has_substring ("x-data value correct", l_div.to_html_8, "{ open: false }")
		end

	test_x_data_empty
			-- Test empty x-data attribute.
		local
			l_div: ALPINE_DIV
		do
			create l_div.make
			l_div.x_data_empty.do_nothing
			assert_has_substring ("x-data attribute present", l_div.to_html_8, "x-data")
		end

	test_x_init
			-- Test x-init attribute.
		local
			l_div: ALPINE_DIV
		do
			create l_div.make
			l_div.x_init ("console.log('ready')").do_nothing
			assert_has_substring ("x-init present", l_div.to_html_8, "x-init=")
		end

feature -- Test: x-show / x-if

	test_x_show
			-- Test x-show attribute.
		local
			l_div: ALPINE_DIV
		do
			create l_div.make
			l_div.x_show ("isVisible").do_nothing
			assert_has_substring ("x-show present", l_div.to_html_8, "x-show=")
			assert_has_substring ("x-show value", l_div.to_html_8, "isVisible")
		end

	test_x_if
			-- Test x-if attribute (typically on template).
		local
			l_template: ALPINE_TEMPLATE
		do
			create l_template.make
			l_template.x_if ("items.length > 0").do_nothing
			assert_has_substring ("x-if present", l_template.to_html_8, "x-if=")
		end

	test_x_cloak
			-- Test x-cloak attribute.
		local
			l_div: ALPINE_DIV
		do
			create l_div.make
			l_div.x_cloak.do_nothing
			assert_has_substring ("x-cloak present", l_div.to_html_8, "x-cloak")
		end

feature -- Test: x-text / x-html

	test_x_text
			-- Test x-text attribute.
		local
			l_span: ALPINE_SPAN
		do
			create l_span.make
			l_span.x_text ("message").do_nothing
			assert_has_substring ("x-text present", l_span.to_html_8, "x-text=")
			assert_has_substring ("x-text value", l_span.to_html_8, "message")
		end

	test_x_html
			-- Test x-html attribute.
		local
			l_div: ALPINE_DIV
		do
			create l_div.make
			l_div.x_html ("richContent").do_nothing
			assert_has_substring ("x-html present", l_div.to_html_8, "x-html=")
		end

feature -- Test: x-on events

	test_x_on_click
			-- Test @click shorthand.
		local
			l_btn: ALPINE_BUTTON
		do
			create l_btn.make
			l_btn.x_on_click ("open = !open").do_nothing
			assert_has_substring ("@click present", l_btn.to_html_8, "@click=")
		end

	test_x_on_click_prevent
			-- Test @click.prevent modifier.
		local
			l_btn: ALPINE_BUTTON
		do
			create l_btn.make
			l_btn.x_on_click_prevent ("handleClick()").do_nothing
			assert_has_substring ("@click.prevent present", l_btn.to_html_8, "@click.prevent=")
		end

	test_x_on_click_outside
			-- Test @click.outside modifier.
		local
			l_div: ALPINE_DIV
		do
			create l_div.make
			l_div.x_on_click_outside ("open = false").do_nothing
			assert_has_substring ("@click.outside present", l_div.to_html_8, "@click.outside=")
		end

	test_x_on_submit_prevent
			-- Test @submit.prevent.
		local
			l_form: ALPINE_FORM
		do
			create l_form.make
			l_form.x_on_submit_prevent ("handleSubmit()").do_nothing
			assert_has_substring ("@submit.prevent present", l_form.to_html_8, "@submit.prevent=")
		end

	test_x_on_input_debounce
			-- Test @input.debounce modifier.
		local
			l_input: ALPINE_INPUT
		do
			create l_input.make
			l_input.x_on_input_debounce ("search()", 300).do_nothing
			assert_has_substring ("@input.debounce present", l_input.to_html_8, "@input.debounce.300ms=")
		end

feature -- Test: Keyboard events

	test_x_on_keydown_escape
			-- Test @keydown.escape.
		local
			l_div: ALPINE_DIV
		do
			create l_div.make
			l_div.x_on_keydown_escape ("open = false").do_nothing
			assert_has_substring ("@keydown.escape present", l_div.to_html_8, "@keydown.escape=")
		end

	test_x_on_keydown_enter
			-- Test @keydown.enter.
		local
			l_input: ALPINE_INPUT
		do
			create l_input.make
			l_input.x_on_keydown_enter ("submit()").do_nothing
			assert_has_substring ("@keydown.enter present", l_input.to_html_8, "@keydown.enter=")
		end

feature -- Test: x-bind

	test_x_bind_class
			-- Test :class shorthand.
		local
			l_div: ALPINE_DIV
		do
			create l_div.make
			l_div.x_bind_class ("{ 'active': isActive }").do_nothing
			assert_has_substring (":class present", l_div.to_html_8, ":class=")
		end

	test_x_bind_style
			-- Test :style shorthand.
		local
			l_div: ALPINE_DIV
		do
			create l_div.make
			l_div.x_bind_style ("{ color: textColor }").do_nothing
			assert_has_substring (":style present", l_div.to_html_8, ":style=")
		end

	test_x_bind_disabled
			-- Test :disabled binding.
		local
			l_btn: ALPINE_BUTTON
		do
			create l_btn.make
			l_btn.x_bind_disabled ("isLoading").do_nothing
			assert_has_substring (":disabled present", l_btn.to_html_8, ":disabled=")
		end

	test_x_bind_aria
			-- Test :aria-* binding.
		local
			l_btn: ALPINE_BUTTON
		do
			create l_btn.make
			l_btn.x_bind_aria ("expanded", "open").do_nothing
			assert_has_substring (":aria-expanded present", l_btn.to_html_8, ":aria-expanded=")
		end

feature -- Test: x-model

	test_x_model
			-- Test basic x-model.
		local
			l_input: ALPINE_INPUT
		do
			create l_input.make
			l_input.x_model ("username").do_nothing
			assert_has_substring ("x-model present", l_input.to_html_8, "x-model=")
			assert_has_substring ("x-model value", l_input.to_html_8, "username")
		end

	test_x_model_lazy
			-- Test x-model.lazy modifier.
		local
			l_input: ALPINE_INPUT
		do
			create l_input.make
			l_input.x_model_lazy ("email").do_nothing
			assert_has_substring ("x-model.lazy present", l_input.to_html_8, "x-model.lazy=")
		end

	test_x_model_debounce
			-- Test x-model.debounce modifier.
		local
			l_input: ALPINE_INPUT
		do
			create l_input.make
			l_input.x_model_debounce ("search", 500).do_nothing
			assert_has_substring ("x-model.debounce present", l_input.to_html_8, "x-model.debounce.500ms=")
		end

feature -- Test: x-for

	test_x_for
			-- Test x-for loop directive.
		local
			l_template: ALPINE_TEMPLATE
		do
			create l_template.make
			l_template.x_for ("item in items").do_nothing
			assert_has_substring ("x-for present", l_template.to_html_8, "x-for=")
			assert_has_substring ("x-for value", l_template.to_html_8, "item in items")
		end

feature -- Test: x-ref

	test_x_ref
			-- Test x-ref directive.
		local
			l_input: ALPINE_INPUT
		do
			create l_input.make
			l_input.x_ref ("searchInput").do_nothing
			assert_has_substring ("x-ref present", l_input.to_html_8, "x-ref=")
			assert_has_substring ("x-ref value", l_input.to_html_8, "searchInput")
		end

feature -- Test: Transitions

	test_x_transition
			-- Test basic x-transition.
		local
			l_div: ALPINE_DIV
		do
			create l_div.make
			l_div.x_show ("open").x_transition.do_nothing
			assert_has_substring ("x-transition present", l_div.to_html_8, "x-transition")
		end

	test_x_transition_opacity
			-- Test x-transition.opacity.
		local
			l_div: ALPINE_DIV
		do
			create l_div.make
			l_div.x_show ("open").x_transition_opacity.do_nothing
			assert_has_substring ("x-transition.opacity present", l_div.to_html_8, "x-transition.opacity")
		end

	test_x_transition_scale_origin
			-- Test x-transition.scale.origin.
		local
			l_div: ALPINE_DIV
		do
			create l_div.make
			l_div.x_transition_scale_origin ("top").do_nothing
			assert_has_substring ("x-transition.scale.origin.top present", l_div.to_html_8, "x-transition.scale.origin.top")
		end

	test_x_transition_duration
			-- Test x-transition.duration.
		local
			l_div: ALPINE_DIV
		do
			create l_div.make
			l_div.x_transition_duration (200).do_nothing
			assert_has_substring ("x-transition.duration present", l_div.to_html_8, "x-transition.duration.200ms")
		end

feature -- Test: Plugins

	test_x_collapse
			-- Test x-collapse plugin directive.
		local
			l_div: ALPINE_DIV
		do
			create l_div.make
			l_div.x_show ("open").x_collapse.do_nothing
			assert_has_substring ("x-collapse present", l_div.to_html_8, "x-collapse")
		end

	test_x_trap
			-- Test x-trap plugin directive.
		local
			l_div: ALPINE_DIV
		do
			create l_div.make
			l_div.x_trap ("open").do_nothing
			assert_has_substring ("x-trap present", l_div.to_html_8, "x-trap=")
		end

	test_x_intersect
			-- Test x-intersect plugin directive.
		local
			l_div: ALPINE_DIV
		do
			create l_div.make
			l_div.x_intersect ("shown = true").do_nothing
			assert_has_substring ("x-intersect present", l_div.to_html_8, "x-intersect=")
		end

feature -- Test: Combined with HTMX

	test_alpine_and_htmx_together
			-- Test Alpine and HTMX attributes on same element.
		local
			l_btn: ALPINE_BUTTON
		do
			create l_btn.make
			l_btn.x_data ("{ loading: false }")
			    .x_on_click ("loading = true")
			    .x_bind_disabled ("loading")
			    .hx_post ("/api/submit")
			    .hx_target ("#result")
			    .text ("Submit").do_nothing
			-- Verify Alpine attributes
			assert_has_substring ("x-data present", l_btn.to_html_8, "x-data=")
			assert_has_substring ("@click present", l_btn.to_html_8, "@click=")
			assert_has_substring (":disabled present", l_btn.to_html_8, ":disabled=")
			-- Verify HTMX attributes
			assert_has_substring ("hx-post present", l_btn.to_html_8, "hx-post=")
			assert_has_substring ("hx-target present", l_btn.to_html_8, "hx-target=")
		end

feature {NONE} -- Implementation

	assert_has_substring (a_tag: STRING; a_string, a_substring: STRING)
			-- Assert that a_string contains a_substring.
		do
			assert (a_tag, a_string.has_substring (a_substring))
		end

end
