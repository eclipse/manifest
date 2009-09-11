###############################################################################
# Copyright (c) 2008-2009 Manifest and others.
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Eclipse Public License v1.0
# which accompanies this distribution, and is available at
# http://www.eclipse.org/legal/epl-v10.html
#
# Contributors:
#     Antoine Toulme - initial API and implementation
###############################################################################

require File.dirname(__FILE__) + '/spec_helper.rb'


describe "Able to parse a manifest" do 
  
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

describe 'able to parse an invalid manifest' do
  
  it 'should read a manifest with no value for an entry' do
    lambda {Manifest.read(File.open("#{File.dirname(__FILE__)}/invalid_manifest.MF").read)}.should_not raise_error
  end
  
end