module BackPorts
# Backports
# Stuff we need, but can't get on every Ruby version.
# Included at ApplicationController

  unless Hash.method_defined? :to_h
    class Hash
      def to_h
        self.class == Hash ? self : {}.replace(self)
      end
    end
  end

end
