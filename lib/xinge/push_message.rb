module Xinge
  class PushMessage
    attr_accessor :title, :content, :message_type, :platform, :custom_content, 
          :options, :accept_time, :environment

    def set_title title
      @title = title
      self
    end

    def set_content content
      @content = content
      self
    end

    def set_message_type message_type
      @message_type = message_type
      self
    end

    def set_custom_content
      @custom_content = custom_content
      self
    end

    def set_options options
      @options = options || {}
      self
    end

    def set_accept_time accept_time
      @accept_time = accept_time || []
      self
    end

    def set_environment env
      @environment = env || "dev"
      self
    end

    def notice_json json_mappings
      android_json = {}
      json_mappings.each do |key, default|
        if !(value = @options[key]).nil? && default.nil?
          android_json[key] = value
        else
          android_json[key] = value || default
        end
      end
      android_json
    end

    def build_notice
      raise "must have overridden the method"
    end
  end

  class PushAndroidMessage < PushMessage
    def initialize
      @json_mappings = { n_id: 0, builder_id: 0, 
        ring: 1, ring_raw: "ring", vibrate: 1,
        lights: 1, clearable: 1, icon_type: 0, icon_res: "xg", 
        style_id: 1, action: nil, small_icon: "xg" 
      }
      @platform = "android"
    end

    def build_notice
      { title: @title, content: @content, message_type: @message_type,
        accept_time: @accept_time, android: notice_json(@json_mappings).merge!(@custom_content)
      }
    end
  end

  class PushIosMessage < PushMessage
    def initialize
      @platform = "ios"
    end

    def build_notice
      { title: @title, 
        content: @content,
        ios:{
          aps: { alert: {subtitle: @title},
                badge_type: 5,
                category: "INVITE_CATEGORY"
          },
          custom: @custom_content,
          xg: "oops"
        }
      }
    end
  end
end