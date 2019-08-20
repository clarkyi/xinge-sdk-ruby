class Xinge::Push < Xinge::Base
  def initialize app_id, secret_id
    super(app_id, secret_id, "/device/account/batchoperate")
  end

  def push_all push_message
    json = push_message.build_notice.merge!({audience_type: "all"})
    execute(json)
  end

  def push_by_tag push_message, tags
    json = { audience_type: "tag", tag_list: { tags: tags, op: "AND"}}
    json.merge!(push_message.build_notice)
    execute(json)
  end

  def push_single_deivce push_message, token
    validate_is_blank token, "token"
    json = push_by_token([token])
    json.merge!(push_message.build_notice)
    execute(json)
  end

  def push_by_token_list push_message, tokens
    validate_is_array tokens, "tokens"
    validate_is_blank tokens, "tokens"
    json = push_by_token token
    json.merge!(push_message.build_notice)
    execute(json)
  end

  def push_single_account push_message, account
    validate_is_blank account, "account"
    json = push_by_account account
    json.merge!(push_message.build_notice)
    execute(json)
  end

  def push_by_account_list push_message, accounts
    validate_is_array accounts, "accounts"
    validate_is_blank accounts, "accounts"
    json = push_by_account accounts
    json.merge!(push_message.build_notice)
    execute(json)
  end

  private
    def push_by_token tokens
      { audience_type: "token_list",
        token_list: tokens,
        push_id: "0"
      }
    end

    def push_by_account accounts
      { audience_type: "account_list",
        account_list: accounts,
        push_id: "0"
      }
    end
end