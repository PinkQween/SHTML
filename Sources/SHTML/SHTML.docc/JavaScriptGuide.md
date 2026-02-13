# JavaScript Guide

A practical guide to writing JavaScript in SHTML - from simple to advanced.

## Quick Start

### Method 1: Inline Event Handlers (Simplest)

Add JavaScript directly to HTML attributes:

```swift
button { "Click Me" }
    .onclick("alert('Hello!')")
```

✅ **Use this for:** Simple one-line actions, quick prototypes.

### Method 2: Script Functions (Recommended)

Write reusable JavaScript functions:

```swift
html {
    head {
        ScriptElement {
            JSFunc("handleClick") {
                console.log("Button clicked!")
                JSRaw("alert('Hello from SHTML!')")
            }
        }
    }
    body {
        button { "Click Me" }
            .onclick("handleClick()")
    }
}
```

✅ **Use this for:** Reusable functions, complex logic, multiple actions.

## Complete Examples

### Example 1: Simple Interactive Button

```swift
struct InteractiveButton: HTML {
    var body: some HTML {
        html {
            head {
                ScriptElement {
                    // Define the function
                    JSFunc("handleClick") {
                        JSRaw("alert('Button clicked!')")
                    }
                }
            }
            body {
                // Use the function
                button { "Click Me" }
                    .onclick("handleClick()")
            }
        }
    }
}
```

### Example 2: DOM Manipulation

```swift
html {
    head {
        ScriptElement {
            JSFunc("changeText") {
                // Get element by ID
                const("element", JSArg.raw("document.getElementById('myText')"))
                
                // Change its content
                JSRaw("element.textContent = 'Text changed!'")
                
                // Change its style
                JSRaw("element.style.color = 'blue'")
            }
        }
    }
    body {
        p { "Original text" }
            .id("myText")
        
        button { "Change Text" }
            .onclick("changeText()")
    }
}
```

### Example 3: Form Handling

```swift
html {
    head {
        ScriptElement {
            JSFunc("handleSubmit", params: ["event"]) {
                // Prevent page reload
                JSRaw("event.preventDefault()")
                
                // Get form values
                const("name", JSArg.raw("document.getElementById('name').value"))
                const("email", JSArg.raw("document.getElementById('email').value"))
                
                // Log them
                console.log("Name:", JSArg.raw("name"))
                console.log("Email:", JSArg.raw("email"))
                
                // Show alert
                JSRaw("alert('Form submitted!')")
            }
        }
    }
    body {
        Form {
            Input()
                .type("text")
                .id("name")
                .placeholder("Your name")
            
            Input()
                .type("email")
                .id("email")
                .placeholder("your@email.com")
            
            button { "Submit" }
                .type("submit")
        }
        .onsubmit("handleSubmit(event); return false;")
    }
}
```

### Example 4: Counter (Complete Interactive Component)

```swift
struct Counter: HTML {
    var body: some HTML {
        html {
            head {
                ScriptElement {
                    // Initialize counter
                    let_("count", JSArg.int(0))
                    
                    // Update display
                    JSFunc("updateDisplay") {
                        const("display", JSArg.raw("document.getElementById('count')"))
                        JSRaw("display.textContent = count")
                    }
                    
                    // Increment
                    JSFunc("increment") {
                        JSRaw("count++")
                        JSRaw("updateDisplay()")
                    }
                    
                    // Decrement
                    JSFunc("decrement") {
                        JSRaw("count--")
                        JSRaw("updateDisplay()")
                    }
                    
                    // Reset
                    JSFunc("reset") {
                        JSRaw("count = 0")
                        JSRaw("updateDisplay()")
                    }
                }
            }
            body {
                VStack(spacing: "20px") {
                    h1 { "Counter" }
                    
                    h2 { "0" }
                        .id("count")
                        .fontSize("48px")
                    
                    HStack(spacing: "10px") {
                        button { "−" }
                            .onclick("decrement()")
                            .padding("10px 20px")
                        
                        button { "Reset" }
                            .onclick("reset()")
                            .padding("10px 20px")
                        
                        button { "+" }
                            .onclick("increment()")
                            .padding("10px 20px")
                    }
                }
                .padding("40px")
                .textAlign("center")
            }
        }
    }
}
```

## Using Natural JavaScript API

SHTML provides a natural API for writing JavaScript that looks like Swift:

### Console Logging

```swift
ScriptElement {
    console.log("Hello, world!")
    console.log("Multiple", "arguments")
    console.error("An error occurred")
    console.warn("Warning message")
}
```

### Document Manipulation

```swift
ScriptElement {
    JSFunc("manipulateDOM") {
        // Get element
        const("element", JSArg.raw("document.getElementById('myDiv')"))
        
        // Change properties
        JSRaw("element.innerHTML = '<p>New content</p>'")
        JSRaw("element.style.background = 'red'")
        JSRaw("element.classList.add('active')")
    }
}
```

### Variables

```swift
ScriptElement {
    // Const (immutable)
    const("PI", JSArg.number(3.14159))
    
    // Let (mutable)
    let_("count", JSArg.int(0))
    
    // Var (function-scoped)
    var_("message", JSArg.string("Hello"))
}
```

### Functions with Parameters

```swift
ScriptElement {
    JSFunc("greet", params: ["name"]) {
        const("message", JSArg.raw("'Hello, ' + name + '!'"))
        console.log(JSArg.raw("message"))
    }
    
    // Call it
    JSRaw("greet('Alice')")
}
```

## Async/Await and Fetch

### Fetching Data from an API

```swift
ScriptElement {
    JSFunc("fetchData", async: true) {
        JSRaw("""
        try {
            const response = await fetch('/api/data');
            const data = await response.json();
            console.log(data);
            
            // Update UI
            document.getElementById('result').textContent = JSON.stringify(data);
        } catch (error) {
            console.error('Error:', error);
        }
        """)
    }
}
```

### Complete Fetch Example

```swift
html {
    head {
        ScriptElement {
            JSFunc("loadUsers", async: true) {
                JSRaw("""
                try {
                    // Show loading
                    document.getElementById('users').textContent = 'Loading...';
                    
                    // Fetch data
                    const response = await fetch('https://jsonplaceholder.typicode.com/users');
                    const users = await response.json();
                    
                    // Build HTML
                    const html = users.map(user => 
                        `<li>${user.name} - ${user.email}</li>`
                    ).join('');
                    
                    // Update DOM
                    document.getElementById('users').innerHTML = html;
                } catch (error) {
                    document.getElementById('users').textContent = 'Error loading users';
                    console.error(error);
                }
                """)
            }
        }
    }
    body {
        button { "Load Users" }
            .onclick("loadUsers()")
        
        ul { }
            .id("users")
    }
}
```

## Event Listeners

### Adding Event Listeners

```swift
ScriptElement {
    // Run when page loads
    JSRaw("""
    document.addEventListener('DOMContentLoaded', function() {
        console.log('Page loaded!');
        
        // Add event listener to button
        const button = document.getElementById('myButton');
        button.addEventListener('click', function() {
            console.log('Button clicked!');
        });
    });
    """)
}
```

### Keyboard Events

```swift
ScriptElement {
    JSRaw("""
    document.addEventListener('keydown', function(event) {
        if (event.key === 'Enter') {
            console.log('Enter key pressed');
        }
        if (event.key === 'Escape') {
            console.log('Escape key pressed');
        }
    });
    """)
}
```

## Local Storage

```swift
ScriptElement {
    // Save data
    JSFunc("saveData") {
        const("data", JSArg.string("Hello, Storage!"))
        JSRaw("localStorage.setItem('myData', data)")
        console.log("Data saved!")
    }
    
    // Load data
    JSFunc("loadData") {
        const("data", JSArg.raw("localStorage.getItem('myData')"))
        console.log("Loaded:", JSArg.raw("data"))
        JSRaw("document.getElementById('output').textContent = data")
    }
    
    // Clear data
    JSFunc("clearData") {
        JSRaw("localStorage.removeItem('myData')")
        console.log("Data cleared!")
    }
}
```

## Timers and Intervals

### Delayed Actions (setTimeout)

```swift
ScriptElement {
    JSFunc("delayedAction") {
        console.log("Starting...")
        JSRaw("""
        setTimeout(function() {
            console.log('This runs after 2 seconds');
            alert('Delayed message!');
        }, 2000);
        """)
    }
}
```

### Repeating Actions (setInterval)

```swift
ScriptElement {
    let_("intervalId", JSArg.raw("null"))
    let_("counter", JSArg.int(0))
    
    JSFunc("startCounter") {
        JSRaw("""
        intervalId = setInterval(function() {
            counter++;
            document.getElementById('counter').textContent = counter;
        }, 1000);
        """)
    }
    
    JSFunc("stopCounter") {
        JSRaw("clearInterval(intervalId)")
    }
}
```

## Complete Real-World Example: Todo List

```swift
struct TodoApp: HTML {
    var body: some HTML {
        html {
            head {
                Title("Todo App")
                ScriptElement {
                    let_("todos", JSArg.raw("[]"))
                    
                    JSFunc("addTodo") {
                        const("input", JSArg.raw("document.getElementById('todoInput')"))
                        const("text", JSArg.raw("input.value.trim()"))
                        
                        JSRaw("""
                        if (text === '') return;
                        
                        todos.push({ id: Date.now(), text: text, done: false });
                        input.value = '';
                        renderTodos();
                        """)
                    }
                    
                    JSFunc("toggleTodo", params: ["id"]) {
                        JSRaw("""
                        const todo = todos.find(t => t.id === id);
                        if (todo) {
                            todo.done = !todo.done;
                            renderTodos();
                        }
                        """)
                    }
                    
                    JSFunc("deleteTodo", params: ["id"]) {
                        JSRaw("""
                        todos = todos.filter(t => t.id !== id);
                        renderTodos();
                        """)
                    }
                    
                    JSFunc("renderTodos") {
                        const("list", JSArg.raw("document.getElementById('todoList')"))
                        JSRaw("""
                        list.innerHTML = todos.map(todo => `
                            <li style="margin: 10px 0; padding: 10px; background: white; border-radius: 8px;">
                                <input type="checkbox" 
                                       ${todo.done ? 'checked' : ''} 
                                       onchange="toggleTodo(${todo.id})">
                                <span style="${todo.done ? 'text-decoration: line-through; color: #999;' : ''}">${todo.text}</span>
                                <button onclick="deleteTodo(${todo.id})" style="float: right; color: red;">Delete</button>
                            </li>
                        `).join('');
                        """)
                    }
                    
                    // Handle Enter key
                    JSRaw("""
                    document.addEventListener('DOMContentLoaded', function() {
                        document.getElementById('todoInput').addEventListener('keypress', function(e) {
                            if (e.key === 'Enter') addTodo();
                        });
                    });
                    """)
                }
            }
            body {
                VStack(spacing: "20px") {
                    h1 { "Todo List" }
                    
                    HStack(spacing: "10px") {
                        Input()
                            .type("text")
                            .id("todoInput")
                            .placeholder("What needs to be done?")
                            .padding("10px")
                            .frame(width: "300px")
                        
                        button { "Add" }
                            .onclick("addTodo()")
                            .padding("10px 20px")
                    }
                    
                    ul { }
                        .id("todoList")
                        .style("list-style: none; padding: 0;")
                }
                .padding("40px")
            }
            .background("#f5f5f5")
        }
    }
}
```

## Tips and Best Practices

1. **Use JSRaw for complex code** - For multi-line JavaScript, use `JSRaw(""" ... """)`
2. **Prefer functions over inline** - Define functions in `<head>`, call them from events
3. **Always prevent default on forms** - Use `event.preventDefault()` in submit handlers
4. **Check for null** - Always check if elements exist before manipulating them
5. **Use DOMContentLoaded** - Wait for page to load before accessing elements
6. **Keep it simple** - For complex apps, consider using the JS router or a framework

## Common Patterns

### Show/Hide Element

```swift
JSFunc("toggleElement", params: ["id"]) {
    const("element", JSArg.raw("document.getElementById(id)"))
    JSRaw("""
    if (element.style.display === 'none') {
        element.style.display = 'block';
    } else {
        element.style.display = 'none';
    }
    """)
}
```

### Form Validation

```swift
JSFunc("validateForm") {
    const("email", JSArg.raw("document.getElementById('email').value"))
    JSRaw("""
    if (!email.includes('@')) {
        alert('Please enter a valid email');
        return false;
    }
    return true;
    """)
}
```

### Modal Dialog

```swift
JSFunc("showModal") {
    JSRaw("document.getElementById('modal').style.display = 'flex'")
}

JSFunc("closeModal") {
    JSRaw("document.getElementById('modal').style.display = 'none'")
}
```

## Next Steps

- Learn about the Router for single-page applications
- Check out the full JavaScript examples in the repository
- Explore the Natural JavaScript API documentation
