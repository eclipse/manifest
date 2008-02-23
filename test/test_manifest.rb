require File.dirname(__FILE__) + '/test_helper.rb'


describe "Able to parse a manifest" do 
  it "should be able to parse a manifest" do
    File.open("manifest_org.eclipse.compare.MF") do |file|
      manifest = Manifest.new(file.read)
      manifest.sections.first["Manifest-Version"].keys[0].should == "1.0"
      manifest.sections.first["Bundle-SymbolicName"]["org.eclipse.compare"]["singleton"].should == "true"
    end
  end

end
