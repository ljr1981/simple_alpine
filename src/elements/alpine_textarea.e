note
	description: "Alpine.js enabled textarea element"
	author: "Larry Rix with Claude"

class
	ALPINE_TEXTAREA

inherit
	ALPINE_ELEMENT

create
	make

feature -- Access

	tag_name: STRING = "textarea"

feature -- Textarea-specific

	name (a_name: READABLE_STRING_GENERAL): like Current
			-- Set textarea name.
		do
			attr ("name", a_name.to_string_8).do_nothing
			Result := Current
		end

	rows (a_rows: INTEGER): like Current
			-- Set number of visible rows.
		do
			attr ("rows", a_rows.out).do_nothing
			Result := Current
		end

	cols (a_cols: INTEGER): like Current
			-- Set number of visible columns.
		do
			attr ("cols", a_cols.out).do_nothing
			Result := Current
		end

	placeholder (a_placeholder: READABLE_STRING_GENERAL): like Current
			-- Set placeholder text.
		do
			attr ("placeholder", a_placeholder.to_string_8).do_nothing
			Result := Current
		end

	required: like Current
			-- Mark as required.
		do
			attr ("required", "required").do_nothing
			Result := Current
		end

	readonly: like Current
			-- Mark as readonly.
		do
			attr ("readonly", "readonly").do_nothing
			Result := Current
		end

end
