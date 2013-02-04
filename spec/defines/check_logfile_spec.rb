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
        .with_content(%r{^criticalpatterns =>})
    }
  end

  describe "with logfilenocry options" do
    let(:title) { 'unattended-upgrade' }
    let(:params) {{
      :tag => 'unattended-upgrade',
      :logfile => '/var/log/unattended-upgrades/unattended-upgrades.log',
      :criticalpatterns => '^\d{4}-\d{2}-\d{2}\ \d{2}\:\d{2}\:\d{2}\,\d{3}\ ERROR\ ((error message:.*)|)',
      :options => { 'sticky' => 86400, 'nologfilenocry' => 'true' },
      :rotation => 'LOGLOG0GZLOG1GZ',
    }}
    it {
      should contain_concat__fragment('check_logfile_unattended-upgrade') \
        .with_content(%r{^criticalpatterns => \[ '\^\\d\{4\}-\\d\{2\}-\\d\{2\}\\ \\d\{2\}\\\:\\d\{2\}\\\:\\d\{2\}\\,\\d\{3\}\\\ ERROR\\ \(\(error\ message\:\.\*\)\|\)'\ \],$}) \
        .with_content(%r{^options => 'nologfilenocry=true,sticky=86400',$})
    }
  end

  describe "with patterns array" do
    let(:title) { 'unattended-upgrade' }
    let(:params) {{
      :tag => 'unattended-upgrade',
      :logfile => '/var/log/unattended-upgrades/unattended-upgrades.log',
      :criticalpatterns => '^\d{4}-\d{2}-\d{2}\ \d{2}\:\d{2}\:\d{2}\,\d{3}\ ERROR\ ((error message:.*)|)',
      :warningpatterns => [ '^\d{4}-\d{2}-\d{2}\ \d{2}\:\d{2}\:\d{2}\,\d{3}\ WARNING package \'.*\' upgradable but fails to be marked for upgrade', '^\d{4}-\d{2}-\d{2}\ \d{2}\:\d{2}\:\d{2}\,\d{3}\ INFO Packages that are upgraded:\ $' ],
      :options => { 'sticky' => 86400, 'nologfilenocry' => 'true' },
      :rotation => 'LOGLOG0GZLOG1GZ',
    }}
    it {
      should contain_concat__fragment('check_logfile_unattended-upgrade') \
        .with_content(%r{^criticalpatterns => \[ '\^\\d\{4\}-\\d\{2\}-\\d\{2\}\\ \\d\{2\}\\\:\\d\{2\}\\\:\\d\{2\}\\,\\d\{3\}\\\ ERROR\\ \(\(error\ message\:\.\*\)\|\)'\ \],$}) \
        .with_content(%r{^warningpatterns => \[ '\^\\d\{4\}-\\d\{2\}-\\d\{2\}\\ \\d\{2\}\\\:\\d\{2\}\\\:\\d\{2\}\\,\\d\{3\}\\\ INFO\ Packages\ that\ are\ upgraded\:\\ \$',\ \'\^\\d\{4\}-\\d\{2\}-\\d\{2\}\\ \\d\{2\}\\\:\\d\{2\}\\\:\\d\{2\}\\,\\d\{3\}\\\ WARNING\ package\ \'\.\*\'\ upgradable\ but\ fails\ to\ be\ marked\ for\ upgrade\'\ \],$})
    }
  end

end
