require File.dirname(__FILE__) + '/test_helper.rb'


describe "Able to parse a manifest" do 
  it "should be able to parse a manifest" do
    File.open("#{File.dirname(__FILE__)}/manifest_org.eclipse.compare.MF") do |file|
      manifest = Manifest.new(file.read)
      manifest.sections.first["Manifest-Version"].keys[0].should == "1.0"
      manifest.sections.first["Bundle-SymbolicName"]["org.eclipse.compare"]["singleton"].should == "true"
      manifest.sections.first["Require-Bundle"]["org.eclipse.ui"]["bundle-version"].should == "\"[3.3.0,4.0.0)\""
      manifest.sections.first["Require-Bundle"]["org.eclipse.core.resources"]["bundle-version"].should == "\"[3.3.0,4.0.0)\""
      manifest.sections.first["Require-Bundle"]["org.eclipse.core.expressions"]["bundle-version"].should == "\"[3.2.0,4.0.0)\""
    end
  end

end
