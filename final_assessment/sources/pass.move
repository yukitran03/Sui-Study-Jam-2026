/*
/// Module: final_assessment
module final_assessment::final_assessment;
*/
#[allow(duplicate_alias)]
module 0x0::pass {
    
    use sui::object;
    use sui::tx_context::TxContext;
    use sui::table;
    use sui::table::Table;
    use sui::transfer;

    /// Soulbound Pass NFT
    public struct Pass has key, store {
        id: UID,
        owner: address,
    }

    /// Registry to track minted addresses
    public struct Registry has key {
        id: UID,
        minted: Table<address, bool>,
    }

    /// Initialize Registry (called once on publish)
    fun init(ctx: &mut TxContext) {
        let registry = Registry {
            id: object::new(ctx),
            minted: table::new(ctx),
        };
        transfer::share_object(registry);
    }

    #[allow(lint(self_transfer))]
    /// Mint a soulbound pass (only once per address)
    public fun mint_pass(
        registry: &mut Registry,
        ctx: &mut TxContext,
    ) {

        // FAIL CASE: already minted
        assert!(
            !table::contains(&registry.minted, ctx.sender()),
            0
        );

        let pass = Pass {
            id: object::new(ctx),
            owner: ctx.sender(),
        };

        table::add(&mut registry.minted, ctx.sender(), true);

        // Owned object → soulbound (no transfer entry exists)
        transfer::transfer(pass, ctx.sender());
    }

    /// Read-only check
    public fun has_pass(registry: &Registry, user: address): bool {
        table::contains(&registry.minted, user)
    }
}


// For Move coding conventions, see
// https://docs.sui.io/concepts/sui-move-concepts/conventions

