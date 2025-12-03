note
	description: "Alpine.js enabled label element"
	author: "Larry Rix with Claude"

class
	ALPINE_LABEL

inherit
	ALPINE_ELEMENT

create
	make

feature -- Access

	tag_name: STRING = "label"

feature -- Label-specific

	for_ (a_id: READABLE_STRING_GENERAL): like Current
			-- Set the for attribute (links to input id).
		do
			attr ("for", a_id.to_string_8).do_nothing
			Result := Current
		end

end
