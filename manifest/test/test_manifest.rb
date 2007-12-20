require File.dirname(__FILE__) + '/test_helper.rb'


describe "Able to parse a manifest" do 
  it "should be able to parse a manifest" do
    manifest = Manifest.new
    text = 
"Manifest-Version: 1.0\n
Bundle-ManifestVersion: 2\n
Bundle-Name: %pluginName\n
Bundle-SymbolicName: org.eclipse.stp.bpmn; singleton:=true\n
Bundle-Version: 1.1.0.000\n
Bundle-Vendor: %providerName\n
Bundle-Localization: plugin\n
Export-Package: org.eclipse.stp.bpmn,\n
 org.eclipse.stp.bpmn.util\n
Eclipse-LazyStart: true\n
Require-Bundle: org.eclipse.core.runtime,\n
 org.eclipse.emf.ecore.xmi;visibility:=reexport,\n
 org.eclipse.emf.ecore;visibility:=reexport,\n
 org.eclipse.gmf.runtime.emf.core;visibility:=reexport\n
Bundle-RequiredExecutionEnvironment: J2SE-1.5\n"
    manifest.parse(text)
    manifest.entries["Manifest-Version"].should == "1.0"
  end

end