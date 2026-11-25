#ifndef CONFIG_H
#define CONFIG_H

/*
 * SPDX-License-Identifier: Apache-2.0
 * Copyright (C) 2020-2025 Raspberry Pi Ltd
 */


/* Repository URL: vBase installer releases only (vBase Imager fork).
 * Override at runtime with the VBASE_IMAGER_OSLIST_URL environment variable. */
#define OSLIST_URL                              "https://raw.githubusercontent.com/MSNFernando/vbase-releases/main/os_list.json"

/* Custom repository manifest file extension (without leading dot) */
#define MANIFEST_EXTENSION                      "vbase-imager-manifest"

/* MIME type for manifest files */
#define MANIFEST_MIME_TYPE                      "application/vnd.onecomet.vbase-imager-manifest+json"

/* Time synchronization URL (only used on linuxfb QPA platform, URL must be HTTP) */
#define TIME_URL                                "http://github.com/"

/* Raspberry Pi Connect API */
#define CONNECT_API_URL                         "https://api.connect.raspberrypi.com"

/* Client ID issued to Imager for the Connect device-code sign-in (embedded
 * mode, which has no browser for the usual sign-in). The API answers 401 to
 * an ID it does not know. */
#define CONNECT_DEVICE_CLIENT_ID                "F0245915-2B1C-4FB4-86BC-15AEA995FE62"

/* Download-stats telemetry: compiled out in vBase Imager (see
 * IMAGER_TELEMETRY_COMPILED_OUT in CMakeLists.txt), so there is no endpoint. */
#define TELEMETRY_URL                           ""

/* Hash algorithm for verifying (uncompressed image) checksum */
#define OSLIST_HASH_ALGORITHM                   QCryptographicHash::Sha256

/* Update progressbar every 0.1 second */
#define PROGRESS_UPDATE_INTERVAL                100

/* Default block size for buffer allocation (dynamically adjusted at runtime) */
#define IMAGEWRITER_BLOCKSIZE                   1*1024*1024

/* Enable caching */
#define IMAGEWRITER_ENABLE_CACHE_DEFAULT        true

/* Do not cache if it would bring free disk space under 5 GB */
#define IMAGEWRITER_MINIMAL_SPACE_FOR_CACHING   5*1024*1024*1024ll

#endif // CONFIG_H
