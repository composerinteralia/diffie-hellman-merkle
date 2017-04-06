# [Diffie-Hellman-Merkle Key Exchange](https://en.wikipedia.org/wiki/Diffie%E2%80%93Hellman_key_exchange)

Run `ruby lib/dhm.rb`:

```rb
alice = Client.new("Alice")
bob = Client.new("Bob")

eve = Sniffer.new("Eve")
eve.hack_network

alice.send_secret_number(42, bob)
eve.share_sniffed_data
```

Results:
```
Alice sending secret number 42 to Bob
Bob received the secret number 42
Eve sniffed:
    base => 4079
    modulus => 719
    sender_public_key => 15
    receiver_public_key => 117
    encrypted_message => 17346
```
