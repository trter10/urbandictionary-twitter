class HostedGraphite
  def initialize(api_key = ENV['HOSTEDGRAPHITE_APIKEY'])
    @api_key = api_key
  end

  def send(metric_name, value = 1)
    if @api_key
      UDPSocket.new.send "#{@api_key}.#{metric_name} #{value}\n", 0, "carbon.hostedgraphite.com", 2003
    end
  end

  def time(metric_name)
    start = Time.now
    result = yield
    send metric_name, ((Time.now - start) * 1000).round
    result
  end
end