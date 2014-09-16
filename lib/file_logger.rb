require "file_logger/version"

class FileLogger
  attr_accessor :interval, :stdout_limit, :strict_mode

  def initialize(path="./STDOUT.log", autoclose: true)
    @counter = 0
    @interval = 1000
    @mode = "a"
    @stdout_limit = -1
    @strict_mode = false
    self.open(path)

    ObjectSpace.define_finalizer(self, proc{ close }) if autoclose
    puts "---- #{Time.now} ----\n"
  end

  def open(path="./STDOUT.log")
    if path.is_a?(IO)
      @mode = "w"
      @path = './STDOUT.log'
      STDERR.puts 'STDOUT.log / Temporary standard output.'
    else
      @path = path
      @path = "./STDOUT.log" if path.nil?
    end
    @file = File.open(@path,@mode)
    STDERR.puts "FileLogger#Opening '#{@path}'"
  end

  def get
    save
    return @path
  end
  
  def clean
    return if @file.nil?
    STDERR.puts "Delete '#{@path}'"
    File.delete(@path)
    @file = File.open(@path,@mode)
  end
  alias :delete :clean

  def save
    @file.close
    @file = File.open(@path,'a')
    @counter = 0
  end

  def close
    @file.close
    @counter = 0
  end

  def io_puts(string,io=nil)
    return unless io
    io.puts string.to_s[0..@stdout_limit]
  end

  def open_temp
    path = 'temporary'+Time.new.strftime("%Y%m%d%H%M%S").to_s + '.log' 
    STDERR.puts Color.red "opening #{path}"
    open(path)
  end

  def file_check
    if @file.nil?
      raise '[FileLogger] File does not opened!' if @strict_mode
      STDERR.puts Color.red "file does not opened!"
      open_temp
    end
  end

  def puts(string,io=nil)
    file_check
    @file.puts(string.to_s)
    io_puts(string,io)
    count
  end

  def print(string, io=nil)
    file_check
    @file.print(string.to_s)
    io_puts(string,io)
    count
  end
  
  private
  def count
    save if (@counter += 1) == interval
  end
end

