# CreateUnsignedDMG.cmake — build-time unsigned DMG creation
#
# Expected -D inputs:
#   VERSION_VARS_FILE — path to imager_version_vars.cmake
#   APP_NAME          — display name (e.g. "vBase Imager")
#   APP_BUNDLE_PATH   — path to .app bundle
#   BUILD_DIR         — CMAKE_BINARY_DIR
#   FILE_STEM         — DMG file name stem (e.g. "vbase-imager")

include("${VERSION_VARS_FILE}")

set(DMG_PATH "${BUILD_DIR}/${APP_NAME}.dmg")
set(FINAL_DMG_PATH "${BUILD_DIR}/${FILE_STEM}-${IMAGER_VERSION_STR}.dmg")

# The build tree's bundle is named after the CMake target; the DMG carries it
# as "<APP_NAME>.app" beside an Applications link.
set(STAGE_DIR "${BUILD_DIR}/dmg-stage")
file(REMOVE_RECURSE "${STAGE_DIR}")
file(MAKE_DIRECTORY "${STAGE_DIR}")
execute_process(COMMAND ditto "${APP_BUNDLE_PATH}" "${STAGE_DIR}/${APP_NAME}.app"
                RESULT_VARIABLE result)
if(NOT result EQUAL 0)
    message(FATAL_ERROR "ditto failed with exit code ${result}")
endif()
file(CREATE_LINK "/Applications" "${STAGE_DIR}/Applications" SYMBOLIC)

message(STATUS "Creating DMG...")

# macOS 26 deprecated hdiutil create for diskutil image create.  Prefer the
# replacement where it exists; build machines on earlier releases have only the
# original.  ULMO on both paths: diskutil cannot write the UDBZ this asked for
# before, and LZMA is both smaller and what the signed release now ships, so a
# DMG does not change shape with the machine that built it.  Neither tool
# overwrites, so clear the path first rather than relying on hdiutil's -ov.
file(REMOVE "${DMG_PATH}")

execute_process(COMMAND diskutil image
                RESULT_VARIABLE has_diskutil_image
                OUTPUT_QUIET ERROR_QUIET)

if(has_diskutil_image EQUAL 0)
    set(DMG_TOOL "diskutil image create")
    execute_process(
        COMMAND diskutil image create from
            --volumeName "${APP_NAME}"
            --format ULMO
            "${STAGE_DIR}"
            "${DMG_PATH}"
        RESULT_VARIABLE result
    )
else()
    set(DMG_TOOL "hdiutil create")
    execute_process(
        COMMAND hdiutil create
            -volname "${APP_NAME}"
            -srcfolder "${STAGE_DIR}"
            -format ULMO
            "${DMG_PATH}"
        RESULT_VARIABLE result
    )
endif()
if(NOT result EQUAL 0)
    message(FATAL_ERROR "${DMG_TOOL} failed with exit code ${result}")
endif()

message(STATUS "Creating versioned DMG at ${FINAL_DMG_PATH}...")
file(RENAME "${DMG_PATH}" "${FINAL_DMG_PATH}")
file(REMOVE_RECURSE "${STAGE_DIR}")
