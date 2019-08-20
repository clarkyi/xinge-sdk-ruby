# xinge sdk 
  信鸽API v3

### Account 相关操作API
##### 相关接口及方法
- Token 追加设置 Account 
  - append_account(platform, token_accounts)
- Token 覆盖设置 Account 
  - cover_account(platform, token_accounts)
- Token 删除绑定 Account 
  - del_account(platform, token_accounts)
- Token 删除所有绑定 Account
  - del_all_account(platform, token_accounts)
- Account 删除所有绑定 Token
  - del_all_token(platform, accounts)
- 批量查询Account绑定的token关系
  - batch_sel_account_bind_token_relation(platform, account_list)
- 批量查询Token 绑定的Account关系
  - batch_sel_token_bind_account_relation(platform, tokens)

##### 使用
  ```
  //token追加设置account
  operator = Xinge::Account::Operator.new(app_id, secret_id)
  operator.append_account(platform, token_accounts)

  //批量查询账号绑定token关系
  selector = Xinge::Account::Selector.new(app_id, secret_id)
  selector.batch_sel_account_bind_token_relation(platform, account_list)

  ...
  ```
### Tag 相关API
##### 相关接口及方法
- 增加单个tag
  - add_single_tag platform, tag, token
- 删除单个tag
  - del_single_tag platform, tag, token
- 增加多个tag
  - batch_add_tags platform, tags, tokens
- 删除多个tag
  - batch_del_tags platform, tags, tokens
- 删除所有tag
  - del_tags_by_token platform, token
- 更新tag
  - coverage_tags_by_token platform, tags, token
- 多个token设置tag
  - add_single_tag_for_multi_tokens platform, tag, tokens
- 多个token删除tag
  - del_single_tag_for_multi_tokens platform, tag, tokens
- 批量设置标签
  - batch_add_tag_token_list platform, tag_token_list
- 批量删除标签
  - batch_del_tag_token_list platform, tag, tokens

##### 使用
  ```
  //增加单个tag
  tag = Xinge::Tag(app_id, secret_id)
  tag.add_single_tag(platform, tag, token)
  //删除单个tag
  tag.del_single_tag(platform, tag, token)
  ...
  ```
### Push相关API
##### 相关接口及方法
- 全量推送
  - push_all(push_message)
- 标签推送
  - push_by_tag push_message, tags
- 单设备推送
  - push_single_deivce push_message, token
- 设备列表推送
  - push_by_token_list push_message, tokens
- 单账号推送
  - push_single_account push_message, account
- 账号列表推送
  - push_by_account_list push_message, accounts

##### 使用
  ```
  //全量推送
  push_message = Xinge::PushAndroidMessage.new
  push_message.set_title("push title").set_content("push content").set_message_type("type")
  .set_custom_content("custom content json").set_options("android action options")
  
  push = Xinge::Push.new
  push.push_all(push_message)

  push_message1 = Xinge::PushAndroidMessage.new
  push_message1.set_title("push title").set_content("push content").set_message_type("type")
  .set_custom_content("custom content json")
  
  push_ios = Xinge::Push.new
  push_ios.push_all(push_message1)
  
  ...
  ```