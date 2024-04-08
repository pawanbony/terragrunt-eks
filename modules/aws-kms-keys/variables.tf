variable "keys" {
  type = map(any)

  # Example:
  # keys = {
  #   "alias/key1" = {
  #     description             = "Example key1",
  #     deletion_window_in_days = 10,
  #     key_usage               = "ENCRYPT_DECRYPT",
  #     enable_key_rotation     = true,
  #     policy                  = {},
  #     multi_region            = true,
  #     tags                    = {}
  #   },
  #   "alias/key2" = {
  #     description             = "Example key2",
  #     deletion_window_in_days = 10,
  #     key_usage               = "ENCRYPT_DECRYPT",
  #     enable_key_rotation     = true,
  #     policy                  = {},
  #     multi_region            = true,
  #     tags                    = {}
  #   }
  # }
}
