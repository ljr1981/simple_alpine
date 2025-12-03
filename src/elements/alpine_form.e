note
	description: "Alpine.js enabled form element"
	author: "Larry Rix with Claude"

class
	ALPINE_FORM

inherit
	ALPINE_ELEMENT

create
	make

feature -- Access

	tag_name: STRING = "form"

feature -- Form-specific

	action (a_url: READABLE_STRING_GENERAL): like Current
			-- Set form action URL.
		do
			attr ("action", a_url.to_string_8).do_nothing
			Result := Current
		end

	method_get: like Current
			-- Set method to GET.
		do
			attr ("method", "GET").do_nothing
			Result := Current
		end

	method_post: like Current
			-- Set method to POST.
		do
			attr ("method", "POST").do_nothing
			Result := Current
		end

	enctype_multipart: like Current
			-- Set enctype for file uploads.
		do
			attr ("enctype", "multipart/form-data").do_nothing
			Result := Current
		end

	novalidate: like Current
			-- Disable HTML5 validation.
		do
			attr ("novalidate", "novalidate").do_nothing
			Result := Current
		end

end
