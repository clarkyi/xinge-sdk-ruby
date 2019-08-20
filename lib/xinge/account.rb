module Xinge
  module Account 
    class Operator < Xinge::Base

      def initialize app_id, secret_id
        super(app_id, secret_id, "/device/account/batchoperate")
      end
      
      def append_account platform, token_accounts
        validate_is_array token_accounts, "token_accounts"
        json = do_deal_account 1, platform, token_accounts
        execute(json)
      end

      def cover_account platform, token_accounts
        validate_is_array token_accounts, "token_accounts"
        json = do_deal_account 2, platform, token_accounts
        execute(json)
      end

      def del_account platform, token_accounts
        validate_is_array token_accounts, "token_accounts"
        json = do_deal_account 3, platform, token_accounts
        execute(json)
      end

      def del_all_account platform, tokens
        validate_is_array tokens, "tokens"
        execute({ operator_type: 4, platform: platform, token_list: tokens })
      end

      def del_all_token platform, accounts
        validate_is_array accounts, "accounts"
        execute({ operator_type:5, platform: platform, account_list: accounts })
      end

      private
        def do_deal_account operator_type, platform, data
          {
            operator_type: operator_type,
            platform: platform,
            token_accounts: data
          }
        end
    end

    class Selector < Xinge::Base
      def initialize app_id, secrete_id
        super(app_id, secrete_id, "/device/account/query")
      end

      def batch_sel_account_bind_token_relation platform, account_list
        validate_is_array account_list, "account_list"
        execute({ operator_type: 1, platform: platform, account_list: account_list })
      end

      def batch_sel_token_bind_account_relation platform, tokens
        validate_is_array tokens, "token_list"
        execute({ operator_type: 2, platform: platform, token_list: tokens })
      end
    end
  end
end