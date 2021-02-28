/**
 * @file geo3x3.h  Geo3x3 C Implentation
 *
 * Copyright (C) 2021 Taisuke Fukuno
 * Copyright (C) 2021 Kristopher Tate
 *
 * Released under CC0 License
 * <https://creativecommons.org/publicdomain/zero/1.0/legalcode>
 *
 */

#ifndef GEO3X3_H
#define GEO3X3_H

#ifdef __cplusplus
extern "C"
{
#endif

#include <stdint.h>
#include <string.h> /**< strlen */

struct geo3x3_wgs84 {
  double lat; /**< latitude in WGS84 */
  double lng; /**< latitude in WGS84 */
  uint8_t level; /**< level of detail */
  double unit; /**< unit of detail */

  size_t err_loc; /**< on error: location of error from input */
};

enum GEO3X3_RES {
  GEO3X3_OK = 0,
  GEO3X3_NULL_PTR = 1,
  GEO3X3_INV_LEVEL = 2,
  GEO3X3_INV_CODE = 3,
  GEO3X3_INV_LENGTH = 4,
};

/**
 * Encodes geo3x3 code from WGS84 coordinate system
 *
 * @param lat latitude in WGS84 format
 * @param lng longitude in WGS84 format
 * @param level integer greater than 0; a larger number encodes better detail
 * @param result pointer to result byte array
 * @param result_len length of result byte array
 *
 * @return `GEO3X3_OK` on success; see `enum GEO3X3_RES`;
 */
enum GEO3X3_RES
geo3x3_from_wgs84 (
  double lat,
  double lng,
  uint8_t level,
  uint8_t *result,
  size_t *result_len
) {
  uint8_t idx = 0;
  double unit = 180.0;

  if (level < 1) {
    return GEO3X3_INV_LEVEL;
  }

  if (NULL == result) {
    if (result_len) {
      *result_len = level;
      return GEO3X3_OK;
    } else {
      return GEO3X3_NULL_PTR;
    }
  } else if (NULL == result_len) {
    return GEO3X3_NULL_PTR;
  }

  if (*result_len < level) {
    return GEO3X3_INV_LENGTH;
  }

  if (lng < 0) {
    result[idx] = 'W';
    lng += 180.0;
  } else {
    result[idx] = 'E';
  }

  idx++;
  lat += 90.0;
  
  int x, y;
  for (int i = 1; i < level; i++) {
    unit /= 3;
    x = (int)(lng / unit);
    y = (int)(lat / unit);
    result[idx++] = '0' + x + (y * 3) + 1;
    lng -= x * unit;
    lat -= y * unit;
  }
  *result_len = idx;
  return GEO3X3_OK;
}

/**
 * Encodes geo3x3 code from WGS84 coordinate system
 *
 * @param lat latitude in WGS84 format
 * @param lng longitude in WGS84 format
 * @param level integer greater than 0; a larger number encodes better detail
 * @param result pointer to null-terminated string array; a null byte terminator will be placed at the end of the result
 * @param result_len length of null-terminated result byte array; must be at least `level` + 1
 *
 * @return `GEO3X3_OK` on success; see `enum GEO3X3_RES`;
 */
enum GEO3X3_RES
geo3x3_from_wgs84_str (
  double lat,
  double lng,
  uint8_t level,
  char *result,
  size_t result_len
) {
  enum GEO3X3_RES err = GEO3X3_OK;
  size_t _res_len = result_len - 1;
  if ((err = geo3x3_from_wgs84(lat, lng, level, (uint8_t *)result, &_res_len))) {
    return err;
  }
  result[_res_len] = 0;
  return err;
}

/**
 * Decodes geo3x3 code into WGS84 coordinate system
 *
 * @param code geo3x3 code
 * @param code_len length of geo3x3 code in bytes
 * @param res result struct in WGS84 format;
 *
 * @return `GEO3X3_OK` on success; see `enum GEO3X3_RES`;
 */
enum GEO3X3_RES
geo3x3_to_wgs84 (
  const uint8_t *code,
  size_t code_len,
  struct geo3x3_wgs84 *res
) {
  double unit = 180.0;
  double lat = 0.0;
  double lng = 0.0;

  if (NULL == code) {
    return GEO3X3_NULL_PTR;
  }

  if (code_len < 1) {
    return GEO3X3_INV_LENGTH;
  }

  if (NULL == res) {
    return GEO3X3_NULL_PTR;
  }

  int n;
  const uint8_t *p = (code + 1);
  while (1) {
    if ((uintptr_t)(p - code) == code_len)
      break;

    if (*p < '1' || *p > '9') {
      res->err_loc = (p - code);
      return GEO3X3_INV_CODE;
    }

    n = *p - '0' - 1;

    unit /= 3;
    lng += (n % 3) * unit;
    lat += (int)(n / 3) * unit;
    p++;
  }

  lat += unit / 2;
  lng += unit / 2;
  lat -= 90.0;
  
  switch (code[0]) {
    case 'E':
      break;
    case 'W':
      lng -= 180.0;
      break;
    default:
      res->err_loc = 0;
      return GEO3X3_INV_CODE;
  }

  res->lat = lat;
  res->lng = lng;
  res->level = (p - code);
  res->unit = unit;

  return GEO3X3_OK;
}

/**
 * Decodes geo3x3 code into WGS84 coordinate system
 *
 * @param code_str geo3x3 code as null-terminated string
 * @param res result struct in WGS84 format;
 *
 * @return `GEO3X3_OK` on success; see `enum GEO3X3_RES`;
 */
enum GEO3X3_RES
geo3x3_to_wgs84_str (
  const char *code_str,
  struct geo3x3_wgs84 *res
) {
  enum GEO3X3_RES err = GEO3X3_OK;
  if ((err = geo3x3_to_wgs84((const uint8_t *)code_str, strlen(code_str), res))) {
    return err;
  }
  return err;
}

#ifdef __cplusplus
} //X:E extern "C"
#endif

#endif //X:E GEO3X3_H
