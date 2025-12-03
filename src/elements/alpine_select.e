note
	description: "Alpine.js enabled select element"
	author: "Larry Rix with Claude"

class
	ALPINE_SELECT

inherit
	ALPINE_ELEMENT

create
	make

feature -- Access

	tag_name: STRING = "select"

feature -- Select-specific

	name (a_name: READABLE_STRING_GENERAL): like Current
			-- Set select name.
		do
			attr ("name", a_name.to_string_8).do_nothing
			Result := Current
		end

	multiple: like Current
			-- Allow multiple selection.
		do
			attr ("multiple", "multiple").do_nothing
			Result := Current
		end

	required: like Current
			-- Mark as required.
		do
			attr ("required", "required").do_nothing
			Result := Current
		end

	size (a_size: INTEGER): like Current
			-- Set visible options count.
		do
			attr ("size", a_size.out).do_nothing
			Result := Current
		end

end
