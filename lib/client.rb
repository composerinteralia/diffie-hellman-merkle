class Client
  attr_reader :name

  def initialize(name)
    @name = name
    @secret_key = PRIMES.sample
  end

  def public_key(base, modulus)
    (base ** secret_key) % modulus
  end

  def shared_secret(other_public_key, modulus)
    (other_public_key ** secret_key) % modulus
  end

  def send_secret_number(secret_number, receiver)
    puts "#{name} sending secret number #{secret_number} to #{receiver.name}"

    SecureConnection.new(self, receiver).send_secret_number(secret_number)
  end

  def receive_secret_number(secret_number)
    puts "#{name} received the secret number #{secret_number}"
  end

  private
  attr_reader :secret_key
end
