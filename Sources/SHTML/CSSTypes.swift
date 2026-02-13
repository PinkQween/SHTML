// Type-safe overflow values
public enum Overflow: String {
    case visible
    case hidden
    case scroll
    case auto
    case clip
}

// Type-safe display values
public enum Display: String {
    case block
    case inline
    case inlineBlock = "inline-block"
    case flex
    case inlineFlex = "inline-flex"
    case grid
    case inlineGrid = "inline-grid"
    case none
}

// Type-safe position values
public enum Position: String {
    case `static`
    case relative
    case absolute
    case fixed
    case sticky
}

// Type-safe text alignment
public enum TextAlign: String {
    case left
    case center
    case right
    case justify
}

// Type-safe flex direction
public enum FlexDirection: String {
    case row
    case column
    case rowReverse = "row-reverse"
    case columnReverse = "column-reverse"
}

// Type-safe justify content
public enum JustifyContent: String {
    case flexStart = "flex-start"
    case flexEnd = "flex-end"
    case center
    case spaceBetween = "space-between"
    case spaceAround = "space-around"
    case spaceEvenly = "space-evenly"
}

// Type-safe align items
public enum AlignItems: String {
    case flexStart = "flex-start"
    case flexEnd = "flex-end"
    case center
    case baseline
    case stretch
}
