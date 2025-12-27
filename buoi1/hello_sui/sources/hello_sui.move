/*
/// Module: hello_sui
module hello_sui::hello_sui;
*/

// For Move coding conventions, see
// https://docs.sui.io/concepts/sui-move-concepts/conventions


module hello_sui::greeting {
    use std::string;

    /// Struct to store
    public struct Greeting has key, store {
        id: UID, // Unique identifier for the object
        message: string::String, // Greeting message
        sender: address, // Address of the sender
    }

    /// Init function to create and send a greeting
    entry fun create_greeting(
        message_text: vector<u8>,
        recipient: address,
        ctx: &mut TxContext
    ) {
        let greeting = Greeting {
            id: object::new(ctx),
            message: string::utf8(message_text),
            sender: ctx.sender(),
        };
        
        transfer::public_transfer(greeting, recipient);
    }

    /// Function to get the greeting message (getter)
    entry fun get_message(greeting: &Greeting): string::String {
        greeting.message
    }

    entry fun get_sender(greeting: &Greeting): address {
        greeting.sender
    }
}