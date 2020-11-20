#!/opt/puppetlabs/puppet/bin/ruby

require_relative '../lib/puppet/util/task_helper'
require 'json'
require 'puppet'
require 'openssl'
# require 'pry-remote'; binding.remote_pry

# class PowerstoreVolumeCreateTask
class PowerstoreVolumeCreateTask < TaskHelper
  def task(arg_hash)
    header_params = {}
    # Remove task name from arguments - should contain all necessary parameters for URI
    arg_hash.delete('_task')
    namevar = 'name'
    namevar = 'id' if namevar.empty?
    operation_verb = 'Post'
    operation_path = '/volume'
    parent_consumes = 'application/json'
    # parent_produces = 'application/json'
    query_params, body_params, path_params = format_params(arg_hash)

    result = transport.call_op(path_params, query_params, header_params, body_params, operation_path, operation_verb, parent_consumes)

    raise result.body unless result.is_a? Net::HTTPSuccess
    return nil if result.body.nil?
    return result.body if result.to_hash['content-type'].include? 'document/text'
    body = JSON.parse(result.body)
    return body.map { |i| [i[namevar], i] }.to_h if body.class == Array
    body
  end

  def op_param(name, location, paramalias, namesnake)
    { name: name, location: location, paramalias: paramalias, namesnake: namesnake }
  end

  def format_params(key_values)
    query_params = {}
    body_params = {}
    path_params = {}

    key_values.each do |key, value|
      next unless value.respond_to?(:include) && value.include?('=>')
      value.include?('=>')
      Puppet.debug("Running hash from string on #{value}")
      value.tr!('=>', ':')
      value.tr!("'", '"')
      key_values[key] = JSON.parse(value)
      Puppet.debug("Obtained hash #{key_values[key].inspect}")
    end

    if key_values.key?('body')
      if File.file?(key_values['body'])
        body_params['file_content'] = if key_values['body'].include?('json')
                                        File.read(key_values['body'])
                                      else
                                        JSON.pretty_generate(YAML.load_file(key_values['body']))
                                      end
      end
    end

    op_params = [
      op_param('appliance_id', 'body', 'appliance_id', 'appliance_id'),
      op_param('description', 'body', 'description', 'description'),
      op_param('host_group_id', 'body', 'host_group_id', 'host_group_id'),
      op_param('host_id', 'body', 'host_id', 'host_id'),
      op_param('logical_unit_number', 'body', 'logical_unit_number', 'logical_unit_number'),
      op_param('min_size', 'body', 'min_size', 'min_size'),
      op_param('name', 'body', 'name', 'name'),
      op_param('performance_policy_id', 'body', 'performance_policy_id', 'performance_policy_id'),
      op_param('protection_policy_id', 'body', 'protection_policy_id', 'protection_policy_id'),
      op_param('sector_size', 'body', 'sector_size', 'sector_size'),
      op_param('size', 'body', 'size', 'size'),
      op_param('volume_group_id', 'body', 'volume_group_id', 'volume_group_id'),
    ]
    op_params.each do |i|
      location = i[:location]
      name     = i[:name]
      # paramalias = i[:paramalias]
      name_snake = i[:namesnake]
      if location == 'query'
        query_params[name] = key_values[name_snake.to_sym] unless key_values[name_snake.to_sym].nil?
      elsif location == 'body'
        body_params[name] = key_values[name_snake.to_sym] unless key_values[name_snake.to_sym].nil?
      else
        path_params[name_snake.to_sym] = key_values[name_snake.to_sym] unless key_values[name_snake.to_sym].nil?
      end
    end

    [query_params, body_params, path_params]
  end

  if $PROGRAM_NAME == __FILE__
    PowerstoreVolumeCreateTask.run
  end
end