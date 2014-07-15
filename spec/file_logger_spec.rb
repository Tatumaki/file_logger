require 'spec_helper'

describe FileLogger do
  it 'has a version number' do
    expect(FileLogger::VERSION).not_to be nil
  end
  
  it 'can be create STDOUT as log file' do
    logger = FileLogger.new
    logger.puts "SOMETHING ELSE"
    path = logger.get
    logger.close
    expect(File.exist?("STDOUT.log")).not_to be false
    File.delete path
  end
end
