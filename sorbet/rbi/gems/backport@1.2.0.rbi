# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `backport` gem.
# Please instead update this file by running `bin/tapioca gem backport`.

# An event-driven IO library.
module Backport
  class << self
    # @return [Logger]
    def logger; end

    # Prepare an interval server to run in Backport.
    #
    # @param period [Float] Seconds between intervals
    # @return [void]
    def prepare_interval(period, &block); end

    # Prepare a STDIO server to run in Backport.
    #
    # @param adapter [Adapter]
    # @return [void]
    def prepare_stdio_server(adapter: T.unsafe(nil)); end

    # Prepare a TCP server to run in Backport.
    #
    # @param host [String]
    # @param port [Integer]
    # @param adapter [Adapter]
    # @return [void]
    def prepare_tcp_server(host: T.unsafe(nil), port: T.unsafe(nil), adapter: T.unsafe(nil)); end

    # Run the Backport machine. The provided block will be executed before the
    # machine starts. Program execution is blocked until the machine stops.
    #
    # @example Print "tick" once per second
    #   Backport.run do
    #   Backport.prepare_interval 1 do
    #   puts "tick"
    #   end
    #   end
    # @return [void]
    def run(&block); end

    # Stop all running Backport machines.
    #
    # For more accurate control, consider stopping the machine
    # from the self reference in Machine#run, e.g.:
    #
    # ```
    # Backport.run do |machine|
    #   # ...
    #   machine.stop
    # end
    # ```
    #
    # @return [void]
    def stop; end

    private

    # @return [Array<Machine>]
    def machines; end
  end
end

# The application interface between Backport servers and clients.
class Backport::Adapter
  # @param output [IO]
  # @param remote [Hash{Symbol => String, Integer}]
  # @return [Adapter] a new instance of Adapter
  def initialize(output, remote = T.unsafe(nil)); end

  # Close the client connection.
  #
  # @note The adapter sets #closed? to true and runs the #closing callback.
  #   The server is responsible for implementation details like closing the
  #   client's socket.
  # @return [void]
  def close; end

  # @return [Boolean]
  def closed?; end

  # A callback triggered when a client connection is closing. Subclasses
  # and/or modules should override this method to provide their own
  # functionality.
  #
  # @return [void]
  def closing; end

  # A callback triggered when a client connection is opening. Subclasses
  # and/or modules should override this method to provide their own
  # functionality.
  #
  # @return [void]
  def opening; end

  # A callback triggered when the server receives data from the client.
  # Subclasses and/or modules should override this method to provide their
  # own functionality.
  #
  # @param data [String]
  # @return [void]
  def receiving(data); end

  # A hash of information about the client connection. The data can vary
  # based on the transport, e.g., :hostname and :address for TCP connections
  # or :filename for file streams.
  #
  # @return [Hash{Symbol => String, Integer}]
  def remote; end

  # Send data to the client.
  #
  # @param data [String]
  # @return [void]
  def write(data); end

  # Send a line of data to the client.
  #
  # @param data [String]
  # @return [void]
  def write_line(data); end
end

# A client connected to a connectable Backport server.
class Backport::Client
  include ::Observable

  # @param input [IO]
  # @param output [IO]
  # @param adapter [Class, Module]
  # @param remote [Hash]
  # @return [Client] a new instance of Client
  def initialize(input, output, adapter, remote = T.unsafe(nil)); end

  # @return [Adapter]
  def adapter; end

  # Start running the client. This method will start the thread that reads
  # client input from IO.
  #
  # @deprecated Prefer #start to #run for non-blocking client/server methods
  # @return [void]
  def run; end

  # Start running the client. This method will start the thread that reads
  # client input from IO.
  #
  # @return [void]
  def start; end

  # Close the client connection.
  #
  # callback. The server is responsible for implementation details like
  # closing the client's socket.
  #
  # @note The client sets #stopped? to true and runs the adapter's #closing
  # @return [void]
  def stop; end

  # True if the client is stopped.
  #
  # @return [Boolean]
  def stopped?; end

  # Handle a tick from the server. This method will check for client input
  # and update the adapter accordingly, or stop the client if the adapter is
  # closed.
  #
  # @return [void]
  def tick; end

  private

  # @param mod_cls [Module, Class] The Adapter module or class
  # @param remote [Hash] Remote client data
  # @return [Adapter]
  def make_adapter(mod_cls, remote); end

  # @return [Mutex]
  def mutex; end

  # Read the client input. Return nil if the input buffer is empty.
  #
  # @return [String, nil]
  def read; end

  # Read input from the client.
  #
  # @return [void]
  def read_input; end

  # Start the thread that checks the input IO for client data.
  #
  # @return [void]
  def run_input_thread; end
end

# The Backport server controller.
class Backport::Machine
  # @return [Machine] a new instance of Machine
  def initialize; end

  # Add a server to the machine. The server will be started when the machine
  # starts. If the machine is already running, the server will be started
  # immediately.
  #
  # @param server [Server::Base]
  # @return [void]
  def prepare(server); end

  # Run the machine. If a block is provided, it gets executed before the
  # maching starts its main loop. The main loop blocks program execution
  # until the machine is stopped.
  #
  # @return [void]
  # @yieldparam [self]
  def run; end

  # @return [Array<Server::Base>]
  def servers; end

  # Stop the machine.
  #
  # @return [void]
  def stop; end

  # True if the machine is stopped.
  #
  # @return [Boolean]
  def stopped?; end

  # @param server [Server::Base]
  # @return [void]
  def update(server); end

  private

  # @return [Mutex]
  def mutex; end

  # Start the thread that updates servers via the #tick method.
  #
  # @return [void]
  def run_server_thread; end
end

# Classes and modules for Backport servers.
module Backport::Server; end

# An extendable server class that provides basic start/stop functionality
# and common callbacks.
class Backport::Server::Base
  include ::Observable

  # Start the server.
  #
  # @return [void]
  def start; end

  # @return [Boolean]
  def started?; end

  # A callback triggered when a Machine starts running or the server is
  # added to a running machine. Subclasses should override this method to
  # provide their own functionality.
  #
  # @return [void]
  def starting; end

  # Stop the server.
  #
  # @return [void]
  def stop; end

  # @return [Boolean]
  def stopped?; end

  # A callback triggered when the server is stopping. Subclasses should
  # override this method to provide their own functionality.
  #
  # @return [void]
  def stopping; end

  # A callback triggered from the main loop of a running Machine.
  # Subclasses should override this method to provide their own
  # functionality.
  #
  # @return [void]
  def tick; end
end

# A mixin for Backport servers that communicate with clients.
#
# Connectable servers check clients for incoming data on each tick.
module Backport::Server::Connectable
  # @return [Array<Client>]
  def clients; end

  # @return [void]
  def starting; end

  # @return [void]
  def stopping; end

  private

  # @return [Mutex]
  def mutex; end
end

# A Backport periodical interval server.
class Backport::Server::Interval < ::Backport::Server::Base
  # @param period [Float] The interval time in seconds.
  # @param block [Proc] The proc to run on each interval.
  # @return [Interval] a new instance of Interval
  # @yieldparam [Interval]
  def initialize(period, &block); end

  def starting; end
  def tick; end

  private

  # @return [void]
  def run_ready_thread; end
end

# A Backport STDIO server.
class Backport::Server::Stdio < ::Backport::Server::Base
  include ::Backport::Server::Connectable

  # @param input [IO]
  # @param output [IO]
  # @param adapter [Module, Class]
  # @return [Stdio] a new instance of Stdio
  def initialize(input: T.unsafe(nil), output: T.unsafe(nil), adapter: T.unsafe(nil)); end

  # @param client [Client]
  # @return [void]
  def update(client); end
end

# A Backport TCP server. It runs a thread to accept incoming connections
# and automatically stops when the socket is closed.
class Backport::Server::Tcpip < ::Backport::Server::Base
  include ::Backport::Server::Connectable

  # @param host [String]
  # @param port [Integer]
  # @param adapter [Module, Class]
  # @param socket_class [Class]
  # @return [Tcpip] a new instance of Tcpip
  def initialize(host: T.unsafe(nil), port: T.unsafe(nil), adapter: T.unsafe(nil), socket_class: T.unsafe(nil)); end

  # Accept an incoming connection using accept_nonblock. Return the
  # resulting Client if a connection was accepted or nil if no connections
  # are pending.
  #
  # @return [Client, nil]
  def accept; end

  def starting; end
  def stopping; end

  # @param client [Client]
  # @return [void]
  def update(client); end

  private

  # @return [TCPSocket]
  def socket; end

  # @return [void]
  def start_accept_thread; end
end

Backport::VERSION = T.let(T.unsafe(nil), String)