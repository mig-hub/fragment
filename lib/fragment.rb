class Fragment
  attr_accessor :out

  def self.please(&block); self.new(&block).out; end

  def initialize(&block)
    @out = ""
    instance_eval(&block) if block_given?
  end

  def method_missing(meth, args={}, &block); tag(meth, args, &block); end

  def tag(name, attributes={})
    @out << "<#{name}"
    if attributes.kind_of?(String)
      @out << ' ' << attributes
    else
      @out << attributes.delete_if{|k,v| v.nil? or v==false }.map{|(k,v)| " #{k}='#{_fragment_escape_entities(v)}'" }.join
    end
    if block_given?
      @out << ">"
      text = yield
      @out << text.to_str if text != @out and text.respond_to?(:to_str)
      @out << "</#{name}>"
    else
      @out << ' />'
    end
  end

  def _fragment_escape_entities(s)
    s.to_s.gsub(/&/, '&amp;').gsub(/"/, '&quot;').gsub(/'/, '&apos;').gsub(/</, '&lt;').gsub(/>/, '&gt;')
  end
  
  # Override Kernel methods
  def p(args={}, &block); tag(:p, args, &block); end
  def select(args={}, &block); tag(:select, args, &block); end
  
  # More
  def write(s=''); @out << s; end
  def doctype; write "<!DOCTYPE html>\n"; end
  def comment(s=''); write "\n<!-- #{s} -->\n"; end

end