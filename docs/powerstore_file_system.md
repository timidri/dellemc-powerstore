Document: "dellemc.swagger"


Path: "tag_based/assets/dellemc.swagger.json")

## File_system

Manage NAS file systems.

```puppet
powerstore_file_system {
  access_policy => "access_policy (optional)",
  default_hard_limit => "default_hard_limit (optional)",
  default_soft_limit => "default_soft_limit (optional)",
  description => "description (optional)",
  expiration_timestamp => "expiration_timestamp (optional)",
  folder_rename_policy => "folder_rename_policy (optional)",
  grace_period => "grace_period (optional)",
  is_async_m_time_enabled => "is_async_MTime_enabled (optional)",
  is_quota_enabled => "is_quota_enabled (optional)",
  is_smb_no_notify_enabled => "is_smb_no_notify_enabled (optional)",
  is_smb_notify_on_access_enabled => "is_smb_notify_on_access_enabled (optional)",
  is_smb_notify_on_write_enabled => "is_smb_notify_on_write_enabled (optional)",
  is_smb_op_locks_enabled => "is_smb_op_locks_enabled (optional)",
  is_smb_sync_writes_enabled => "is_smb_sync_writes_enabled (optional)",
  locking_policy => "locking_policy (optional)",
  name => "name",
  nas_server_id => "nas_server_id (optional)",
  protection_policy_id => "protection_policy_id (optional)",
  size_total => "size_total (optional)",
  smb_notify_on_change_dir_depth => "smb_notify_on_change_dir_depth (optional)",
}
```

| Name        | Type           | Required       |
| ------------- | ------------- | ------------- |
|access_policy | Optional[Enum['Native','UNIX','Windows']] | false |
|default_hard_limit | Optional[Integer[0,9223372036854775807]] | false |
|default_soft_limit | Optional[Integer[0,9223372036854775807]] | false |
|description | Optional[String[0,255]] | false |
|expiration_timestamp | Optional[String] | false |
|folder_rename_policy | Optional[Enum['All_Allowed','SMB_Forbidden','All_Forbidden']] | false |
|grace_period | Optional[Integer[-1,2147483647]] | false |
|is_async_m_time_enabled | Optional[Boolean] | false |
|is_quota_enabled | Optional[Boolean] | false |
|is_smb_no_notify_enabled | Optional[Boolean] | false |
|is_smb_notify_on_access_enabled | Optional[Boolean] | false |
|is_smb_notify_on_write_enabled | Optional[Boolean] | false |
|is_smb_op_locks_enabled | Optional[Boolean] | false |
|is_smb_sync_writes_enabled | Optional[Boolean] | false |
|locking_policy | Optional[Enum['Advisory','Mandatory']] | false |
|name | String[1,255] | true |
|nas_server_id | Optional[String] | false |
|protection_policy_id | Optional[String] | false |
|size_total | Optional[Integer[3221225472,281474976710656]] | false |
|smb_notify_on_change_dir_depth | Optional[Integer[1,512]] | false |



## CRUD operations

Here is a list of endpoints that we use to create, read, update and delete the file_system

| Operation | Path | Verb | Description | OperationID |
| ------------- | ------------- | ------------- | ------------- | ------------- |
|Create|`/file_system`|Post|Create a file system.|file_system_create|
|List - list all|`/file_system`|Get|List file systems.|file_system_collection_query|
|List - get one|`/file_system/%{id}`|Get|Query a specific file system.|file_system_instance_query|
|List - get list using params|``||||
|Update|`/file_system/%{id}`|Patch|Modify a file system.|file_system_modify|
|Delete|`/file_system/%{id}`|Delete|Delete a file system.|file_system_delete|
