class Network
  def self.broadcast!(header, body, connection)
    connection.receive(header, body)
  end
end
