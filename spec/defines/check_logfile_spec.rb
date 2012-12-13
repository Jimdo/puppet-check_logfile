require 'spec_helper'

describe "check_logfile" do

  describe "with tag, logfile and options" do
    let(:title) { 'foobar' }
    let(:params) {{
      :tag => 'baz',
      :logfile => '/foo/bar',
      :options => { 'foo' => 'feck' , 'bb' => 'baz' },
    }}

    it {
      should contain_concat__fragment('check_logfile_foobar') \
        .with_content(%r{^logfile => '/foo/bar',$})\
        .with_content(%r{^options => 'bb=baz,foo=feck',$})
      should_not contain_concat__fragment('check_logfile_foobar') \
        .with_content(%r{^criticalpattern =>})
    }
  end

end
