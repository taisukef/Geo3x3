;;; Code:

(require 'geo3x3 (expand-file-name "geo3x3" default-directory))

(message "encode: %s" (geo3x3-encode 35.65858 139.745433 14))

(pcase (geo3x3-decode "E9139659937288")
  (`(,lat ,lng ,level ,unit)
   (message "lat:%s lng:%s level:%d unit:%s" lat lng level unit)))

(pcase (geo3x3-decode "W9")
  (`(,lat ,lng ,level ,unit)
   (message "lat:%s lng:%s level:%d unit:%s" lat lng level unit)))

;;; simple_geo3x3.el ends here
