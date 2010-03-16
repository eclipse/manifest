###############################################################################
# Copyright (c) 2008-2010 Manifest and others.
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Eclipse Public License v1.0
# which accompanies this distribution, and is available at
# http://www.eclipse.org/legal/epl-v10.html
#
# Contributors:
#     Antoine Toulme - initial API and implementation
###############################################################################

require File.dirname(__FILE__) + '/spec_helper.rb'


describe "Able to parse a simple manifest" do 
  
  before do
    @sections = Manifest.read(File.open("#{File.dirname(__FILE__)}/manifest_org.eclipse.compare.MF").read)
  end
  
  it "should be able to guess the version number of the manifest" do
    @sections.first["Manifest-Version"].keys[0].should eql("1.0")
  end
  
  it "should be able to find the value of an attribute embedded in an entry" do  
    @sections.first["Bundle-SymbolicName"]["org.eclipse.compare"]["singleton"].should eql("true")
  end
  
  it "should be able to find the value of attributes attached to several values in an entry" do
    @sections.first["Require-Bundle"]["org.eclipse.ui"]["bundle-version"].should eql("\"[3.3.0,4.0.0)\"")
    @sections.first["Require-Bundle"]["org.eclipse.core.resources"]["bundle-version"].should eql("\"[3.3.0,4.0.0)\"")
    @sections.first["Require-Bundle"]["org.eclipse.core.expressions"]["bundle-version"].should eql("\"[3.2.0,4.0.0)\"")
  end
  
  
end

describe "Able to parse a manifest with nested lists" do
  it "should support nested lists" do
    manifest = <<-MANIFEST
Manifest-Version: 1.0
Bundle-ManifestVersion: 2
Bundle-SymbolicName: org.eclipse.core.resources; singleton:=true
Bundle-Version: 3.5.1.R_20090912
Export-Package: org.mortbay.jetty.nio;uses:="org.mortbay.log,org.mortba
 y.thread,org.mortbay.io,org.mortbay.jetty,org.mortbay.util.ajax,org.mo
 rtbay.io.nio";version="6.1.20"
Bundle-ActivationPolicy: Lazy
MANIFEST
    sections = Manifest.read(manifest)
    sections.first["Export-Package"].size.should == 1
  end
  
  it "should support nested lists even if placed after an other optional attribute" do
    manifest = <<-MANIFEST
Manifest-Version: 1.0
Bundle-ManifestVersion: 2
Bundle-SymbolicName: org.eclipse.core.resources; singleton:=true
Bundle-Version: 3.5.1.R_20090912
Export-Package: org.mortbay.jetty.nio;version="6.1.20";uses:="org.mortb
 ay.log,org.mortbay.thread,org.mortbay.io,org.mortbay.jetty,org.mortbay
 .util.ajax,org.mortbay.io.nio"
Bundle-ActivationPolicy: Lazy
MANIFEST
    sections = Manifest.read(manifest)
    sections.first["Export-Package"].size.should == 1
  end
  
  it "should not merge when several options are used" do
    manifest = File.read(File.join(File.dirname(__FILE__), 'gmf_manifest.MF'))
    sections = Manifest.read(manifest)
    sections.first["Require-Bundle"].size.should == 4
  end
  
  it 'should support nested lists with long manifests' do
    manifest = File.read(File.join(File.dirname(__FILE__), 'manifest_with_uses.MF'))
    sections = Manifest.read(manifest)
    sections.first["Export-Package"].size.should == 17
    
  end
end

describe 'able to parse an invalid manifest' do
  
  it 'should read a manifest with no value for an entry' do
    lambda {Manifest.read(File.open("#{File.dirname(__FILE__)}/invalid_manifest.MF").read)}.should_not raise_error
  end
  
end