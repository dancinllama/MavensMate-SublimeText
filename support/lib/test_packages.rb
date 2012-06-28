#!/usr/bin/env ruby -W0
MM_ROOT = File.dirname(__FILE__)
require MM_ROOT + '/test_helper'

client = TestHelper.login('joe@secondopinion.com.plsasmtdev', 'skins3gibbs', 'test')
zip = client.retrieve({
  :body => "<RetrieveRequest><packageNames>Pulse</packageNames><unpackaged><types><members>*</members><name>ApexClass</name></types></unpackaged><apiVersion>24.0</apiVersion></RetrieveRequest>"  
}) 

File.open('/Users/josephferraro/Desktop/metadata.zip', 'wb') {|f| f.write(Base64.decode64(zip))}
Zip::ZipFile.open('/Users/josephferraro/Desktop/metadata.zip') { |zip_file|
    zip_file.each { |f|
      f_path=File.join('/Users/josephferraro/Desktop', f.name)
      FileUtils.mkdir_p(File.dirname(f_path))
      zip_file.extract(f, f_path) unless File.exist?(f_path)
    }
  }
 


