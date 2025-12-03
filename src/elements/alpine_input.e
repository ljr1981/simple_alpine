note
	description: "Alpine.js enabled input element (void element)"
	author: "Larry Rix with Claude"

class
	ALPINE_INPUT

inherit
	ALPINE_ELEMENT
		redefine
			is_void_element
		end

create
	make

feature -- Access

	tag_name: STRING = "input"

	is_void_element: BOOLEAN = True

feature -- Input-specific

	type_ (a_type: READABLE_STRING_GENERAL): like Current
			-- Set input type.
		do
			attr ("type", a_type.to_string_8).do_nothing
			Result := Current
		end

	name (a_name: READABLE_STRING_GENERAL): like Current
			-- Set input name.
		do
			attr ("name", a_name.to_string_8).do_nothing
			Result := Current
		end

	value (a_value: READABLE_STRING_GENERAL): like Current
			-- Set input value.
		do
			attr ("value", a_value.to_string_8).do_nothing
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

	autofocus: like Current
			-- Set autofocus.
		do
			attr ("autofocus", "autofocus").do_nothing
			Result := Current
		end

	min (a_value: INTEGER): like Current
			-- Set min value (for number inputs).
		do
			attr ("min", a_value.out).do_nothing
			Result := Current
		end

	max (a_value: INTEGER): like Current
			-- Set max value (for number inputs).
		do
			attr ("max", a_value.out).do_nothing
			Result := Current
		end

	step (a_value: READABLE_STRING_GENERAL): like Current
			-- Set step value (for number inputs).
		do
			attr ("step", a_value.to_string_8).do_nothing
			Result := Current
		end

end
