class Xinge::Tag < Xinge::Base
  
  def initialize app_id, secret_id
    super(app_id, secret_id, "/device/tag")
  end

  def add_single_tag platform, tag, token
    json = add_or_del_single_tag platform, [tag], [token], 1
    execute(json)
  end

  def del_single_tag platform, tag, token
    json = add_or_del_single_tag platform, [tag], [token], 2
  end

  def batch_add_tags platform, tags, tokens
    json = add_or_del_multi_tags platform, tags, tokens, 3
  end

  def batch_del_tags platform, tags, tokens
    json = add_or_del_multi_tags platform, tags, tokens, 4
    execute(json)
  end

  def del_tags_by_token platform, token
    json = del_or_update_tags_by_token(platform, nil, token, 5)
    execute(json)
  end

  def coverage_tags_by_token platform, tags, token
    validate_is_array tags, "tags"
    json = del_or_update_tags_by_token(platform, tags, token, 6)
    execute(json)
  end

  def add_single_tag_for_multi_tokens platform, tag, tokens
    json = add_or_del_single_tag_for_multi_tokens(platform, tag, tokens, 7)
    execute(json)
  end

  def del_single_tag_for_multi_tokens platform, tag, tokens
    json = add_or_del_single_tag_for_multi_tokens(platform, tag, tokens, 8)
    execute(json)
  end

  def batch_add_tag_token_list platform, tag_token_list
    json = add_or_del_batch_tags(platform, tag_token_list, 9)
    execute(json)
  end

  def batch_del_tag_token_list platform, tag, tokens
    json = add_or_del_batch_tags(platform, tag_token_list, 10)
    execute(json)
  end

  private
    def tag_common_hash platform, tag, token, operator_type
      { 
        operator_type: operator_type,
        platform: platform,
        tag_list: tag,
        token_list: token
      }
    end

    def add_or_del_single_tag platform, tag, token, operator_type
      validate_is_blank tag, "tag"
      validate_is_blank token, "token"
      validate_lenght tag, 50, "tag"
      validate_lenght token, 64, "token"
      tag_common_hash platform, [tag], [token], operator_type
    end

    def add_or_del_multi_tags platform, tags, tokens, operator_type
      validate_is_array tags, "tags"
      validate_is_array tokens, "tokens"
      validate_is_blank tags, "tags"
      validate_is_blank tokens, "tokens"
      validate_lenght tags, 20, "tags"
      validate_lenght tokens, 20, "tokens"
      tag_common_hash platform, tags, tokens, operator_type
    end

    def del_or_update_tags_by_token platform, tags, token, operator_type
      validate_is_blank token, "token"
      validate_lenght token, 64, "token"
      tag_common_hash(platform, tags, token, operator_type)
    end

    def add_or_del_single_tag_for_multi_tokens platform, tag, tokens, operator_type
      validate_is_blank tag, "tag"
      validate_is_blank tokens, "tokens"
      validate_lenght tag, 50, "tag"
      validate_lenght tokens, 20, "tokens"
      tag_common_hash platform, tag, token, operator_type
    end

    def add_or_del_batch_tags platform, tag_token_list, operator_type
      validate_is_array tag_token_list, "tag_token_list"
      validate_is_blank tag_token_list, "tag_token_list"
      validate_lenght tag_token_list, 20, "tag_token_list"
      {   
        operator_type: operator_type,
        platform: platform,
        tag_token_list:  tag_token_list
      }
    end

end