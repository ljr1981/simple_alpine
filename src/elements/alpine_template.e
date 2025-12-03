note
	description: "[
		Alpine.js enabled template element.

		Used for x-if and x-for directives which require a template wrapper.

		Example:
			alpine.template.x_if ("items.length > 0").containing (
				alpine.div.text ("Has items")
			)
	]"
	author: "Larry Rix with Claude"

class
	ALPINE_TEMPLATE

inherit
	ALPINE_ELEMENT

create
	make

feature -- Access

	tag_name: STRING = "template"

end
