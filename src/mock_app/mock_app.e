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
    <script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>
    <script src="https://unpkg.com/htmx.org@1.9.10"></script>
    <script defer src="https://cdn.jsdelivr.net/npm/@alpinejs/collapse@3.x.x/dist/cdn.min.js"></script>
    <script defer src="https://cdn.jsdelivr.net/npm/@alpinejs/focus@3.x.x/dist/cdn.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        [x-cloak] { display: none !important; }
        .dark-mode { background-color: #1a202c; color: #f7fafc; }
        .dark-mode .modal-content { background-color: #2d3748; color: #f7fafc; }
        .dark-mode .bg-gray-200 { background-color: #4a5568; color: #f7fafc; }
        .dark-mode .bg-white { background-color: #2d3748; color: #f7fafc; }
        .dark-mode .hover\:bg-gray-100:hover { background-color: #4a5568; }
        .dark-mode .border { border-color: #4a5568; }
    </style>
</head>
<body class="p-8 transition-colors duration-200" x-data="{ dark: false }" x-init="dark = localStorage.getItem('darkMode') === 'true'" x-effect="localStorage.setItem('darkMode', dark)" :class="{ 'dark-mode': dark }">
    <h1 class="text-3xl font-bold mb-8">simple_alpine Components</h1>

    <section class="mb-8">
        <h2 class="text-xl font-semibold mb-4">Dark Mode Toggle</h2>
        <button class="px-4 py-2 rounded bg-gray-200" @click="dark = !dark" x-text="dark ? 'Switch to Light' : 'Switch to Dark'"></button>
    </section>

    <section class="mb-8">
        <h2 class="text-xl font-semibold mb-4">Dropdown Menu</h2>
]" + build_dropdown_menu + "[
    </section>

    <section class="mb-8">
        <h2 class="text-xl font-semibold mb-4">Modal Dialog</h2>
]" + build_modal_dialog + "[
    </section>

    <section class="mb-8">
        <h2 class="text-xl font-semibold mb-4">Tabs</h2>
]" + build_tabs_component + "[
    </section>

    <section class="mb-8">
        <h2 class="text-xl font-semibold mb-4">Accordion</h2>
]" + build_accordion + "[
    </section>

    <section class="mb-8">
        <h2 class="text-xl font-semibold mb-4">Counter</h2>
]" + build_counter + "[
    </section>

    <section class="mb-8">
        <h2 class="text-xl font-semibold mb-4">HTMX + Alpine Combo</h2>
]" + build_htmx_alpine_combo + "[
        <div id="result" class="mt-4 p-4 border rounded"></div>
    </section>
</body>
</html>
]"
		end

feature {NONE} -- Implementation

	alpine: ALPINE_FACTORY
			-- Factory for creating Alpine elements.

end
