class ParsedFile

  attr_reader   :path_to_file
  attr_accessor :lines_of_code

  def initialize(path_to_file: path_to_file)
    @path_to_file = path_to_file
    @lines_of_code = []
    parse!
  end

  def class_name
    @class_name ||= analyzer.class_name
  end

  def methods
    @methods ||= analyzer.methods
  end

  private

  def analyzer
    @analyzer ||= Analyzer.new(content)
  end

  def content
    @content ||= File.open(path_to_file, "r").read
  end

  def parse!
    return @source if @source
    end_pos = 0
    @source = File.readlines(self.path_to_file).each_with_index do |line, index|
      start_pos = end_pos + 1
      end_pos += line.size
      self.lines_of_code << LineOfCode.new(line_number: index + 1, range: (start_pos..end_pos))
      line
    end.join
  end

end