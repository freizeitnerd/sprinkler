require 'logger'
def init_logger(output = nil)
  if output.nil?
    logfile_path = [__dir__, "../../log/sprinkler.log"].join("/")
    puts "Log to file #{logfile_path}"
    logger = Logger.new(logfile_path)
  else
    logger = Logger.new(output)
  end
  
  logger
end