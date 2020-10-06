require 'puppet/util/network_device'
require 'puppet/resource_api/transport'

module Puppet::Parser::Functions
  newfunction(:powerstore_get, :type => :rvalue, :doc => <<-EOS
    pass query, endpoint, and returned keys
  EOS
  ) do |args|
    creds = Puppet::Util::NetworkDevice.current.connection_info
    creds[:password] = creds[:password].unwrap
    connection = Puppet::ResourceApi::Transport.connect('powerstore', creds)
    JSON.parse(connection.call_op({}, { 'select' => '*' }.merge(args[0]), {}, {}, args[1], 'Get', 'application/json').body).first[args[2]]
#    require 'pry'; binding.pry
  end
end
