#!/usr/bin/env ruby

require 'prime'
require_relative 'network'
require_relative 'secure_connection'
require_relative 'client'
require_relative 'sniffer'

PRIMES = Prime.first(1000).drop(25)

if __FILE__ == $PROGRAM_NAME
    alice = Client.new("Alice")
    bob = Client.new("Bob")

    eve = Sniffer.new("Eve")
    eve.hack_network

    alice.send_secret_number(42, bob)
    eve.share_sniffed_data

    bob.send_secret_number(77, alice)
    eve.share_sniffed_data
end
