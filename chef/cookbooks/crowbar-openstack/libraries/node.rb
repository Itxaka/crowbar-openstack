class Chef
  class Node
    def construct_attributes
      CrowbarAttrs.new(self, normal_attrs, default_attrs, override_attrs, automatic_attrs)
    end
  end
end

class CrowbarAttrs < Chef::Node::Attribute
  def initialize(node, normal, default, override, automatic, state=[])
    # save the node object so we can set the dirty flag
    @node = node
    super( normal, default, override, automatic, state)
  end
  def []=(key, value)
    puts "From CrowbarAttrs, setting #{key} to #{value}"
    puts "Node: #{@node}"
    super
  end
  def [](key)
    puts "getting #{key}"
    super
  end
  def set_value(data_hash, key, value)
    
    super
  end
end