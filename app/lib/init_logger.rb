require 'logger'
def init_logger(output = nil)
  if output.nil?
    logger = Logger.new(output)
  else
    logfile_path = [__dir__, "../../log/sprinkler.log"].join("/")
    logger = Logger.new(logfile_path)
  end
  
  logger
end