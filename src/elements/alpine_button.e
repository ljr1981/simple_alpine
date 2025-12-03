note
	description: "Alpine.js enabled button element"
	author: "Larry Rix with Claude"

class
	ALPINE_BUTTON

inherit
	ALPINE_ELEMENT

create
	make

feature -- Access

	tag_name: STRING = "button"

feature -- Button-specific

	type_button: like Current
			-- Set type to button (default, no form submission).
		do
			attr ("type", "button").do_nothing
			Result := Current
		end

	type_submit: like Current
			-- Set type to submit.
		do
			attr ("type", "submit").do_nothing
			Result := Current
		end

	type_reset: like Current
			-- Set type to reset.
		do
			attr ("type", "reset").do_nothing
			Result := Current
		end

end
