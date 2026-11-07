# On newer macOS, Ruby 3.0.3's Socket.tcp doesn't raise on a refused connection when given connect_timeout,
# so Webpacker always thinks its dev server is running: it skips compiling and proxies /packs to a closed port.
# That leaves pages without JS, so `method: :delete` links (like Log Out) fall back to GET.
module WebpackerDevServerCheck
  def running?
    return false unless config.dev_server.present?

    Socket.tcp(host, port).close
    true
  rescue SystemCallError, SocketError
    false
  end
end

Webpacker::DevServer.prepend(WebpackerDevServerCheck)
