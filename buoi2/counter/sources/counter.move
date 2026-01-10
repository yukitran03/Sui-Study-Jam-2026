module counter::counter {

    public struct Counter has key, store {
        id: UID,
        value: u64,
    }

    /// Create a new Counter
    entry fun create(ctx: &mut TxContext) {
        let counter = Counter {
            id: object::new(ctx),
            value: 0,
        };
        transfer::transfer(counter, ctx.sender());
    }

    /// Increment counter
    entry fun increment(counter: &mut Counter) {
        counter.value = counter.value + 1;
    }

    /// Read value
    public fun get(counter: &Counter): u64 {
        counter.value
    }
}
