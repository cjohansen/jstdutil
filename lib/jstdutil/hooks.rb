#
# Observer module/hooks module, modeled exactly like
# ZenTest::Autotest, in order to ease porting of addons like autotest-screen
#
# In order to use the hooks module, the including class needs to define an
# AVAILABLE_HOOKS constant hash. The rest is handled by the mixin module.
#
module Hooks
  def self.included(target)
    target.class_eval do
      @@hooks = {}
      target::AVAILABLE_HOOKS.each { |hook| @@hooks[hook] = [] }

      def self.add_hook(hook, &block)
        @@hooks[hook] << block
      end

      def self.hook(hook, *args)
        @@hooks[hook].any? do |plugin|
          plugin[self, *args]
        end
      end

      def hook(hook)
        self.class.hook(hook)
      end
    end
  end
end
