require 'spec_helper'

describe "check_logfile" do

  describe "with tag, logfile, options and logfilenocry set to false" do
    let(:title) { 'foobar' }
    let(:params) {{
      :tag => 'baz',
      :logfile => '/foo/bar',
      :options => { 'foo' => 'feck' , 'bb' => 'baz' },
      :logfilenocry => false
    }}

    it {
      should contain_concat__fragment('check_logfile_foobar') \
        .with_content(%r{^logfile => '/foo/bar',$})\
        .with_content(%r{^options => 'bb=baz',\noptions => 'foo=feck',\noptions => 'nologfilenocry',$})
      should_not contain_concat__fragment('check_logfile_foobar') \
        .with_content(%r{^criticalpatterns =>})
    }
  end

  describe "with tag, logfile, options and logfilenocry set to true" do
    let(:title) { 'foobar' }
    let(:params) {{
      :tag => 'baz',
      :logfile => '/foo/bar',
      :options => { 'foo' => 'feck' , 'bb' => 'baz' },
      :logfilenocry => true
    }}

    it {
      should contain_concat__fragment('check_logfile_foobar') \
        .with_content(%r{^logfile => '/foo/bar',$})\
        .with_content(%r{^options => 'bb=baz',\noptions => 'foo=feck',\noptions => 'logfilenocry',$})
      should_not contain_concat__fragment('check_logfile_foobar') \
        .with_content(%r{^criticalpatterns =>})
    }
  end

  describe "with tag, logfile, options and logfilenocry unset" do
    let(:title) { 'foobar' }
    let(:params) {{
      :tag => 'baz',
      :logfile => '/foo/bar',
      :options => { 'foo' => 'feck' , 'bb' => 'baz' },
    }}

    it {
      should contain_concat__fragment('check_logfile_foobar') \
        .with_content(%r{^logfile => '/foo/bar',$})\
        .with_content(%r{^options => 'bb=baz',\noptions => 'foo=feck',$})
      should_not contain_concat__fragment('check_logfile_foobar') \
        .with_content(%r{^criticalpatterns =>})\
        .with_content(%r{logfilenocry})
    }
  end

  describe "with logfilenocry being a string" do
    let(:title) { 'foobar' }
    let(:params) {{
      :tag => 'baz',
      :logfile => '/foo/bar',
      :options => { 'foo' => 'feck' , 'bb' => 'baz' },
      :logfilenocry => "foobar"
    }}

    it do
      expect {
        should contain_concat__fragment('check_logfile_foobar')
      }.to raise_error(Puppet::Error, /logfilenocry is not a boolean or undef: 'foobar'/)
    end
  end

  describe "with options not being a hash" do
    let(:title) { 'foobar' }
    let(:params) {{
      :tag => 'baz',
      :logfile => '/foo/bar',
      :options => 'foo',
    }}

    it do
      expect {
        should contain_concat__fragment('check_logfile_foobar')
      }.to raise_error(Puppet::Error, /options must be a hash: 'foo'/)
    end
  end

end
