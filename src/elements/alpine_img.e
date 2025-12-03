note
	description: "Alpine.js enabled img element (void element)"
	author: "Larry Rix with Claude"

class
	ALPINE_IMG

inherit
	ALPINE_ELEMENT
		redefine
			is_void_element
		end

create
	make

feature -- Access

	tag_name: STRING = "img"

	is_void_element: BOOLEAN = True

feature -- Image-specific

	src (a_url: READABLE_STRING_GENERAL): like Current
			-- Set image source.
		do
			attr ("src", a_url.to_string_8).do_nothing
			Result := Current
		end

	alt (a_text: READABLE_STRING_GENERAL): like Current
			-- Set alt text.
		do
			attr ("alt", a_text.to_string_8).do_nothing
			Result := Current
		end

	width (a_width: INTEGER): like Current
			-- Set width.
		do
			attr ("width", a_width.out).do_nothing
			Result := Current
		end

	height (a_height: INTEGER): like Current
			-- Set height.
		do
			attr ("height", a_height.out).do_nothing
			Result := Current
		end

	loading_lazy: like Current
			-- Enable lazy loading.
		do
			attr ("loading", "lazy").do_nothing
			Result := Current
		end

end
