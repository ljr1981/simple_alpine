note
	description: "Alpine.js enabled anchor element"
	author: "Larry Rix with Claude"

class
	ALPINE_A

inherit
	ALPINE_ELEMENT

create
	make

feature -- Access

	tag_name: STRING = "a"

feature -- Anchor-specific

	href (a_url: READABLE_STRING_GENERAL): like Current
			-- Set href attribute.
		do
			attr ("href", a_url.to_string_8).do_nothing
			Result := Current
		end

	target_blank: like Current
			-- Open in new tab.
		do
			attr ("target", "_blank").do_nothing
			Result := Current
		end

	rel_noopener: like Current
			-- Add rel="noopener noreferrer" for security.
		do
			attr ("rel", "noopener noreferrer").do_nothing
			Result := Current
		end

end
