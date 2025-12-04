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

# Set environment variable
export SIMPLE_ALPINE="D:\\prod\\simple_alpine"

# Compile library
"/c/Program Files/Eiffel Software/EiffelStudio 25.02 Standard/studio/spec/win64/bin/ec.exe" \
  -batch -config simple_alpine.ecf -target simple_alpine -c_compile

# Run tests
"/c/Program Files/Eiffel Software/EiffelStudio 25.02 Standard/studio/spec/win64/bin/ec.exe" \
  -batch -config simple_alpine.ecf -target simple_alpine_tests -tests

# Compile and run mock app
"/c/Program Files/Eiffel Software/EiffelStudio 25.02 Standard/studio/spec/win64/bin/ec.exe" \
  -batch -config simple_alpine.ecf -target mock_app -c_compile
./EIFGENs/mock_app/W_code/simple_alpine.exe

# Clean compile (delete EIFGENs first)
rm -rf EIFGENs && "/c/Program Files/Eiffel Software/EiffelStudio 25.02 Standard/studio/spec/win64/bin/ec.exe" \
  -batch -config simple_alpine.ecf -target simple_alpine_tests -c_compile
```

### Current Status

**Phase 1 Complete** - 99 tests passing, mock app working

Completed work:
- ✅ ALPINE_ELEMENT base class with all Alpine.js directives
- ✅ ALPINE_FACTORY with expression helpers and pre-built patterns
- ✅ 26 element subclasses (inheriting from HTMX elements)
- ✅ 99 tests passing
- ✅ DBC contracts throughout
- ✅ Mock app with 7 working components
- ✅ GitHub repo created and pushed

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

**Phase 1 Complete.** The library includes:

### Core Classes (2)
- **ALPINE_ELEMENT**: Base class with all Alpine.js directives (inherits HTMX_ELEMENT)
- **ALPINE_FACTORY**: Element creation + expression helpers + pre-built patterns

### Alpine.js Directives (18+)
- **Data**: x-data, x-init, x-effect
- **Visibility**: x-show, x-if, x-cloak
- **Content**: x-text, x-html
- **Events**: x-on (with modifiers: .prevent, .stop, .outside, .debounce, .throttle, .escape)
- **Binding**: x-bind (shortcuts: :class, :style, :disabled, :aria-*)
- **Two-way**: x-model (with .lazy, .debounce modifiers)
- **Loops**: x-for
- **References**: x-ref
- **Transitions**: x-transition (with .opacity, .scale, .duration)
- **Plugins**: x-collapse, x-trap, x-intersect

### Magic Property Helpers
- `$refs`, `$store`, `$dispatch`, `$watch`, `$nextTick`, `$el`, `$root`, `$data`, `$id`

### Pre-built Patterns (Factory)
- **dark_mode_data/init/watch/toggle**: Theme switching with localStorage
- **dropdown_data/toggle/close**: Dropdown menus
- **modal_data/open/close**: Modal dialogs
- **tabs_data/select/is_active**: Tabbed interfaces
- **accordion_toggle/is_open**: Accordion panels
- **counter_data/increment/decrement**: Counters
- **loading_data/start/stop**: Loading states

### HTML Elements (26)
All inherit from ALPINE_ELEMENT (which inherits HTMX_ELEMENT):
- **Containers**: alpine_div, alpine_span, alpine_p
- **Headings**: alpine_h1, alpine_h2, alpine_h3
- **Forms**: alpine_form, alpine_input, alpine_textarea, alpine_select, alpine_option, alpine_label, alpine_button
- **Links/Media**: alpine_a, alpine_img
- **Lists**: alpine_ul, alpine_ol, alpine_li
- **Semantic**: alpine_header, alpine_footer, alpine_nav, alpine_main, alpine_aside, alpine_article, alpine_section
- **Special**: alpine_template (for x-if)

### Mock App
Located in `src/mock_app/mock_app.e` - Generates index.html with working components:
- Dark mode toggle (with localStorage persistence)
- Dropdown menu (click-outside close, Escape key)
- Modal dialog (backdrop, focus trap)
- Tabs (active indicator, content panels)
- Accordion (collapsible with x-collapse animation)
- Counter (increment/decrement)
- HTMX + Alpine combo (loading state)

**28 classes total. 99 tests passing.**

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

MOCK_APP
    └── Generates index.html with all components for browser testing
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

### Phase 1 - Foundation ✅ COMPLETE

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
| **Test suite** | 99 tests | ✅ |
| **DBC contracts** | Preconditions, postconditions, loop variants | ✅ |
| **Mock app** | Browser-testable components | ✅ |

### Phase 2 - Integration

| Feature | Description | Status |
|---------|-------------|--------|
| **simple_showcase integration** | Use in showcase website | Backlog |
| **Documentation expansion** | More usage examples | Backlog |

### Phase 3 - Expansion (As Needed)

| Feature | Description | Status |
|---------|-------------|--------|
| **Additional plugins** | Persist, Morph, Focus | Backlog |
| **Component helpers** | Toast, Tooltip, Popover | Backlog |
| **Alpine stores** | Global state management helpers | Backlog |
| **Raw attribute support** | Unescaped values for complex JS | Backlog |

---

## Known Issues

### HTML Escaping Limitation

**Issue**: JavaScript in Alpine attributes gets HTML-escaped by simple_htmx's `escape_html` function:
- `=>` becomes `&gt;` (breaks arrow functions)
- `&&` becomes `&amp;&amp;` (breaks logical AND)
- `<` and `>` in comparisons get escaped

**Workaround**:
1. Avoid arrow functions in x-data/x-init expressions
2. Use `x_effect` for side effects instead of `$watch` with callbacks
3. Use semicolons to separate statements instead of arrow functions

**Permanent fix (backlog)**: Add `attr_raw` method to simple_htmx for unescaped attribute values.

---

## Session Notes

### 2025-12-03 (Initial Creation + Phase 1 Complete)

**Task**: Create simple_alpine library for Alpine.js directives

**Origin**: Discussion of HTMX capabilities led to identifying Alpine.js as the complement for client-side state management.

**Architecture Decision**: Separate library because:
1. Different concern (client-side vs server-side)
2. Optional dependency (not every HTMX app needs Alpine)
3. Clean inheritance (ALPINE_ELEMENT extends HTMX_ELEMENT)

**Implementation**:
- Started with 28 classes, ~2,700 lines, 35 tests
- Expanded to 99 tests covering all directives
- Added DBC contracts throughout (class invariants, loop variants, pre/postconditions)
- Built mock app with 7 working components
- Discovered and worked around HTML escaping limitation

**Issues Discovered**:
1. HTML escaping breaks JavaScript arrow functions - used alternative patterns
2. Tailwind CDN doesn't support dark: variants - used custom CSS classes
3. Dark mode needs document-level scope - used x-data on body element

**Result**: 99 tests passing, mock app working in browser

---

## Notes

- All development follows Eiffel Design by Contract principles
- Classes use ECMA-367 standard Eiffel
- Testing via EiffelStudio AutoTest framework with TEST_SET_BASE
- Library extends simple_htmx - elements have both HTMX and Alpine capabilities
- Mock app generates index.html for manual browser testing
