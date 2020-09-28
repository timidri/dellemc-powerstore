require 'spec_helper_acceptance'

describe 'powerstore_host' do
  it 'get host' do
    result = run_resource('powerstore_host', 'string')
    expect(result).to match(%r{ensure => 'present'})
  end

  it 'create host' do
    pp = run_resource('powerstore_host', 'string', false)
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end

  it 'delete host' do
    pp = <<-EOS
    powerstore_host { 'string':
      ensure => absent,
    }
    EOS
    make_site_pp(pp)
    result = run_device(allow_changes: true)
    expect(result).to match(%r{Applied catalog.*})
  end
end