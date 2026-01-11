#[allow(duplicate_alias)]
module 0x0::voting {

    use sui::object;
    use sui::tx_context::TxContext;
    use sui::table::Table;
    use sui::table;
    use sui::transfer;

    public struct Voting has key {
        id: UID,
        option_a: u64,
        option_b: u64,
        voted: Table<address, bool>,
    }

    /// Init voting object
    fun init(ctx: &mut TxContext) {
        let voting = Voting {
            id: object::new(ctx),
            option_a: 0,
            option_b: 0,
            voted: table::new(ctx),
        };
        transfer::share_object(voting);
    }

    /// Vote: true = A, false = B
    public fun vote(
        voting: &mut Voting,
        choice: bool,
        ctx: &mut TxContext,
    ) {
        let sender = ctx.sender();

        // FAIL CASE: double vote
        assert!(
            !table::contains(&voting.voted, sender),
            0
        );

        if (choice) {
            voting.option_a = voting.option_a + 1;
        } else {
            voting.option_b = voting.option_b + 1;
        };

        table::add(&mut voting.voted, sender, true);
    }

    /// Read results
    public fun get_results(voting: &Voting): (u64, u64) {
        (voting.option_a, voting.option_b)
    }
}