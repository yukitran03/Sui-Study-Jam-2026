#[test_only]
module hello_sui::greeting_tests {
    use hello_sui::greeting::{Self, Greeting};
    use std::string;
    use sui::test_scenario;

    #[test]
    fun test_create_greeting() {
        let sender = @0xA;
        let recipient = @0xB;
        
        // Begin test scenario
        let mut scenario = test_scenario::begin(sender);
        
        // Test: Create greeting
        {
            let ctx = test_scenario::ctx(&mut scenario);
            greeting::create_greeting(
                b"Hello Sui!",
                recipient,
                ctx
            );
        };
        
        // Next transaction: recipient receives greeting
        test_scenario::next_tx(&mut scenario, recipient);
        {
            // Check recipient has received the Greeting object
            assert!(test_scenario::has_most_recent_for_address<Greeting>(recipient), 0);
            
            let greeting_obj = test_scenario::take_from_address<Greeting>(
                &scenario,
                recipient
            );
            
            // Verify message content
            let message = greeting::get_message(&greeting_obj);
            assert!(string::as_bytes(&message) == b"Hello Sui!", 1);
            
            // Verify sender
            assert!(greeting::get_sender(&greeting_obj) == sender, 2);
            
            test_scenario::return_to_address(recipient, greeting_obj);
        };
        
        test_scenario::end(scenario);
    }

    #[test]
    fun test_greeting_message() {
        let sender = @0xC;
        let recipient = @0xD;
        let message_text = b"Welcome to Sui Blockchain!";
        
        let mut scenario = test_scenario::begin(sender);
        
        {
            let ctx = test_scenario::ctx(&mut scenario);
            greeting::create_greeting(message_text, recipient, ctx);
        };
        
        test_scenario::next_tx(&mut scenario, recipient);
        {
            let greeting_obj = test_scenario::take_from_address<Greeting>(
                &scenario,
                recipient
            );
            
            let message = greeting::get_message(&greeting_obj);
            assert!(string::as_bytes(&message) == message_text, 0);
            
            test_scenario::return_to_address(recipient, greeting_obj);
        };
        
        test_scenario::end(scenario);
    }

    #[test]
    #[expected_failure]
    fun test_wrong_recipient_cannot_access() {
        let sender = @0xE;
        let recipient = @0xF;
        let wrong_person = @0x10;
        
        let mut scenario = test_scenario::begin(sender);
        
        {
            let ctx = test_scenario::ctx(&mut scenario);
            greeting::create_greeting(b"Private message", recipient, ctx);
        };
        
        // Wrong person tries to access - should fail
        test_scenario::next_tx(&mut scenario, wrong_person);
        {
            // This will fail because wrong_person doesn't own the Greeting
            let _greeting = test_scenario::take_from_address<Greeting>(
                &scenario,
                wrong_person
            );
            
            test_scenario::return_to_address(wrong_person, _greeting);
        };
        
        test_scenario::end(scenario);
    }
}