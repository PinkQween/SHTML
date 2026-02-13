import SHTML

// Example: Interactive Counter using Natural JS API
struct CounterPage: HTML {
    var body: some HTML {
        html {
            head {
                meta().charset("UTF-8")
                Title("Natural JS Counter")
            }
            
            body {
                Div {
                    h1 { "Counter: " }
                    span(id: "counter") { "0" }
                    
                    button(id: "increment") { "+" }
                    button(id: "decrement") { "-" }
                }
                
                script {
                    let_("count", .int(0))
                    const("counterEl", .raw("document.getElementById('counter')"))
                    
                    JSRaw("""
                    document.getElementById('increment').addEventListener('click', () => {
                        count++;
                        counterEl.textContent = count;
                        console.log('Count:', count);
                    });
                    
                    document.getElementById('decrement').addEventListener('click', () => {
                        count--;
                        counterEl.textContent = count;
                    });
                    """)
                    
                    console.log("App loaded!")
                }
            }
        }
    }
}
