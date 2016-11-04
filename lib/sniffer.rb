class Sniffer
  attr_reader :name, :sniffed

  def initialize(name)
    @name = name
    @sniffed = {}
  end

  def hack_network
    sniffer = self

    Network.singleton_class.class_eval do
      alias_method :real_broadcast!, :broadcast!

      define_method(:broadcast!) do |header, body, connection|
        sniffer.sniff(header, body)
        real_broadcast!(header, body, connection)
      end

    end
  end

  def sniff(header, body)
    sniffed[header] = body
  end

  def share_sniffed_data
    puts "#{name} sniffed:"

    sniffed.each do |header, body|
      puts "    #{header} => #{body}"
    end
  end
end
