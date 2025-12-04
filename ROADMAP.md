# SIMPLE_ALPINE Roadmap

---

## Claude: Start Here

**When starting a new conversation, read this file first.**

### Session Startup

1. **Read Eiffel reference docs**: `D:/prod/reference_docs/eiffel/CLAUDE_CONTEXT.md`
2. **Review this roadmap** for project-specific context
3. **Ask**: "What would you like to work on this session?"

### Key Reference Files

| File | Purpose |
|------|---------|
| `D:/prod/reference_docs/eiffel/CLAUDE_CONTEXT.md` | Generic Eiffel knowledge |
| `D:/prod/reference_docs/eiffel/gotchas.md` | Generic Eiffel gotchas |
| `D:/prod/reference_docs/eiffel/HATS.md` | Focused work modes |
| `D:/prod/reference_docs/eiffel/patterns.md` | Verified code patterns |
| `D:/prod/reference_docs/eiffel/SIMPLE_HTMX_CREATION.md` | Library creation case study |

### Build & Test Commands

```bash
# From Git Bash (project directory)
cd /d/prod/simple_alpine

# Compile library
export SIMPLE_ALPINE="D:\\prod\\simple_alpine"
"/c/Program Files/Eiffel Software/EiffelStudio 25.02 Standard/studio/spec/win64/bin/ec.exe" \
  -batch -config simple_alpine.ecf -target simple_alpine -c_compile

# Compile tests
"/c/Program Files/Eiffel Software/EiffelStudio 25.02 Standard/studio/spec/win64/bin/ec.exe" \
  -batch -config simple_alpine.ecf -target simple_alpine_tests -c_compile

# Clean compile (delete EIFGENs first)
rm -rf EIFGENs && "/c/Program Files/Eiffel Software/EiffelStudio 25.02 Standard/studio/spec/win64/bin/ec.exe" \
  -batch -config simple_alpine.ecf -target simple_alpine_tests -c_compile
```

### Current Status

**Initial Development** - Compiles, tests not yet run

Completed work:
- ✅ ALPINE_ELEMENT base class with all Alpine.js directives
- ✅ ALPINE_FACTORY with expression helpers and pre-built patterns
- ✅ 26 element subclasses (inheriting from HTMX elements)
- ✅ Test classes written (35+ directive tests, factory tests)
- ✅ Compiles successfully

Next steps:
- Run tests in EiffelStudio AutoTest
- Fix any test failures
- Create GitHub repo and push

---

## Project Overview

SIMPLE_ALPINE is a fluent Alpine.js attribute builder for Eiffel web applications. It extends SIMPLE_HTMX to add Alpine.js directives, enabling rich client-side interactivity without server round-trips.

### Origin Story

1. **HTMX vs React discussion**: Explored what HTMX can and cannot do
2. **Alpine.js fills the gap**: Client-side state management, toggles, dropdowns, animations
3. **Architecture decision**: Separate library (not folded into simple_htmx) for modularity
4. **Implementation**: Inherits from HTMX_ELEMENT to get both HTMX and Alpine capabilities

### Design Philosophy

- **Fluent Interface (Feature Chaining)** - All methods return `like Current` for chaining
- **Layered Architecture** - ALPINE_ELEMENT inherits HTMX_ELEMENT (both capabilities together)
- **Type Safety** - Compiler catches Alpine.js attribute typos
- **Pre-built Patterns** - Common UI patterns (dark mode, dropdowns, modals) as helpers

---

## Current State

**Initial implementation complete.** The library includes:

### Core Classes (2)
- **ALPINE_ELEMENT**: Base class with all Alpine.js directives (inherits HTMX_ELEMENT)
- **ALPINE_FACTORY**: Element creation + expression helpers + pre-built patterns

### Alpine.js Directives (18+)
- **Data**: x-data, x-init
- **Visibility**: x-show, x-if, x-cloak
- **Content**: x-text, x-html
- **Events**: x-on (with modifiers: .prevent, .stop, .outside, .debounce, .throttle)
- **Binding**: x-bind (shortcuts: :class, :style, :disabled, :aria-*)
- **Two-way**: x-model (with .lazy, .debounce modifiers)
- **Loops**: x-for
- **References**: x-ref
- **Transitions**: x-transition (with .opacity, .scale, .duration)
- **Plugins**: x-collapse, x-trap, x-intersect

### Magic Property Helpers
- `$refs`, `$store`, `$dispatch`, `$watch`, `$nextTick`, `$el`, `$root`, `$data`, `$id`

### Pre-built Patterns (Factory)
- **dark_mode_data/toggle**: Theme switching
- **dropdown_data/toggle**: Dropdown menus
- **modal_data/open/close**: Modal dialogs
- **tabs_data/select/is_active**: Tabbed interfaces
- **accordion_toggle/is_open**: Accordion panels
- **counter_data/increment/decrement**: Counters with bounds

### HTML Elements (26)
All inherit from ALPINE_ELEMENT (which inherits HTMX_ELEMENT):
- **Containers**: alpine_div, alpine_span, alpine_p
- **Headings**: alpine_h1, alpine_h2, alpine_h3
- **Forms**: alpine_form, alpine_input, alpine_textarea, alpine_select, alpine_option, alpine_label, alpine_button
- **Links/Media**: alpine_a, alpine_img
- **Lists**: alpine_ul, alpine_ol, alpine_li
- **Semantic**: alpine_header, alpine_footer, alpine_nav, alpine_main, alpine_aside, alpine_article, alpine_section
- **Special**: alpine_template (for x-if)

**28 classes total. 35+ tests. Compiles successfully.**

---

## Class Structure

```
HTMX_ELEMENT (from simple_htmx)
    └── ALPINE_ELEMENT (all Alpine directives)
            ├── ALPINE_DIV, ALPINE_SPAN, ALPINE_P
            ├── ALPINE_H1, ALPINE_H2, ALPINE_H3
            ├── ALPINE_FORM, ALPINE_INPUT, ALPINE_TEXTAREA, etc.
            ├── ALPINE_TEMPLATE (for x-if)
            └── ... (26 element classes)

ALPINE_FACTORY
    ├── Element creation (div, span, button, input, template, etc.)
    ├── Expression builders (toggle, ternary, class_if, class_multi)
    ├── Data builders (data_bool, data_string, data_int, data_object)
    ├── Magic helpers (refs, store, dispatch, watch, next_tick)
    └── Pre-built patterns (dark_mode, dropdown, modal, tabs, accordion)
```

---

## Dependencies

### Required Libraries
- **base** - Eiffel standard library
- **simple_htmx** - HTMX element base classes (set `SIMPLE_HTMX` environment variable)

### Test Dependencies
- **testing** - EiffelStudio testing framework
- **testing_ext** - TEST_SET_BASE for tests (set `TESTING_EXT` environment variable)

### Environment Variables

Set these in Windows (use setx or System Properties):
```
SIMPLE_ALPINE=D:\prod\simple_alpine
SIMPLE_HTMX=D:\prod\simple_htmx
TESTING_EXT=D:\prod\testing_ext
```

---

## Roadmap

### Phase 1 - Foundation (IN PROGRESS)

| Feature | Description | Status |
|---------|-------------|--------|
| **Core element base class** | ALPINE_ELEMENT with all directives | ✅ |
| **18+ Alpine directives** | x-data, x-show, x-on, x-bind, etc. | ✅ |
| **Event modifiers** | .prevent, .stop, .outside, .debounce | ✅ |
| **x-model modifiers** | .lazy, .debounce, .throttle | ✅ |
| **Transition support** | x-transition with variants | ✅ |
| **Plugin support** | x-collapse, x-trap, x-intersect | ✅ |
| **Factory class** | Element creation + helpers | ✅ |
| **Pre-built patterns** | dark mode, dropdown, modal, tabs | ✅ |
| **26 element classes** | All common elements | ✅ |
| **Test suite** | 35+ tests | ✅ Written |
| **Compilation** | Compiles cleanly | ✅ |
| **Test execution** | All tests pass | Pending |

### Phase 2 - Integration

| Feature | Description | Status |
|---------|-------------|--------|
| **simple_showcase integration** | Use in showcase website | Backlog |
| **Contract strengthening** | DBC throughout | Backlog |
| **Documentation** | Usage examples | Backlog |

### Phase 3 - Expansion (As Needed)

| Feature | Description | Status |
|---------|-------------|--------|
| **Additional plugins** | Persist, Morph, Focus | Backlog |
| **Component helpers** | Toast, Tooltip, Popover | Backlog |
| **Alpine stores** | Global state management helpers | Backlog |

---

## API Quick Reference

### Element Creation (Factory)

```eiffel
alpine: ALPINE_FACTORY

-- Create elements (have both HTMX and Alpine capabilities)
l_div := alpine.div
l_btn := alpine.button
l_input := alpine.input
l_template := alpine.template  -- For x-if
```

### Alpine Directives

```eiffel
-- State and visibility
l_div.x_data ("{ open: false }")
l_div.x_show ("open")
l_div.x_if ("showPanel")
l_div.x_cloak

-- Content
l_span.x_text ("message")
l_div.x_html ("content")

-- Events
l_btn.x_on_click ("open = !open")
l_btn.x_on_click_prevent ("submitForm()")
l_btn.x_on_click_outside ("open = false")
l_input.x_on_keydown_escape ("clearSearch()")
l_input.x_on_input_debounce ("search()", 300)

-- Binding
l_div.x_bind_class ("{ 'active': isActive }")
l_div.bind_class_active ("isActive")  -- Shortcut
l_btn.bind_disabled ("isSubmitting")

-- Two-way binding
l_input.x_model ("username")
l_input.x_model_lazy ("email")
l_input.x_model_debounce ("search", 500)

-- Loops
l_template.x_for ("item in items")

-- References
l_input.x_ref ("searchInput")

-- Transitions
l_div.x_transition
l_div.x_transition_opacity
l_div.x_transition_scale ("95")
l_div.x_transition_duration ("300")

-- Plugin directives
l_div.x_collapse
l_div.x_trap ("open")
l_div.x_intersect ("shown = true")
```

### Expression Helpers (Factory)

```eiffel
-- Toggle expression
alpine.toggle ("open")                    -- "open = !open"

-- Ternary expression
alpine.ternary ("dark", "'bg-black'", "'bg-white'")  -- "dark ? 'bg-black' : 'bg-white'"

-- Class binding helpers
alpine.class_if ("hidden", "!visible")    -- "{ 'hidden': !visible }"
alpine.class_multi (<<"active", "isActive", "disabled", "!enabled">>)
```

### Pre-built Patterns (Factory)

```eiffel
-- Dark mode toggle
l_div.x_data (alpine.dark_mode_data)
l_btn.x_on_click (alpine.dark_mode_toggle)

-- Dropdown
l_div.x_data (alpine.dropdown_data)
l_btn.x_on_click (alpine.dropdown_toggle)
l_menu.x_show ("open").x_on_click_outside ("open = false")

-- Modal
l_div.x_data (alpine.modal_data)
l_btn.x_on_click (alpine.modal_open)
l_overlay.x_show ("open").x_on_click (alpine.modal_close)

-- Tabs
l_div.x_data (alpine.tabs_data ("home"))
l_tab.x_on_click (alpine.tabs_select ("settings"))
l_panel.x_show (alpine.tabs_is_active ("settings"))

-- Counter with bounds
l_div.x_data (alpine.counter_data (0, 0, 100))
l_btn.x_on_click (alpine.counter_increment)
l_btn.x_on_click (alpine.counter_decrement)
```

### Combined HTMX + Alpine

```eiffel
-- Element has BOTH HTMX and Alpine capabilities
l_btn := alpine.button
    .x_data ("{ loading: false }")           -- Alpine state
    .x_on_click ("loading = true")           -- Alpine event
    .bind_disabled ("loading")               -- Alpine binding
    .hx_post ("/api/submit")                 -- HTMX request
    .hx_target ("#result")                   -- HTMX targeting
    .hx_swap_inner_html                      -- HTMX swap
    .hx_on_after_request ("loading = false") -- HTMX event -> Alpine
```

---

## When to Use Alpine vs HTMX

| Use Case | Use HTMX | Use Alpine |
|----------|----------|------------|
| Fetch data from server | ✅ | |
| Submit forms | ✅ | |
| Server-rendered partials | ✅ | |
| Toggle visibility (no server) | | ✅ |
| Dark mode toggle | | ✅ |
| Dropdown menus | | ✅ |
| Form validation (client-side) | | ✅ |
| Animations/transitions | | ✅ |
| Local state management | | ✅ |
| Both: Loading states | ✅ triggers | ✅ shows spinner |

---

## Known Issues

None currently. Tests pending execution.

---

## Session Notes

### 2025-12-03 (Initial Creation)

**Task**: Create simple_alpine library for Alpine.js directives

**Origin**: Discussion of HTMX capabilities led to identifying Alpine.js as the complement for client-side state management.

**Architecture Decision**: Separate library because:
1. Different concern (client-side vs server-side)
2. Optional dependency (not every HTMX app needs Alpine)
3. Clean inheritance (ALPINE_ELEMENT extends HTMX_ELEMENT)

**Implementation**:
- 28 classes total (2 core + 26 elements)
- ~2,700 lines of code
- 35+ tests written
- Full Alpine.js directive coverage

**Result**: Compiles successfully, tests pending

---

## Notes

- All development follows Eiffel Design by Contract principles
- Classes use ECMA-367 standard Eiffel
- Testing via EiffelStudio AutoTest framework with TEST_SET_BASE
- Library extends simple_htmx - elements have both HTMX and Alpine capabilities
