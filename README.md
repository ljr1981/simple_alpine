<p align="center">
  <img src="https://raw.githubusercontent.com/ljr1981/claude_eiffel_op_docs/main/artwork/LOGO.png" alt="simple_ library logo" width="400">
</p>

# simple_alpine

Fluent Alpine.js attribute builder for Eiffel web applications. Extends [simple_htmx](https://github.com/ljr1981/simple_htmx) to add Alpine.js directives, enabling rich client-side interactivity.

## Overview

SIMPLE_ALPINE provides type-safe Alpine.js directive generation from Eiffel. Elements inherit from HTMX elements, giving you both HTMX server-side capabilities and Alpine.js client-side interactivity in one fluent API.

## Features

- **18+ Alpine.js Directives**: x-data, x-show, x-on, x-bind, x-model, x-for, x-transition, and more
- **Event Modifiers**: .prevent, .stop, .outside, .debounce, .throttle, .escape, .window
- **Pre-built Patterns**: Dark mode, dropdowns, modals, tabs, accordions, counters
- **Expression Helpers**: Toggle, ternary, class binding, data object builders
- **Magic Properties**: $refs, $store, $dispatch, $watch, $nextTick, $el
- **Plugin Support**: x-collapse, x-trap, x-intersect
- **Full HTMX Integration**: All elements support both HTMX and Alpine attributes

## Installation

### Prerequisites

- EiffelStudio 25.02+
- [simple_htmx](https://github.com/ljr1981/simple_htmx)
- [testing_ext](https://github.com/ljr1981/testing_ext) (for tests)

### Environment Variables

```
SIMPLE_ALPINE=D:\prod\simple_alpine
SIMPLE_HTMX=D:\prod\simple_htmx
TESTING_EXT=D:\prod\testing_ext
```

### ECF Reference

```xml
<library name="simple_alpine" location="$SIMPLE_ALPINE\simple_alpine.ecf"/>
```

## Quick Start

```eiffel
class MY_APP

feature
    alpine: ALPINE_FACTORY

    build_toggle_button: STRING
        local
            l_btn: ALPINE_BUTTON
        do
            create alpine
            l_btn := alpine.button_text ("Toggle Panel")
            l_btn.x_data ("{ open: false }")
                .x_on_click ("open = !open")
                .class_ ("px-4 py-2 bg-blue-500 text-white rounded")
            Result := l_btn.to_html
        end
end
```

**Output:**
```html
<button class="px-4 py-2 bg-blue-500 text-white rounded"
        x-data="{ open: false }"
        @click="open = !open">Toggle Panel</button>
```

## Usage Examples

### Dark Mode Toggle

```eiffel
l_btn := alpine.button_text ("Toggle Dark Mode")
l_btn.x_data (alpine.dark_mode_data)
    .x_init (alpine.dark_mode_init)
    .x_effect (alpine.dark_mode_watch)
    .x_on_click (alpine.dark_mode_toggle_expression)
```

### Dropdown Menu

```eiffel
l_container := alpine.div
l_container.x_data (alpine.dropdown_data)
    .class_ ("relative")

l_btn := alpine.button_text ("Menu")
l_btn.x_on_click (alpine.dropdown_toggle)

l_menu := alpine.div
l_menu.x_show ("open")
    .x_on_click_outside (alpine.dropdown_close)
    .x_on_keydown_escape (alpine.dropdown_close)
    .x_transition
```

### Modal Dialog

```eiffel
l_container := alpine.div
l_container.x_data (alpine.modal_data)

l_open_btn := alpine.button_text ("Open Modal")
l_open_btn.x_on_click (alpine.modal_open)

l_backdrop := alpine.div
l_backdrop.x_show ("open")
    .x_on_click (alpine.modal_close)
    .x_transition_opacity

l_modal := alpine.div
l_modal.x_on_click_stop ("")
    .x_trap ("open")
```

### Tabs Component

```eiffel
l_container := alpine.div
l_container.x_data (alpine.tabs_data ("home"))

l_tab1 := alpine.button_text ("Home")
l_tab1.x_on_click (alpine.tabs_select ("home"))
    .x_bind_class (alpine.class_if ("border-b-2 border-blue-500", alpine.tabs_is_active ("home")))

l_panel1 := alpine.div
l_panel1.x_show (alpine.tabs_is_active ("home"))
    .text ("Welcome to the home tab!")
```

### Combined HTMX + Alpine

```eiffel
-- Button with Alpine loading state + HTMX server request
l_btn := alpine.button_text ("Load Data")
l_btn.x_data (alpine.loading_data)
    .x_on_click (alpine.loading_start)
    .x_bind_disabled ("loading")
    .x_bind_class (alpine.class_if ("opacity-50 cursor-wait", "loading"))
    -- HTMX attributes
    .hx_get ("/api/data")
    .hx_target ("#result")
    .hx_swap_inner_html
    .attr ("hx-on::after-request", alpine.loading_stop)
```

## API Reference

### Alpine Directives

| Method | Alpine Attribute | Example |
|--------|-----------------|---------|
| `x_data` | x-data | `x_data ("{ open: false }")` |
| `x_init` | x-init | `x_init ("fetchData()")` |
| `x_show` | x-show | `x_show ("isVisible")` |
| `x_if` | x-if | `x_if ("shouldRender")` |
| `x_for` | x-for | `x_for ("item in items")` |
| `x_text` | x-text | `x_text ("message")` |
| `x_html` | x-html | `x_html ("content")` |
| `x_model` | x-model | `x_model ("username")` |
| `x_ref` | x-ref | `x_ref ("input")` |
| `x_cloak` | x-cloak | `x_cloak` |
| `x_effect` | x-effect | `x_effect ("console.log(count)")` |

### Event Handlers

| Method | Output |
|--------|--------|
| `x_on_click ("...")` | `@click="..."` |
| `x_on_click_prevent ("...")` | `@click.prevent="..."` |
| `x_on_click_stop ("...")` | `@click.stop="..."` |
| `x_on_click_outside ("...")` | `@click.outside="..."` |
| `x_on_keydown_escape ("...")` | `@keydown.escape="..."` |
| `x_on_input_debounce ("...", 300)` | `@input.debounce.300ms="..."` |

### Transitions

| Method | Output |
|--------|--------|
| `x_transition` | `x-transition` |
| `x_transition_opacity` | `x-transition.opacity` |
| `x_transition_scale ("95")` | `x-transition.scale.95` |
| `x_transition_duration ("300")` | `x-transition.duration.300ms` |
| `x_collapse` | `x-collapse` |

### Binding

| Method | Output |
|--------|--------|
| `x_bind_class ("...")` | `:class="..."` |
| `x_bind_style ("...")` | `:style="..."` |
| `x_bind_disabled ("...")` | `:disabled="..."` |
| `x_bind_href ("...")` | `:href="..."` |

## Project Status

- **103 tests passing**
- **28 classes** (2 core + 26 elements)
- **Mock app** with 13 working demo components showcasing all Alpine.js features

## Known Issues

None currently. The HTML escaping limitation was resolved in v1.1 by adding raw_attributes support to simple_htmx. Arrow functions, logical operators, and comparison operators now work correctly in Alpine.js directives.

## License

MIT License - See LICENSE file

## Author

Larry Rix with Claude (Anthropic)
