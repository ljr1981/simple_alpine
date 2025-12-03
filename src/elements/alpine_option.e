note
	description: "Alpine.js enabled option element"
	author: "Larry Rix with Claude"

class
	ALPINE_OPTION

inherit
	ALPINE_ELEMENT

create
	make

feature -- Access

	tag_name: STRING = "option"

feature -- Option-specific

	value (a_value: READABLE_STRING_GENERAL): like Current
			-- Set option value.
		do
			attr ("value", a_value.to_string_8).do_nothing
			Result := Current
		end

	selected: like Current
			-- Mark as selected.
		do
			attr ("selected", "selected").do_nothing
			Result := Current
		end

end
