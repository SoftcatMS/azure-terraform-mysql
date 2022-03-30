variable "name" {
  description = "Name of the MySQL Server. Changing this forces a new resource to be created"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the application ressource group, herited from infra module"
  type        = string
}

variable "location" {
  description = "Azure location for Key Vault."
  type        = string
}

variable "administrator_login" {
  description = "MySQL administrator login"
  type        = string
}

variable "administrator_login_password" {
  description = "MySQL administrator password. Strong Password: https://docs.microsoft.com/en-us/sql/relational-databases/security/strong-passwords?view=sql-server-2017"
  type        = string
}

variable "storage_mb" {
  description = "Max storage allowed for a server. Possible values are between 5120 MB(5GB) and 1048576 MB(1TB) for the Basic SKU and between 5120 MB(5GB) and 4194304 MB(4TB) for General Purpose/Memory Optimized SKUs."
  type        = number
  default     = 5120
}

variable "sku_name" {
  type        = string
  description = "Azure database for MySQL sku name"
  default     = "GP_Gen5_2"
}

variable "mysql_version" {
  type        = string
  default     = "5.7"
  description = "Valid values are 5.6 and 5.7"
}

variable "auto_grow_enabled" {
  description = "Enable/Disable auto-growing of the storage."
  type        = bool
  default     = false
}

variable "backup_retention_days" {
  description = "Backup retention days for the server, supported values are between 7 and 35 days."
  type        = number
  default     = 10
}

variable "create_mode" {
  description = "The creation mode. Can be used to restore or replicate existing servers. Possible values are Default, Replica, GeoRestore, and PointInTimeRestore."
  type        = string
  default     = "Default"
}

variable "creation_source_server_id" {
  description = "For creation modes other than Default. The source server ID to use."
  type        = string
  default     = null
}

variable "geo_redundant_backup_enabled" {
  description = "Turn Geo-redundant server backups on/off. Not available for the Basic tier."
  type        = bool
  default     = true
}

variable "encryption_enabled" {
  description = "Whether or not infrastructure is encrypted for this server. Defaults to false. Changing this forces a new resource to be created."
  type        = bool
  default     = true
}

variable "public_access" {
  description = "Whether or not public network access is allowed for this server. Defaults to true."
  type        = bool
  default     = false
}

variable "restore_point_in_time" {
  description = "When create_mode is PointInTimeRestore, specifies the point in time to restore from creation_source_server_id."
  type        = string
  default     = null
}

variable "force_ssl" {
  type        = bool
  default     = true
  description = "Force usage of SSL"
}

variable "ssl_minimal_tls_version_enforced" {
  description = "The minimum TLS version to support on the sever. Possible values are TLSEnforcementDisabled, TLS1_0, TLS1_1, and TLS1_2. Defaults to TLSEnforcementDisabled."
  type        = string
  default     = "TLS1_2"
}

variable "random_suffix" {
  description = "Boolean flag which controls if random string appened to name."
  type        = bool
  default     = false
}

variable "enable_threat_detection_policy" {
  description = "Threat detection policy configuration for MySQL Server Security Alerts Policy"
  default     = false
}

variable "threat_detection_disabled_alerts" {
  description = "Specifies an array of alerts that are disabled. Allowed values are: Sql_Injection, Sql_Injection_Vulnerability, Access_Anomaly, Data_Exfiltration, Unsafe_Action."
  type        = list(any)
  default     = []
}

variable "threat_detection_log_retention_days" {
  description = "Specifies the number of days to keep in the Threat Detection audit logs"
  default     = "30"
}

variable "threat_detection_email_addresses_for_alerts" {
  description = "A list of email addresses which alerts should be sent to."
  type        = list(any)
  default     = []
}

variable "threat_detection_primary_access_key" {
  description = "Stroage Account Primary Access Key."
  type        = string
  default     = ""
}

variable "threat_detection_primary_blob_endpoint" {
  description = "Stroage Account Primary Endpoint."
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to apply to all resources created."
  type        = map(string)
  default     = {}
}

variable "databases" {
  description = "Databases to be deployed on Mysql instance."
  type = map(object({
    resource_group_name = string
    charset             = string
    collation           = string
  }))
  default = {}
}
