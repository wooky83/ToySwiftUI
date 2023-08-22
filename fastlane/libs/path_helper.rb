module PathHelper
    extend self
  
    def derived_data_path
      File.join(output_directory, "DerivedData")
    end
  
    def output_directory
      ENV['OUTPUT_DIR']
    end
  
  end