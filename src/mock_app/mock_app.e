note
	description: "[
		Mock application to exercise simple_alpine API.

		Generates an HTML page with:
		- Dark mode toggle
		- Dropdown menu
		- Modal dialog
		- Tabs component
		- Accordion
		- Counter
		- HTMX + Alpine combo
		- Form with x-model bindings
		- Dynamic list with x-for
		- Element references with x-ref
		- Intersection observer with x-intersect
		- Custom events with $dispatch
		- Navigation with semantic elements

		Purpose: Validate API usability and discover friction points.
	]"
	author: "Larry Rix with Claude"

class
	MOCK_APP

create
	make

feature {NONE} -- Initialization

	make
			-- Run mock application.
		local
			l_file: PLAIN_TEXT_FILE
			l_html: STRING
		do
			create alpine
			l_html := build_full_page

			-- Write to index.html
			create l_file.make_open_write ("index.html")
			l_file.put_string (l_html)
			l_file.close

			print ("Generated index.html (" + l_html.count.out + " bytes)%N")
			print ("Open in browser: index.html%N")
		end

feature -- Components

	build_dark_mode_toggle: STRING
			-- Dark mode toggle button.
		local
			l_container: ALPINE_DIV
			l_btn: ALPINE_BUTTON
		do
			l_btn := alpine.button
			l_btn.x_on_click (alpine.dark_mode_toggle_expression)
			    .x_bind_class (alpine.class_if ("dark:bg-gray-800", "dark"))
			    .class_ ("px-4 py-2 rounded")
			    .x_text (alpine.dark_mode_icon_expression).do_nothing

			l_container := alpine.div
			l_container.x_data (alpine.dark_mode_data)
			    .x_init (alpine.dark_mode_init)
			    .x_effect (alpine.dark_mode_watch)
			    .containing (l_btn).do_nothing

			Result := l_container.to_html_8
		end

	build_dropdown_menu: STRING
			-- Dropdown menu with click-outside close.
		local
			l_container, l_menu, l_item1, l_item2, l_item3: ALPINE_DIV
			l_btn: ALPINE_BUTTON
		do
			-- Button to toggle
			l_btn := alpine.button_text ("Menu")
			l_btn.x_on_click (alpine.dropdown_toggle)
			    .class_ ("px-4 py-2 bg-blue-500 text-white rounded").do_nothing

			-- Menu items
			l_item1 := alpine.div
			l_item1.class_ ("px-4 py-2 hover:bg-gray-100 cursor-pointer")
			    .text ("Profile").do_nothing
			l_item2 := alpine.div
			l_item2.class_ ("px-4 py-2 hover:bg-gray-100 cursor-pointer")
			    .text ("Settings").do_nothing
			l_item3 := alpine.div
			l_item3.class_ ("px-4 py-2 hover:bg-gray-100 cursor-pointer")
			    .text ("Logout").do_nothing

			-- Dropdown panel
			l_menu := alpine.div
			l_menu.x_show ("open")
			    .x_on_click_outside (alpine.dropdown_close)
			    .x_on_keydown_escape (alpine.dropdown_close)
			    .x_transition
			    .class_ ("absolute mt-2 w-48 bg-white rounded shadow-lg")
			    .containing (l_item1)
			    .containing (l_item2)
			    .containing (l_item3).do_nothing

			-- Container
			l_container := alpine.div
			l_container.x_data (alpine.dropdown_data)
			    .class_ ("relative inline-block")
			    .containing (l_btn)
			    .containing (l_menu).do_nothing

			Result := l_container.to_html_8
		end

	build_modal_dialog: STRING
			-- Modal dialog with backdrop and focus trap.
		local
			l_container, l_backdrop, l_modal_content, l_header, l_body, l_footer: ALPINE_DIV
			l_open_btn, l_close_btn: ALPINE_BUTTON
		do
			-- Open button
			l_open_btn := alpine.button_text ("Open Modal")
			l_open_btn.x_on_click (alpine.modal_open)
			    .class_ ("px-4 py-2 bg-green-500 text-white rounded").do_nothing

			-- Modal header
			l_header := alpine.div
			l_header.class_ ("text-xl font-bold mb-4")
			    .text ("Modal Title").do_nothing

			-- Modal body
			l_body := alpine.div
			l_body.class_ ("mb-4")
			    .text ("This is the modal content. It can contain any HTML.").do_nothing

			-- Close button
			l_close_btn := alpine.button_text ("Close")
			l_close_btn.x_on_click (alpine.modal_close)
			    .class_ ("px-4 py-2 bg-gray-500 text-white rounded").do_nothing

			-- Modal footer
			l_footer := alpine.div
			l_footer.class_ ("flex justify-end")
			    .containing (l_close_btn).do_nothing

			-- Modal content box
			l_modal_content := alpine.div
			l_modal_content.x_on_click_stop ("") -- Prevent click from closing
			    .x_trap ("open")
			    .class_ ("bg-white p-6 rounded-lg shadow-xl max-w-md mx-auto")
			    .containing (l_header)
			    .containing (l_body)
			    .containing (l_footer).do_nothing

			-- Backdrop
			l_backdrop := alpine.div
			l_backdrop.x_show ("open")
			    .x_on_click (alpine.modal_close)
			    .x_on_keydown_escape (alpine.modal_close)
			    .x_transition_opacity
			    .class_ ("fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center")
			    .containing (l_modal_content).do_nothing

			-- Container
			l_container := alpine.div
			l_container.x_data (alpine.modal_data)
			    .containing (l_open_btn)
			    .containing (l_backdrop).do_nothing

			Result := l_container.to_html_8
		end

	build_tabs_component: STRING
			-- Tabs with content panels.
		local
			l_container, l_tab_list, l_panel1, l_panel2, l_panel3: ALPINE_DIV
			l_tab1, l_tab2, l_tab3: ALPINE_BUTTON
		do
			-- Tab buttons
			l_tab1 := alpine.button_text ("Home")
			l_tab1.x_on_click (alpine.tabs_select ("home"))
			    .x_bind_class (alpine.class_if ("border-b-2 border-blue-500", alpine.tabs_is_active ("home")))
			    .class_ ("px-4 py-2").do_nothing

			l_tab2 := alpine.button_text ("Profile")
			l_tab2.x_on_click (alpine.tabs_select ("profile"))
			    .x_bind_class (alpine.class_if ("border-b-2 border-blue-500", alpine.tabs_is_active ("profile")))
			    .class_ ("px-4 py-2").do_nothing

			l_tab3 := alpine.button_text ("Settings")
			l_tab3.x_on_click (alpine.tabs_select ("settings"))
			    .x_bind_class (alpine.class_if ("border-b-2 border-blue-500", alpine.tabs_is_active ("settings")))
			    .class_ ("px-4 py-2").do_nothing

			-- Tab list
			l_tab_list := alpine.div
			l_tab_list.class_ ("flex border-b")
			    .containing (l_tab1)
			    .containing (l_tab2)
			    .containing (l_tab3).do_nothing

			-- Panels
			l_panel1 := alpine.div
			l_panel1.x_show (alpine.tabs_is_active ("home"))
			    .class_ ("p-4")
			    .text ("Welcome to the home tab!").do_nothing

			l_panel2 := alpine.div
			l_panel2.x_show (alpine.tabs_is_active ("profile"))
			    .class_ ("p-4")
			    .text ("This is your profile information.").do_nothing

			l_panel3 := alpine.div
			l_panel3.x_show (alpine.tabs_is_active ("settings"))
			    .class_ ("p-4")
			    .text ("Configure your settings here.").do_nothing

			-- Container
			l_container := alpine.div
			l_container.x_data (alpine.tabs_data ("home"))
			    .containing (l_tab_list)
			    .containing (l_panel1)
			    .containing (l_panel2)
			    .containing (l_panel3).do_nothing

			Result := l_container.to_html_8
		end

	build_accordion: STRING
			-- Accordion with collapsible sections.
		local
			l_container, l_section1, l_section2, l_header1, l_header2, l_content1, l_content2: ALPINE_DIV
			l_btn1, l_btn2: ALPINE_BUTTON
		do
			-- Section 1 header
			l_btn1 := alpine.button_text ("Section 1")
			l_btn1.x_on_click (alpine.accordion_toggle (0))
			    .class_ ("w-full text-left px-4 py-2 bg-gray-200").do_nothing
			l_header1 := alpine.div
			l_header1.containing (l_btn1).do_nothing

			-- Section 1 content
			l_content1 := alpine.div
			l_content1.x_show (alpine.accordion_is_open (0))
			    .x_collapse
			    .class_ ("px-4 py-2")
			    .text ("Content for section 1. This collapses smoothly.").do_nothing

			l_section1 := alpine.div
			l_section1.class_ ("border-b")
			    .containing (l_header1)
			    .containing (l_content1).do_nothing

			-- Section 2 header
			l_btn2 := alpine.button_text ("Section 2")
			l_btn2.x_on_click (alpine.accordion_toggle (1))
			    .class_ ("w-full text-left px-4 py-2 bg-gray-200").do_nothing
			l_header2 := alpine.div
			l_header2.containing (l_btn2).do_nothing

			-- Section 2 content
			l_content2 := alpine.div
			l_content2.x_show (alpine.accordion_is_open (1))
			    .x_collapse
			    .class_ ("px-4 py-2")
			    .text ("Content for section 2. Also collapses smoothly.").do_nothing

			l_section2 := alpine.div
			l_section2.class_ ("border-b")
			    .containing (l_header2)
			    .containing (l_content2).do_nothing

			-- Container
			l_container := alpine.div
			l_container.x_data (alpine.accordion_data)
			    .class_ ("border rounded")
			    .containing (l_section1)
			    .containing (l_section2).do_nothing

			Result := l_container.to_html_8
		end

	build_counter: STRING
			-- Simple counter with increment/decrement.
		local
			l_container: ALPINE_DIV
			l_display: ALPINE_SPAN
			l_dec_btn, l_inc_btn: ALPINE_BUTTON
		do
			-- Decrement button
			l_dec_btn := alpine.button_text ("-")
			l_dec_btn.x_on_click (alpine.counter_decrement)
			    .class_ ("px-3 py-1 bg-red-500 text-white rounded").do_nothing

			-- Display
			l_display := alpine.span
			l_display.x_text ("count")
			    .class_ ("px-4 text-xl font-bold").do_nothing

			-- Increment button
			l_inc_btn := alpine.button_text ("+")
			l_inc_btn.x_on_click (alpine.counter_increment)
			    .class_ ("px-3 py-1 bg-green-500 text-white rounded").do_nothing

			-- Container
			l_container := alpine.div
			l_container.x_data (alpine.counter_data (0))
			    .class_ ("flex items-center gap-2")
			    .containing (l_dec_btn)
			    .containing (l_display)
			    .containing (l_inc_btn).do_nothing

			Result := l_container.to_html_8
		end

	build_htmx_alpine_combo: STRING
			-- Combined HTMX and Alpine example.
		local
			l_btn: ALPINE_BUTTON
		do
			-- Button that uses Alpine for loading state and HTMX for server request
			l_btn := alpine.button_text ("Load Data")
			l_btn.x_data (alpine.loading_data)
			    .x_on_click (alpine.loading_start)
			    .x_bind_disabled ("loading")
			    .x_bind_class (alpine.class_if ("opacity-50 cursor-wait", "loading"))
			    -- HTMX attributes
			    .hx_get ("/api/data")
			    .hx_target ("#result")
			    .hx_swap_inner_html
			    .attr ("hx-on::after-request", alpine.loading_stop)
			    .class_ ("px-4 py-2 bg-blue-500 text-white rounded").do_nothing

			Result := l_btn.to_html_8
		end

	build_form_demo: STRING
			-- Form with x-model two-way binding.
		local
			l_container, l_output: ALPINE_DIV
			l_form: ALPINE_FORM
			l_name_input, l_email_input, l_age_input: ALPINE_INPUT
			l_name_label, l_email_label, l_age_label, l_newsletter_label, l_country_label: ALPINE_LABEL
			l_newsletter_input: ALPINE_INPUT
			l_country_select: ALPINE_SELECT
			l_opt1, l_opt2, l_opt3: ALPINE_OPTION
			l_textarea: ALPINE_TEXTAREA
			l_bio_label: ALPINE_LABEL
			l_submit_btn: ALPINE_BUTTON
		do
			-- Name field with x-model
			l_name_label := alpine.label ("Name:")
			l_name_label.class_ ("block text-sm font-medium mb-1").do_nothing
			l_name_input := alpine.input_text ("name")
			l_name_input.x_model ("name")
			    .class_ ("w-full border rounded px-3 py-2 mb-3").do_nothing

			-- Email field with x-model.lazy
			l_email_label := alpine.label ("Email (lazy):")
			l_email_label.class_ ("block text-sm font-medium mb-1").do_nothing
			l_email_input := alpine.input_email ("email")
			l_email_input.x_model_lazy ("email")
			    .class_ ("w-full border rounded px-3 py-2 mb-3").do_nothing

			-- Age with x-model.number
			l_age_label := alpine.label ("Age (number):")
			l_age_label.class_ ("block text-sm font-medium mb-1").do_nothing
			l_age_input := alpine.input_number ("age")
			l_age_input.x_model_number ("age")
			    .class_ ("w-full border rounded px-3 py-2 mb-3").do_nothing

			-- Newsletter checkbox
			l_newsletter_label := alpine.label ("")
			l_newsletter_label.class_ ("flex items-center gap-2 mb-3").do_nothing
			l_newsletter_input := alpine.input_checkbox ("newsletter")
			l_newsletter_input.x_model ("newsletter")
			    .class_ ("w-4 h-4").do_nothing
			l_newsletter_label.containing (l_newsletter_input).raw_html (" Subscribe to newsletter").do_nothing

			-- Country select
			l_country_label := alpine.label ("Country:")
			l_country_label.class_ ("block text-sm font-medium mb-1").do_nothing
			l_opt1 := alpine.option ("us", "United States")
			l_opt2 := alpine.option ("uk", "United Kingdom")
			l_opt3 := alpine.option ("ca", "Canada")
			l_country_select := alpine.select_ ("country")
			l_country_select.x_model ("country")
			    .class_ ("w-full border rounded px-3 py-2 mb-3")
			    .containing (l_opt1).containing (l_opt2).containing (l_opt3).do_nothing

			-- Bio textarea with debounce
			l_bio_label := alpine.label ("Bio (debounce 500ms):")
			l_bio_label.class_ ("block text-sm font-medium mb-1").do_nothing
			l_textarea := alpine.textarea ("bio")
			l_textarea.x_model_debounce ("bio", 500)
			    .attr ("rows", "3")
			    .class_ ("w-full border rounded px-3 py-2 mb-3").do_nothing

			-- Submit button
			l_submit_btn := alpine.button_text ("Submit")
			l_submit_btn.attr ("type", "button")
			    .x_on_click ("alert('Form data: ' + JSON.stringify({name, email, age, newsletter, country, bio}))")
			    .class_ ("px-4 py-2 bg-blue-500 text-white rounded").do_nothing

			-- Form
			l_form := alpine.form
			l_form.x_on_submit_prevent ("")
			    .containing (l_name_label).containing (l_name_input)
			    .containing (l_email_label).containing (l_email_input)
			    .containing (l_age_label).containing (l_age_input)
			    .containing (l_newsletter_label)
			    .containing (l_country_label).containing (l_country_select)
			    .containing (l_bio_label).containing (l_textarea)
			    .containing (l_submit_btn).do_nothing

			-- Output display showing bound values
			l_output := alpine.div
			l_output.class_ ("mt-4 p-3 bg-gray-100 rounded text-sm")
			    .x_cloak.do_nothing
			l_output.raw_html ("<strong>Live Preview:</strong><br>").do_nothing
			l_output.raw_html ("<span x-text=%"'Name: ' + name%"></span><br>").do_nothing
			l_output.raw_html ("<span x-text=%"'Email: ' + email%"></span><br>").do_nothing
			l_output.raw_html ("<span x-text=%"'Age: ' + age + ' (type: ' + typeof age + ')'%"></span><br>").do_nothing
			l_output.raw_html ("<span x-text=%"'Newsletter: ' + newsletter%"></span><br>").do_nothing
			l_output.raw_html ("<span x-text=%"'Country: ' + country%"></span><br>").do_nothing
			l_output.raw_html ("<span x-text=%"'Bio: ' + bio%"></span>").do_nothing

			-- Container with x-data
			l_container := alpine.div
			l_container.x_data ("{ name: '', email: '', age: 0, newsletter: false, country: 'us', bio: '' }")
			    .class_ ("max-w-md")
			    .containing (l_form)
			    .containing (l_output).do_nothing

			Result := l_container.to_html_8
		end

	build_dynamic_list: STRING
			-- Dynamic list with x-for and template.
		local
			l_container, l_list_div, l_item_div: ALPINE_DIV
			l_template: ALPINE_TEMPLATE
			l_input: ALPINE_INPUT
			l_add_btn, l_remove_btn: ALPINE_BUTTON
		do
			-- Input for new item
			l_input := alpine.input_text ("newItem")
			l_input.x_model ("newItem")
			    .x_on_keydown_enter ("if(newItem.trim()) { items.push(newItem.trim()); newItem = '' }")
			    .attr ("placeholder", "Enter item and press Enter")
			    .class_ ("border rounded px-3 py-2 mr-2").do_nothing

			-- Add button
			l_add_btn := alpine.button_text ("Add")
			l_add_btn.x_on_click ("if(newItem.trim()) { items.push(newItem.trim()); newItem = '' }")
			    .class_ ("px-4 py-2 bg-green-500 text-white rounded").do_nothing

			-- Item template with x-for
			l_remove_btn := alpine.button_text ("×")
			l_remove_btn.x_on_click ("items.splice(index, 1)")
			    .class_ ("ml-2 text-red-500 hover:text-red-700").do_nothing

			l_item_div := alpine.div
			l_item_div.class_ ("flex items-center justify-between p-2 bg-gray-50 rounded mb-1")
			    .x_bind ("key", "index").do_nothing
			l_item_div.raw_html ("<span x-text=%"item%"></span>").do_nothing
			l_item_div.containing (l_remove_btn).do_nothing

			l_template := alpine.template
			l_template.x_for ("(item, index) in items")
			    .containing (l_item_div).do_nothing

			-- List container
			l_list_div := alpine.div
			l_list_div.class_ ("mt-4")
			    .containing (l_template).do_nothing

			-- Empty state with x-show
			l_list_div.raw_html ("<div x-show=%"items.length === 0%" class=%"text-gray-500 italic%">No items yet. Add one above!</div>").do_nothing

			-- Item count
			l_list_div.raw_html ("<div x-show=%"items.length > 0%" class=%"mt-2 text-sm text-gray-600%" x-text=%"items.length + ' item(s)'%"></div>").do_nothing

			-- Main container
			l_container := alpine.div
			l_container.x_data ("{ items: ['First item', 'Second item'], newItem: '' }")
			    .containing (l_input)
			    .containing (l_add_btn)
			    .containing (l_list_div).do_nothing

			Result := l_container.to_html_8
		end

	build_refs_demo: STRING
			-- Element references with x-ref.
		local
			l_container, l_output: ALPINE_DIV
			l_input: ALPINE_INPUT
			l_focus_btn, l_select_btn, l_clear_btn: ALPINE_BUTTON
		do
			-- Input with x-ref
			l_input := alpine.input_text ("refDemo")
			l_input.x_ref ("myInput")
			    .attr ("placeholder", "Click buttons to interact with me")
			    .class_ ("border rounded px-3 py-2 mr-2 w-64").do_nothing

			-- Focus button using $refs
			l_focus_btn := alpine.button_text ("Focus")
			l_focus_btn.x_on_click (alpine.refs ("myInput") + ".focus()")
			    .class_ ("px-3 py-2 bg-blue-500 text-white rounded mr-2").do_nothing

			-- Select all button
			l_select_btn := alpine.button_text ("Select All")
			l_select_btn.x_on_click (alpine.refs ("myInput") + ".select()")
			    .class_ ("px-3 py-2 bg-purple-500 text-white rounded mr-2").do_nothing

			-- Clear button
			l_clear_btn := alpine.button_text ("Clear")
			l_clear_btn.x_on_click (alpine.refs ("myInput") + ".value = ''")
			    .class_ ("px-3 py-2 bg-red-500 text-white rounded").do_nothing

			-- Output showing $el usage
			l_output := alpine.div
			l_output.class_ ("mt-4 p-3 bg-gray-100 rounded text-sm")
			    .x_data_empty
			    .x_init ("console.log('Output element:', " + alpine.el + ")")
			    .text ("Check console for $el reference log").do_nothing

			-- Container
			l_container := alpine.div
			l_container.x_data_empty
			    .containing (l_input)
			    .containing (l_focus_btn)
			    .containing (l_select_btn)
			    .containing (l_clear_btn)
			    .containing (l_output).do_nothing

			Result := l_container.to_html_8
		end

	build_intersect_demo: STRING
			-- Intersection observer with x-intersect.
		local
			l_container, l_box1, l_box2, l_box3, l_spacer: ALPINE_DIV
		do
			-- Spacer to force scrolling
			l_spacer := alpine.div
			l_spacer.class_ ("h-32 flex items-center justify-center text-gray-400")
			    .text ("↓ Scroll down to see intersection observer in action ↓").do_nothing

			-- Box 1: x-intersect:enter (animate once when entering)
			l_box1 := alpine.div
			l_box1.x_data ("{ visible: false }")
			    .x_intersect_enter ("visible = true")
			    .x_bind_class ("{ 'opacity-100 translate-y-0': visible, 'opacity-0 translate-y-8': !visible }")
			    .class_ ("p-6 bg-blue-500 text-white rounded transition-all duration-500 mb-4")
			    .text ("x-intersect:enter - I animate when entering viewport").do_nothing

			-- Box 2: x-intersect.once (only trigger once)
			l_box2 := alpine.div
			l_box2.x_data ("{ loaded: false }")
			    .x_intersect_once ("loaded = true; console.log('Loaded once!')")
			    .class_ ("p-6 bg-green-500 text-white rounded mb-4").do_nothing
			l_box2.raw_html ("<span x-text=%"loaded ? 'x-intersect.once - Loaded! (check console)' : 'x-intersect.once - Waiting...'%"></span>").do_nothing

			-- Box 3: x-intersect:leave (detect leaving)
			l_box3 := alpine.div
			l_box3.x_data ("{ inView: false }")
			    .x_intersect_enter ("inView = true")
			    .x_intersect_leave ("inView = false")
			    .x_bind_class ("{ 'bg-purple-500': inView, 'bg-gray-400': !inView }")
			    .class_ ("p-6 text-white rounded transition-colors duration-300").do_nothing
			l_box3.raw_html ("<span x-text=%"inView ? 'x-intersect:enter/leave - IN VIEW' : 'x-intersect:enter/leave - OUT OF VIEW'%"></span>").do_nothing

			-- Container
			l_container := alpine.div
			l_container.containing (l_spacer)
			    .containing (l_box1)
			    .containing (l_box2)
			    .containing (l_box3).do_nothing

			Result := l_container.to_html_8
		end

	build_dispatch_demo: STRING
			-- Custom events with $dispatch.
		local
			l_container, l_sender, l_receiver, l_log_area: ALPINE_DIV
			l_simple_btn, l_data_btn, l_clear_btn: ALPINE_BUTTON
		do
			-- Simple dispatch button
			l_simple_btn := alpine.button_text ("Send Simple Event")
			l_simple_btn.x_on_click (alpine.dispatch ("custom-event"))
			    .class_ ("px-4 py-2 bg-blue-500 text-white rounded mr-2").do_nothing

			-- Dispatch with data button
			l_data_btn := alpine.button_text ("Send Event with Data")
			l_data_btn.x_on_click (alpine.dispatch_with_data ("data-event", "{ message: 'Hello!', timestamp: Date.now() }"))
			    .class_ ("px-4 py-2 bg-green-500 text-white rounded mr-2").do_nothing

			-- Clear button
			l_clear_btn := alpine.button_text ("Clear Log")
			l_clear_btn.x_on_click ("log = []")
			    .class_ ("px-4 py-2 bg-gray-500 text-white rounded").do_nothing

			-- Sender area
			l_sender := alpine.div
			l_sender.class_ ("mb-4")
			    .containing (l_simple_btn)
			    .containing (l_data_btn)
			    .containing (l_clear_btn).do_nothing

			-- Receiver/log area with event listeners
			l_log_area := alpine.div
			l_log_area.class_ ("p-4 bg-gray-100 rounded min-h-24").do_nothing
			l_log_area.raw_html ("<div x-show=%"log.length === 0%" class=%"text-gray-500 italic%">Event log empty. Click buttons above.</div>").do_nothing
			l_log_area.raw_html ("<template x-for=%"(entry, i) in log%" :key=%"i%"><div class=%"text-sm mb-1%" x-text=%"entry%"></div></template>").do_nothing

			l_receiver := alpine.div
			l_receiver.x_on ("custom-event", "log.push('Received: custom-event at ' + new Date().toLocaleTimeString())")
			    .x_on ("data-event", "log.push('Received: data-event - ' + JSON.stringify($event.detail))")
			    .containing (l_log_area).do_nothing

			-- Container
			l_container := alpine.div
			l_container.x_data ("{ log: [] }")
			    .containing (l_sender)
			    .containing (l_receiver).do_nothing

			Result := l_container.to_html_8
		end

	build_navigation: STRING
			-- Navigation using semantic elements.
		local
			l_nav: ALPINE_NAV
			l_ul: ALPINE_UL
			l_li1, l_li2, l_li3, l_li4: ALPINE_LI
			l_a1, l_a2, l_a3, l_a4: ALPINE_A
		do
			-- Nav links
			l_a1 := alpine.a_link ("#", "Home")
			l_a1.x_bind_href ("'#' + currentPage")
			    .x_bind_class ("{ 'font-bold text-blue-600': currentPage === 'home', 'text-gray-600 hover:text-blue-500': currentPage !== 'home' }")
			    .x_on_click_prevent ("currentPage = 'home'").do_nothing
			l_li1 := alpine.li
			l_li1.containing (l_a1).do_nothing

			l_a2 := alpine.a_link ("#", "About")
			l_a2.x_bind_href ("'#' + currentPage")
			    .x_bind_class ("{ 'font-bold text-blue-600': currentPage === 'about', 'text-gray-600 hover:text-blue-500': currentPage !== 'about' }")
			    .x_on_click_prevent ("currentPage = 'about'").do_nothing
			l_li2 := alpine.li
			l_li2.containing (l_a2).do_nothing

			l_a3 := alpine.a_link ("#", "Services")
			l_a3.x_bind_href ("'#' + currentPage")
			    .x_bind_class ("{ 'font-bold text-blue-600': currentPage === 'services', 'text-gray-600 hover:text-blue-500': currentPage !== 'services' }")
			    .x_on_click_prevent ("currentPage = 'services'").do_nothing
			l_li3 := alpine.li
			l_li3.containing (l_a3).do_nothing

			l_a4 := alpine.a_link ("#", "Contact")
			l_a4.x_bind_href ("'#' + currentPage")
			    .x_bind_class ("{ 'font-bold text-blue-600': currentPage === 'contact', 'text-gray-600 hover:text-blue-500': currentPage !== 'contact' }")
			    .x_on_click_prevent ("currentPage = 'contact'").do_nothing
			l_li4 := alpine.li
			l_li4.containing (l_a4).do_nothing

			-- List
			l_ul := alpine.ul
			l_ul.class_ ("flex gap-6")
			    .containing (l_li1)
			    .containing (l_li2)
			    .containing (l_li3)
			    .containing (l_li4).do_nothing

			-- Nav with current page indicator
			l_nav := alpine.nav
			l_nav.x_data ("{ currentPage: 'home' }")
			    .class_ ("p-4 bg-gray-50 rounded")
			    .attr ("aria-label", "Main navigation")
			    .containing (l_ul).do_nothing

			-- Add current page display
			l_nav.raw_html ("<div class=%"mt-3 text-sm text-gray-600%" x-text=%"'Current page: ' + currentPage%"></div>").do_nothing

			Result := l_nav.to_html_8
		end

	build_full_page: STRING
			-- Generate a complete HTML page with all components.
		do
			Result := "[
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>simple_alpine Mock App</title>
    <script defer src="https://cdn.jsdelivr.net/npm/@alpinejs/collapse@3.x.x/dist/cdn.min.js"></script>
    <script defer src="https://cdn.jsdelivr.net/npm/@alpinejs/focus@3.x.x/dist/cdn.min.js"></script>
    <script defer src="https://cdn.jsdelivr.net/npm/@alpinejs/intersect@3.x.x/dist/cdn.min.js"></script>
    <script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>
    <script src="https://unpkg.com/htmx.org@1.9.10"></script>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        [x-cloak] { display: none !important; }
        .dark-mode { background-color: #1a202c; color: #f7fafc; }
        .dark-mode .modal-content { background-color: #2d3748; color: #f7fafc; }
        .dark-mode .bg-gray-200 { background-color: #4a5568; color: #f7fafc; }
        .dark-mode .bg-white { background-color: #2d3748; color: #f7fafc; }
        .dark-mode .hover\:bg-gray-100:hover { background-color: #4a5568; }
        .dark-mode .border { border-color: #4a5568; }
        /* Dark mode for info boxes */
        .dark-mode .bg-blue-50 { background-color: #1e3a5f; }
        .dark-mode .border-blue-400 { border-color: #60a5fa; }
        .dark-mode .text-blue-800 { color: #93c5fd; }
        .dark-mode .text-blue-700 { color: #bfdbfe; }
        .dark-mode .text-blue-600 { color: #93c5fd; }
        /* Dark mode for gray text */
        .dark-mode .text-gray-600 { color: #9ca3af; }
        .dark-mode .text-gray-500 { color: #9ca3af; }
        /* Dark mode for form elements */
        .dark-mode .bg-gray-100 { background-color: #374151; color: #f3f4f6; }
        .dark-mode .bg-gray-50 { background-color: #374151; color: #f3f4f6; }
        .dark-mode input, .dark-mode select, .dark-mode textarea {
            background-color: #374151;
            color: #f3f4f6;
            border-color: #4b5563;
        }
    </style>
</head>
<body class="p-8 transition-colors duration-200" x-data="{ dark: false }" x-init="dark = localStorage.getItem('darkMode') === 'true'" x-effect="localStorage.setItem('darkMode', dark)" :class="{ 'dark-mode': dark }">
    <h1 class="text-3xl font-bold mb-2">simple_alpine Components</h1>
    <p class="text-gray-600 mb-8">Interactive demonstrations of Alpine.js directives generated by the simple_alpine Eiffel library.</p>

    <section class="mb-10 p-6 border rounded-lg">
        <h2 class="text-xl font-semibold mb-2">1. Dark Mode Toggle</h2>
        <div class="bg-blue-50 border-l-4 border-blue-400 p-4 mb-4">
            <p class="font-medium text-blue-800">What to expect:</p>
            <ul class="list-disc ml-6 text-blue-700 text-sm mt-1">
                <li>Click the button to toggle between light and dark mode</li>
                <li>The entire page background and text colors will change</li>
                <li>Your preference is saved to localStorage and persists on refresh</li>
            </ul>
            <p class="text-xs text-blue-600 mt-2"><strong>Directives used:</strong> x-data, x-init, x-effect, @click, x-text, :class</p>
        </div>
        <button class="px-4 py-2 rounded bg-gray-200" @click="dark = !dark" x-text="dark ? 'Switch to Light' : 'Switch to Dark'"></button>
    </section>

    <section class="mb-10 p-6 border rounded-lg">
        <h2 class="text-xl font-semibold mb-2">2. Dropdown Menu</h2>
        <div class="bg-blue-50 border-l-4 border-blue-400 p-4 mb-4">
            <p class="font-medium text-blue-800">What to expect:</p>
            <ul class="list-disc ml-6 text-blue-700 text-sm mt-1">
                <li>Click "Menu" to open a dropdown with three options</li>
                <li>Click outside the menu to close it</li>
                <li>Press Escape key to close it</li>
                <li>The menu animates in/out with x-transition</li>
            </ul>
            <p class="text-xs text-blue-600 mt-2"><strong>Directives used:</strong> x-data, x-show, @click, @click.outside, @keydown.escape, x-transition</p>
        </div>
]" + build_dropdown_menu + "[
    </section>

    <section class="mb-10 p-6 border rounded-lg">
        <h2 class="text-xl font-semibold mb-2">3. Modal Dialog</h2>
        <div class="bg-blue-50 border-l-4 border-blue-400 p-4 mb-4">
            <p class="font-medium text-blue-800">What to expect:</p>
            <ul class="list-disc ml-6 text-blue-700 text-sm mt-1">
                <li>Click "Open Modal" to show a centered dialog with backdrop</li>
                <li>Focus is trapped inside the modal (Tab cycles through modal elements only)</li>
                <li>Click the backdrop or Close button to dismiss</li>
                <li>Press Escape to close</li>
                <li>Backdrop fades in/out with opacity transition</li>
            </ul>
            <p class="text-xs text-blue-600 mt-2"><strong>Directives used:</strong> x-data, x-show, @click, @click.stop, @keydown.escape, x-trap, x-transition.opacity</p>
        </div>
]" + build_modal_dialog + "[
    </section>

    <section class="mb-10 p-6 border rounded-lg">
        <h2 class="text-xl font-semibold mb-2">4. Tabs</h2>
        <div class="bg-blue-50 border-l-4 border-blue-400 p-4 mb-4">
            <p class="font-medium text-blue-800">What to expect:</p>
            <ul class="list-disc ml-6 text-blue-700 text-sm mt-1">
                <li>Click any tab (Home, Profile, Settings) to switch content</li>
                <li>Active tab shows blue underline indicator</li>
                <li>Content panels show/hide based on selection</li>
                <li>Only one panel visible at a time</li>
            </ul>
            <p class="text-xs text-blue-600 mt-2"><strong>Directives used:</strong> x-data, x-show, @click, :class (conditional classes)</p>
        </div>
]" + build_tabs_component + "[
    </section>

    <section class="mb-10 p-6 border rounded-lg">
        <h2 class="text-xl font-semibold mb-2">5. Accordion</h2>
        <div class="bg-blue-50 border-l-4 border-blue-400 p-4 mb-4">
            <p class="font-medium text-blue-800">What to expect:</p>
            <ul class="list-disc ml-6 text-blue-700 text-sm mt-1">
                <li>Click section headers to expand/collapse content</li>
                <li>Content animates with smooth height transition (x-collapse plugin)</li>
                <li>Multiple sections can be open simultaneously</li>
            </ul>
            <p class="text-xs text-blue-600 mt-2"><strong>Directives used:</strong> x-data, x-show, @click, x-collapse (plugin)</p>
        </div>
]" + build_accordion + "[
    </section>

    <section class="mb-10 p-6 border rounded-lg">
        <h2 class="text-xl font-semibold mb-2">6. Counter</h2>
        <div class="bg-blue-50 border-l-4 border-blue-400 p-4 mb-4">
            <p class="font-medium text-blue-800">What to expect:</p>
            <ul class="list-disc ml-6 text-blue-700 text-sm mt-1">
                <li>Click "-" to decrement the count</li>
                <li>Click "+" to increment the count</li>
                <li>The number updates instantly (reactive state)</li>
            </ul>
            <p class="text-xs text-blue-600 mt-2"><strong>Directives used:</strong> x-data, x-text, @click</p>
        </div>
]" + build_counter + "[
    </section>

    <section class="mb-10 p-6 border rounded-lg">
        <h2 class="text-xl font-semibold mb-2">7. HTMX + Alpine Combo</h2>
        <div class="bg-blue-50 border-l-4 border-blue-400 p-4 mb-4">
            <p class="font-medium text-blue-800">What to expect:</p>
            <ul class="list-disc ml-6 text-blue-700 text-sm mt-1">
                <li>Click "Load Data" to trigger an HTMX request</li>
                <li>Button becomes disabled and shows loading state (opacity change)</li>
                <li>Alpine manages the loading UI while HTMX handles the server request</li>
                <li><em>Note: Request will fail without a server - this demonstrates the integration pattern</em></li>
            </ul>
            <p class="text-xs text-blue-600 mt-2"><strong>Directives used:</strong> x-data, @click, :disabled, :class + HTMX: hx-get, hx-target, hx-swap</p>
        </div>
]" + build_htmx_alpine_combo + "[
        <div id="result" class="mt-4 p-4 border rounded min-h-16 text-gray-500 italic">Results will appear here after HTMX request...</div>
    </section>

    <section class="mb-10 p-6 border rounded-lg">
        <h2 class="text-xl font-semibold mb-2">8. Form with x-model Binding</h2>
        <div class="bg-blue-50 border-l-4 border-blue-400 p-4 mb-4">
            <p class="font-medium text-blue-800">What to expect:</p>
            <ul class="list-disc ml-6 text-blue-700 text-sm mt-1">
                <li><strong>Name:</strong> Type to see instant updates in Live Preview (x-model)</li>
                <li><strong>Email:</strong> Updates only on blur/change, not every keystroke (x-model.lazy)</li>
                <li><strong>Age:</strong> Automatically converts to number type (x-model.number)</li>
                <li><strong>Newsletter:</strong> Checkbox binding (boolean value)</li>
                <li><strong>Country:</strong> Select dropdown binding</li>
                <li><strong>Bio:</strong> Updates after 500ms pause in typing (x-model.debounce)</li>
                <li>Click Submit to see all form data in an alert</li>
            </ul>
            <p class="text-xs text-blue-600 mt-2"><strong>Directives used:</strong> x-data, x-model, x-model.lazy, x-model.number, x-model.debounce, x-cloak, @submit.prevent</p>
        </div>
]" + build_form_demo + "[
    </section>

    <section class="mb-10 p-6 border rounded-lg">
        <h2 class="text-xl font-semibold mb-2">9. Dynamic List with x-for</h2>
        <div class="bg-blue-50 border-l-4 border-blue-400 p-4 mb-4">
            <p class="font-medium text-blue-800">What to expect:</p>
            <ul class="list-disc ml-6 text-blue-700 text-sm mt-1">
                <li>Type text and press Enter or click Add to create new items</li>
                <li>Click the red X button to remove any item</li>
                <li>List updates reactively as items are added/removed</li>
                <li>Item count updates automatically</li>
                <li>Empty state message shows when list is empty</li>
            </ul>
            <p class="text-xs text-blue-600 mt-2"><strong>Directives used:</strong> x-data, x-for, x-model, x-show, @click, @keydown.enter, :key, template</p>
        </div>
]" + build_dynamic_list + "[
    </section>

    <section class="mb-10 p-6 border rounded-lg">
        <h2 class="text-xl font-semibold mb-2">10. Element References with x-ref</h2>
        <div class="bg-blue-50 border-l-4 border-blue-400 p-4 mb-4">
            <p class="font-medium text-blue-800">What to expect:</p>
            <ul class="list-disc ml-6 text-blue-700 text-sm mt-1">
                <li><strong>Focus:</strong> Click to move cursor into the input field</li>
                <li><strong>Select All:</strong> Click to highlight all text in the input</li>
                <li><strong>Clear:</strong> Click to empty the input field</li>
                <li>These work by referencing the input element via $refs.myInput</li>
                <li>Check browser console for $el reference log on page load</li>
            </ul>
            <p class="text-xs text-blue-600 mt-2"><strong>Directives used:</strong> x-data, x-ref, x-init, @click with $refs and $el magic properties</p>
        </div>
]" + build_refs_demo + "[
    </section>

    <section class="mb-10 p-6 border rounded-lg">
        <h2 class="text-xl font-semibold mb-2">11. Custom Events with $dispatch</h2>
        <div class="bg-blue-50 border-l-4 border-blue-400 p-4 mb-4">
            <p class="font-medium text-blue-800">What to expect:</p>
            <ul class="list-disc ml-6 text-blue-700 text-sm mt-1">
                <li><strong>Send Simple Event:</strong> Dispatches "custom-event" - log shows timestamp</li>
                <li><strong>Send Event with Data:</strong> Dispatches "data-event" with message and timestamp payload</li>
                <li>Events bubble up and are caught by x-on listeners</li>
                <li>Event log displays all received events</li>
                <li>Click Clear Log to reset</li>
            </ul>
            <p class="text-xs text-blue-600 mt-2"><strong>Directives used:</strong> x-data, @click with $dispatch(), x-on:custom-event, x-on:data-event, x-for, x-show</p>
        </div>
]" + build_dispatch_demo + "[
    </section>

    <section class="mb-10 p-6 border rounded-lg">
        <h2 class="text-xl font-semibold mb-2">12. Navigation with Semantic Elements</h2>
        <div class="bg-blue-50 border-l-4 border-blue-400 p-4 mb-4">
            <p class="font-medium text-blue-800">What to expect:</p>
            <ul class="list-disc ml-6 text-blue-700 text-sm mt-1">
                <li>Click any nav link (Home, About, Services, Contact)</li>
                <li>Active link shows bold blue text</li>
                <li>Inactive links show gray with blue hover effect</li>
                <li>Current page indicator updates below the nav</li>
                <li>Links use @click.prevent for SPA-style navigation (no page reload)</li>
            </ul>
            <p class="text-xs text-blue-600 mt-2"><strong>Directives used:</strong> x-data, @click.prevent, :href, :class, x-text + semantic elements: nav, ul, li, a</p>
        </div>
]" + build_navigation + "[
    </section>

    <section class="mb-10 p-6 border rounded-lg">
        <h2 class="text-xl font-semibold mb-2">13. Intersection Observer with x-intersect</h2>
        <div class="bg-blue-50 border-l-4 border-blue-400 p-4 mb-4">
            <p class="font-medium text-blue-800">What to expect:</p>
            <ul class="list-disc ml-6 text-blue-700 text-sm mt-1">
                <li>Scroll down within this section to see the colored boxes</li>
                <li><strong>Blue box:</strong> Animates up when entering viewport (x-intersect:enter)</li>
                <li><strong>Green box:</strong> Shows "Loaded!" once when first seen (x-intersect.once) - check console</li>
                <li><strong>Purple/Gray box:</strong> Changes color based on visibility (x-intersect:enter/leave)</li>
                <li>Scroll up and down to see the purple box toggle between IN VIEW and OUT OF VIEW</li>
            </ul>
            <p class="text-xs text-blue-600 mt-2"><strong>Directives used:</strong> x-data, x-intersect:enter, x-intersect:leave, x-intersect.once, :class, x-text (plugin)</p>
        </div>
]" + build_intersect_demo + "[
    </section>

    <footer class="mt-12 pt-8 border-t text-center text-gray-500 text-sm">
        <p>Generated by <strong>simple_alpine</strong> - An Eiffel library for Alpine.js</p>
        <p class="mt-1">Alpine.js directives are type-safe and fluent in Eiffel code</p>
    </footer>
</body>
</html>
]"
		end

feature {NONE} -- Implementation

	alpine: ALPINE_FACTORY
			-- Factory for creating Alpine elements.

end
