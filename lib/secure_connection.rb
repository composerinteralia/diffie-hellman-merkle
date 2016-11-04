class SecureConnection
  def initialize(sender, receiver, receiver_connection=nil)
    @sender = sender
    @receiver_connection =
      receiver_connection || SecureConnection.new(receiver, sender, self)
    @base, @modulus = PRIMES.sample(2)
  end

  def send_secret_number(secret_number)
    establish_shared_secret

    Network.broadcast!(
      :encrypted_message,
      secret_number * shared_secret,
      receiver_connection
    )
  end

  def receive(header, body)
    case header
    when :base
      self.base = body
    when :modulus
      self.modulus = body
    when :sender_public_key
      self.received_public_key = body
      Network.broadcast!(
        :receiver_public_key,
        sender.public_key(base, modulus),
        receiver_connection
      )
    when :receiver_public_key
      self.received_public_key = body
    when :encrypted_message
      sender.receive_secret_number(body / shared_secret)
    end
  end

  private
  attr_reader :sender, :receiver_connection
  attr_accessor :base, :modulus, :received_public_key

  def shared_secret
    sender.shared_secret(received_public_key, modulus)
  end

  def establish_shared_secret
    Network.broadcast!(:base, base, receiver_connection)
    Network.broadcast!(:modulus, modulus, receiver_connection)
    Network.broadcast!(
      :sender_public_key,
      sender.public_key(base, modulus),
      receiver_connection
    )
  end
end
