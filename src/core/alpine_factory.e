note
	description: "[
		Factory class for creating Alpine elements and common expression patterns.

		Provides:
		1. Element creation shortcuts (div, button, input, etc.)
		2. Expression builders (toggle, ternary, etc.)
		3. Pre-built component patterns (dark mode, dropdown, modal, etc.)

		Example:
			alpine: ALPINE_FACTORY
			...
			l_btn := alpine.button_text ("Toggle")
			         .x_data ("{ open: false }")
			         .x_on_click (alpine.toggle ("open"))
	]"
	author: "Larry Rix with Claude"
	date: "$Date$"
	revision: "$Revision$"

class
	ALPINE_FACTORY

feature -- Element Creation: Containers

	div: ALPINE_DIV
			-- Create a div element.
		do
			create Result.make
		end

	span: ALPINE_SPAN
			-- Create a span element.
		do
			create Result.make
		end

	section: ALPINE_SECTION
			-- Create a section element.
		do
			create Result.make
		end

	nav: ALPINE_NAV
			-- Create a nav element.
		do
			create Result.make
		end

	header: ALPINE_HEADER
			-- Create a header element.
		do
			create Result.make
		end

	footer: ALPINE_FOOTER
			-- Create a footer element.
		do
			create Result.make
		end

	main: ALPINE_MAIN
			-- Create a main element.
		do
			create Result.make
		end

	aside: ALPINE_ASIDE
			-- Create an aside element.
		do
			create Result.make
		end

	article: ALPINE_ARTICLE
			-- Create an article element.
		do
			create Result.make
		end

feature -- Element Creation: Headings

	h1: ALPINE_H1
			-- Create h1 element.
		do
			create Result.make
		end

	h1_text (a_text: READABLE_STRING_GENERAL): ALPINE_H1
			-- Create h1 with text.
		do
			create Result.make
			Result.text (a_text).do_nothing
		end

	h2: ALPINE_H2
			-- Create h2 element.
		do
			create Result.make
		end

	h2_text (a_text: READABLE_STRING_GENERAL): ALPINE_H2
			-- Create h2 with text.
		do
			create Result.make
			Result.text (a_text).do_nothing
		end

	h3: ALPINE_H3
			-- Create h3 element.
		do
			create Result.make
		end

	h3_text (a_text: READABLE_STRING_GENERAL): ALPINE_H3
			-- Create h3 with text.
		do
			create Result.make
			Result.text (a_text).do_nothing
		end

	p: ALPINE_P
			-- Create paragraph element.
		do
			create Result.make
		end

	p_text (a_text: READABLE_STRING_GENERAL): ALPINE_P
			-- Create paragraph with text.
		do
			create Result.make
			Result.text (a_text).do_nothing
		end

feature -- Element Creation: Forms

	form: ALPINE_FORM
			-- Create form element.
		do
			create Result.make
		end

	button: ALPINE_BUTTON
			-- Create button element.
		do
			create Result.make
		end

	button_text (a_text: READABLE_STRING_GENERAL): ALPINE_BUTTON
			-- Create button with text.
		do
			create Result.make
			Result.text (a_text).do_nothing
		end

	button_submit (a_text: READABLE_STRING_GENERAL): ALPINE_BUTTON
			-- Create submit button.
		do
			create Result.make
			Result.attr ("type", "submit").text (a_text).do_nothing
		end

	input: ALPINE_INPUT
			-- Create input element.
		do
			create Result.make
		end

	input_text (a_name: READABLE_STRING_GENERAL): ALPINE_INPUT
			-- Create text input with name.
		do
			create Result.make
			Result.attr ("type", "text").attr ("name", a_name.to_string_8).do_nothing
		end

	input_hidden (a_name, a_value: READABLE_STRING_GENERAL): ALPINE_INPUT
			-- Create hidden input.
		do
			create Result.make
			Result.attr ("type", "hidden").attr ("name", a_name.to_string_8).attr ("value", a_value.to_string_8).do_nothing
		end

	input_checkbox (a_name: READABLE_STRING_GENERAL): ALPINE_INPUT
			-- Create checkbox input.
		do
			create Result.make
			Result.attr ("type", "checkbox").attr ("name", a_name.to_string_8).do_nothing
		end

	input_radio (a_name: READABLE_STRING_GENERAL): ALPINE_INPUT
			-- Create radio input.
		do
			create Result.make
			Result.attr ("type", "radio").attr ("name", a_name.to_string_8).do_nothing
		end

	input_number (a_name: READABLE_STRING_GENERAL): ALPINE_INPUT
			-- Create number input.
		do
			create Result.make
			Result.attr ("type", "number").attr ("name", a_name.to_string_8).do_nothing
		end

	input_email (a_name: READABLE_STRING_GENERAL): ALPINE_INPUT
			-- Create email input.
		do
			create Result.make
			Result.attr ("type", "email").attr ("name", a_name.to_string_8).do_nothing
		end

	input_password (a_name: READABLE_STRING_GENERAL): ALPINE_INPUT
			-- Create password input.
		do
			create Result.make
			Result.attr ("type", "password").attr ("name", a_name.to_string_8).do_nothing
		end

	textarea (a_name: READABLE_STRING_GENERAL): ALPINE_TEXTAREA
			-- Create textarea with name.
		do
			create Result.make
			Result.attr ("name", a_name.to_string_8).do_nothing
		end

	select_ (a_name: READABLE_STRING_GENERAL): ALPINE_SELECT
			-- Create select with name.
		do
			create Result.make
			Result.attr ("name", a_name.to_string_8).do_nothing
		end

	option (a_value, a_text: READABLE_STRING_GENERAL): ALPINE_OPTION
			-- Create option with value and text.
		do
			create Result.make
			Result.attr ("value", a_value.to_string_8).text (a_text).do_nothing
		end

	label (a_text: READABLE_STRING_GENERAL): ALPINE_LABEL
			-- Create label with text.
		do
			create Result.make
			Result.text (a_text).do_nothing
		end

	label_for (a_for, a_text: READABLE_STRING_GENERAL): ALPINE_LABEL
			-- Create label with for attribute and text.
		do
			create Result.make
			Result.attr ("for", a_for.to_string_8).text (a_text).do_nothing
		end

feature -- Element Creation: Links and Media

	a_link (a_href, a_text: READABLE_STRING_GENERAL): ALPINE_A
			-- Create anchor with href and text.
		do
			create Result.make
			Result.attr ("href", a_href.to_string_8).text (a_text).do_nothing
		end

	img (a_src, a_alt: READABLE_STRING_GENERAL): ALPINE_IMG
			-- Create image with src and alt.
		do
			create Result.make
			Result.attr ("src", a_src.to_string_8).attr ("alt", a_alt.to_string_8).do_nothing
		end

feature -- Element Creation: Lists

	ul: ALPINE_UL
			-- Create unordered list.
		do
			create Result.make
		end

	ol: ALPINE_OL
			-- Create ordered list.
		do
			create Result.make
		end

	li: ALPINE_LI
			-- Create list item.
		do
			create Result.make
		end

	li_text (a_text: READABLE_STRING_GENERAL): ALPINE_LI
			-- Create list item with text.
		do
			create Result.make
			Result.text (a_text).do_nothing
		end

feature -- Element Creation: Template

	template: ALPINE_TEMPLATE
			-- Create template element (for x-if, x-for).
		do
			create Result.make
		end

feature -- Expression Builders: Toggle

	toggle (a_property: STRING): STRING
			-- Generate toggle expression.
			-- Example: toggle ("open") → "open = !open"
		do
			Result := a_property + " = !" + a_property
		end

	set_true (a_property: STRING): STRING
			-- Set property to true.
		do
			Result := a_property + " = true"
		end

	set_false (a_property: STRING): STRING
			-- Set property to false.
		do
			Result := a_property + " = false"
		end

	set_value (a_property, a_value: STRING): STRING
			-- Set property to value.
		do
			Result := a_property + " = " + a_value
		end

feature -- Expression Builders: Conditionals

	ternary (a_condition, a_true_value, a_false_value: STRING): STRING
			-- Generate ternary expression.
			-- Example: ternary ("open", "'block'", "'none'") → "open ? 'block' : 'none'"
		do
			Result := a_condition + " ? " + a_true_value + " : " + a_false_value
		end

	if_else (a_condition, a_true_value, a_false_value: STRING): STRING
			-- Alias for ternary.
		do
			Result := ternary (a_condition, a_true_value, a_false_value)
		end

feature -- Expression Builders: Class Binding

	class_if (a_class, a_condition: STRING): STRING
			-- Conditional class object.
			-- Example: class_if ("active", "isActive") → "{ 'active': isActive }"
		do
			Result := "{ '" + a_class + "': " + a_condition + " }"
		end

	class_multi (a_bindings: ARRAY [TUPLE [class_name: STRING; condition: STRING]]): STRING
			-- Multiple conditional classes.
			-- Example: class_multi (<<["active", "isActive"], ["hidden", "!isVisible"]>>)
			--          → "{ 'active': isActive, 'hidden': !isVisible }"
		local
			i: INTEGER
		do
			create Result.make_from_string ("{ ")
			from i := a_bindings.lower until i > a_bindings.upper loop
				if i > a_bindings.lower then
					Result.append (", ")
				end
				Result.append ("'")
				Result.append (a_bindings [i].class_name)
				Result.append ("': ")
				Result.append (a_bindings [i].condition)
				i := i + 1
			end
			Result.append (" }")
		end

feature -- Expression Builders: Data Object

	data_bool (a_name: STRING; a_value: BOOLEAN): STRING
			-- Boolean property.
		do
			Result := a_name + ": " + a_value.out.as_lower
		end

	data_string (a_name, a_value: STRING): STRING
			-- String property.
		do
			Result := a_name + ": '" + a_value + "'"
		end

	data_int (a_name: STRING; a_value: INTEGER): STRING
			-- Integer property.
		do
			Result := a_name + ": " + a_value.out
		end

	data_null (a_name: STRING): STRING
			-- Null property.
		do
			Result := a_name + ": null"
		end

	data_array (a_name: STRING; a_values: ARRAY [STRING]): STRING
			-- Array property.
		local
			i: INTEGER
		do
			Result := a_name + ": ["
			from i := a_values.lower until i > a_values.upper loop
				if i > a_values.lower then
					Result.append (", ")
				end
				Result.append (a_values [i])
				i := i + 1
			end
			Result.append ("]")
		end

	data_object (a_properties: ARRAY [STRING]): STRING
			-- Combine properties into x-data object.
			-- Example: data_object (<<data_bool ("open", false), data_int ("count", 0)>>)
			--          → "{ open: false, count: 0 }"
		local
			i: INTEGER
		do
			create Result.make_from_string ("{ ")
			from i := a_properties.lower until i > a_properties.upper loop
				if i > a_properties.lower then
					Result.append (", ")
				end
				Result.append (a_properties [i])
				i := i + 1
			end
			Result.append (" }")
		end

feature -- Magic Property Helpers

	el: STRING = "$el"
			-- Reference to current element.

	refs (a_name: STRING): STRING
			-- Reference to named element.
		do
			Result := "$refs." + a_name
		end

	store (a_name: STRING): STRING
			-- Reference to global store.
		do
			Result := "$store." + a_name
		end

	dispatch (a_event: STRING): STRING
			-- Dispatch custom event.
		do
			Result := "$dispatch('" + a_event + "')"
		end

	dispatch_with_data (a_event, a_data: STRING): STRING
			-- Dispatch event with data.
		do
			Result := "$dispatch('" + a_event + "', " + a_data + ")"
		end

	next_tick (a_expression: STRING): STRING
			-- Run expression after DOM update.
		do
			Result := "$nextTick(() => { " + a_expression + " })"
		end

	watch (a_property, a_callback: STRING): STRING
			-- Watch property for changes.
		do
			Result := "$watch('" + a_property + "', " + a_callback + ")"
		end

feature -- Pre-built Patterns: Dark Mode

	dark_mode_data: STRING
			-- Standard dark mode x-data.
			-- Checks localStorage, then system preference.
		do
			Result := "[
				{
					dark: localStorage.getItem('darkMode') === 'true' ||
					      (!localStorage.getItem('darkMode') &&
					       window.matchMedia('(prefers-color-scheme: dark)').matches)
				}
			]"
		end

	dark_mode_init: STRING
			-- Standard dark mode x-init.
			-- Watches dark property, updates localStorage and html class.
		do
			Result := "[
				$watch('dark', val => {
					localStorage.setItem('darkMode', val);
					document.documentElement.classList.toggle('dark', val)
				})
			]"
		end

	dark_mode_toggle_expression: STRING
			-- Expression to toggle dark mode.
		do
			Result := "dark = !dark"
		end

	dark_mode_icon_expression: STRING
			-- Ternary for showing sun/moon icon.
		do
			Result := "dark ? '☀️' : '🌙'"
		end

feature -- Pre-built Patterns: Dropdown

	dropdown_data: STRING
			-- Standard dropdown x-data.
		do
			Result := "{ open: false }"
		end

	dropdown_close: STRING
			-- Expression to close dropdown.
		do
			Result := "open = false"
		end

	dropdown_toggle: STRING
			-- Expression to toggle dropdown.
		do
			Result := "open = !open"
		end

feature -- Pre-built Patterns: Modal

	modal_data: STRING
			-- Standard modal x-data.
		do
			Result := "{ open: false }"
		end

	modal_open: STRING
			-- Expression to open modal.
		do
			Result := "open = true"
		end

	modal_close: STRING
			-- Expression to close modal.
		do
			Result := "open = false"
		end

feature -- Pre-built Patterns: Accordion

	accordion_data: STRING
			-- Standard accordion x-data (single open).
		do
			Result := "{ activeIndex: null }"
		end

	accordion_toggle (a_index: INTEGER): STRING
			-- Expression to toggle accordion item.
		do
			Result := "activeIndex = activeIndex === " + a_index.out + " ? null : " + a_index.out
		end

	accordion_is_open (a_index: INTEGER): STRING
			-- Expression to check if accordion item is open.
		do
			Result := "activeIndex === " + a_index.out
		end

feature -- Pre-built Patterns: Tabs

	tabs_data (a_default_tab: STRING): STRING
			-- Standard tabs x-data.
		do
			Result := "{ activeTab: '" + a_default_tab + "' }"
		end

	tabs_select (a_tab: STRING): STRING
			-- Expression to select a tab.
		do
			Result := "activeTab = '" + a_tab + "'"
		end

	tabs_is_active (a_tab: STRING): STRING
			-- Expression to check if tab is active.
		do
			Result := "activeTab === '" + a_tab + "'"
		end

feature -- Pre-built Patterns: Counter

	counter_data (a_initial: INTEGER): STRING
			-- Counter x-data with initial value.
		do
			Result := "{ count: " + a_initial.out + " }"
		end

	counter_increment: STRING
			-- Expression to increment counter.
		do
			Result := "count++"
		end

	counter_decrement: STRING
			-- Expression to decrement counter.
		do
			Result := "count--"
		end

	counter_reset: STRING
			-- Expression to reset counter.
		do
			Result := "count = 0"
		end

feature -- Pre-built Patterns: Loading State

	loading_data: STRING
			-- Loading state x-data.
		do
			Result := "{ loading: false }"
		end

	loading_start: STRING
			-- Expression to start loading.
		do
			Result := "loading = true"
		end

	loading_stop: STRING
			-- Expression to stop loading.
		do
			Result := "loading = false"
		end

end
