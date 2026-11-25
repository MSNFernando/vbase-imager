/*
 * SPDX-License-Identifier: Apache-2.0
 * Copyright (C) 2025 Raspberry Pi Ltd
 */

pragma Singleton

import QtQuick
import RpiImager

Item {
    id: root

    // === TEXT SCALING ===
    // Platform text-scaling factor (1.0 = default, 1.5 = 150%, etc.)
    // Reflects OS-level accessibility preferences (Windows "Make text bigger",
    // GNOME text-scaling-factor, etc.) that Qt QML does not honour automatically.
    // DPI normalization is handled by Qt via font.pointSize + screen logical DPI.
    readonly property real textScale: PlatformHelper.textScaleFactor

    // Font-specific scale: DPI correction (72/96 on Windows/Linux, 1.0 on macOS)
    // multiplied by the accessibility text scale. Applied only to font sizes so
    // that layout, spacing, and button sizes are unaffected.
    readonly property real fontScale: PlatformHelper.fontDpiCorrection * textScale

    // Scale a base value by the text scaling factor, rounding to nearest int.
    function scaled(base) { return Math.round(base * textScale) }

    // === vBase Imager design tokens (Unicron Group Design System, light) ===
    readonly property color primaryColor: "#3f6212"
    readonly property color primaryForegroundColor: "#ffffff"
    readonly property color cardBackgroundColor: "#ffffff"
    readonly property color backgroundSubtleColor: "#f7f8f4"
    readonly property color foregroundColor: "#17221a"
    readonly property color foregroundSecondaryColor: "#3d4740"
    readonly property color mutedForegroundColor: "#5c665e"
    readonly property color mutedColor: "#eef0ea"
    readonly property color accentColor: "#ecf6dc"
    readonly property color borderColor: "#e3e6df"
    readonly property color borderSubtleColor: "#eef0ea"
    readonly property color controlBorderColor: "#d5dbd0"
    readonly property color inverseColor: "#17221a"
    readonly property color inverseForegroundColor: "#ffffff"
    readonly property color successColor: "#65a30d"
    readonly property color successSubtleColor: "#dcfce7"
    readonly property color successForegroundColor: "#14532d"
    readonly property color warningColor: "#d97706"
    readonly property color dangerColor: "#dc2626"
    readonly property color dangerSubtleColor: "#fee2e2"
    readonly property color dangerForegroundColor: "#7f1d1d"
    readonly property color infoColor: "#4f46e5"
    readonly property int radiusSm: 6
    readonly property int radiusMd: 8
    readonly property int radiusControl: 9
    readonly property int radiusXl: 12
    readonly property string fontFamilyMono: Qt.platform.os === "windows" ? "Consolas"
                                           : (Qt.platform.os === "osx" ? "Menlo" : "monospace")

    // === COLORS ===
    readonly property color mainBackgroundColor: "#ffffff"
    // vBase Imager: the upstream accent name is kept (it is used everywhere);
    // its value is the Unicron primary.
    readonly property color raspberryRed: primaryColor
    readonly property color transparent: "transparent"

    readonly property color buttonBackgroundColor: mainBackgroundColor
    readonly property color buttonForegroundColor: raspberryRed
    readonly property color buttonFocusedBackgroundColor: accentColor
    readonly property color buttonHoveredBackgroundColor: backgroundSubtleColor

    readonly property color button2BackgroundColor: raspberryRed
    readonly property color button2ForegroundColor: mainBackgroundColor
    // Focused: noticeably darker for strong state indication (keyboard focus)
    readonly property color button2FocusedBackgroundColor: "#2f4a0d"
    // Hovered: noticeably lighter to differentiate from base (≥4.5:1 contrast vs base)
    readonly property color button2HoveredBackgroundColor: accentColor
    // Hovered foreground should be Raspberry Red for ≥4.5:1 contrast on the light hover bg
    readonly property color button2HoveredForegroundColor: raspberryRed
    readonly property color raspberryRedHighlight: successColor

    readonly property color titleBackgroundColor: backgroundSubtleColor
    readonly property color titleSeparatorColor: controlBorderColor
    readonly property color popupBorderColor: borderColor

    readonly property color listViewRowBackgroundColor: "#ffffff"
    readonly property color listViewHoverRowBackgroundColor: titleBackgroundColor
    // Selection highlight color for OS/device lists
    readonly property color listViewHighlightColor: accentColor

    // Utility translucent colors
    readonly property color translucentWhite10: Qt.rgba(255, 255, 255, 0.1)
    readonly property color translucentWhite30: Qt.rgba(255, 255, 255, 0.3)

    // descriptions in list views
    readonly property color textDescriptionColor: foregroundSecondaryColor
    // Sidebar colors
    readonly property color sidebarActiveBackgroundColor: raspberryRed
    readonly property color sidebarTextOnActiveColor: "#FFFFFF"
    readonly property color sidebarTextOnInactiveColor: raspberryRed
    readonly property color sidebarTextDisabledColor: "#E0E0E0"
    // Sidebar controls
    readonly property color sidebarControlBorderColor: "#767676"
    readonly property color sidebarBackgroundColour: mainBackgroundColor
    readonly property color sidebarBorderColour: raspberryRed

    // OS metadata
    readonly property color textMetadataColor: mutedForegroundColor

    // for the "device / OS / storage" titles
    readonly property color subtitleColor: "#ffffff"

    readonly property color progressBarTextColor: "white"
    readonly property color progressBarVerifyForegroundColor: successColor
    readonly property color progressBarBackgroundColor: raspberryRed
    // New: distinct colors for writing vs verification phases
    readonly property color progressBarWritingForegroundColor: raspberryRed
    readonly property color progressBarTrackColor: titleBackgroundColor

    readonly property color lanbarBackgroundColor: "#ffffe3"

    /// the check-boxes/radio-buttons have labels that might be disabled
    readonly property color formLabelColor: foregroundColor
    readonly property color formLabelErrorColor: dangerColor
    readonly property color formLabelDisabledColor: "#8a958c"
    // Active color for radio buttons, checkboxes, and switches
    readonly property color formControlActiveColor: primaryColor

    readonly property color embeddedModeInfoTextColor: "#ffffff"

    // Focus/outline
    readonly property color focusOutlineColor: primaryColor
    readonly property int focusOutlineWidth: 2
    readonly property int focusOutlineRadius: 4
    readonly property int focusOutlineMargin: -4

    // === FONTS ===
    // vBase Imager: Manrope (SIL OFL 1.1, fonts/Manrope-OFL.txt), one variable
    // font for every weight; Roboto stays as the fallback if it fails to load.
    readonly property string fontFamily: manrope.status === FontLoader.Ready ? manrope.name : roboto.name
    readonly property string fontFamilyLight: manrope.status === FontLoader.Ready ? manrope.name : robotoLight.name
    readonly property string fontFamilyBold: manrope.status === FontLoader.Ready ? manrope.name : robotoBold.name

    // Font sizes (point sizes — DPI-aware, scaled by Qt based on screen logical DPI)
    // Additionally scaled by the OS accessibility text-scaling factor.
    // Base scale (single source of truth)
    readonly property real fontSizeXs: Math.round(12 * fontScale)
    readonly property real fontSizeSm: Math.round(14 * fontScale)
    readonly property real fontSizeMd: Math.round(16 * fontScale)
    readonly property real fontSizeXl: Math.round(24 * fontScale)

    // Role tokens mapped to base scale
    readonly property real fontSizeTitle: fontSizeXl
    readonly property real fontSizeHeading: fontSizeMd
    readonly property real fontSizeLargeHeading: fontSizeMd
    readonly property real fontSizeFormLabel: fontSizeSm
    readonly property real fontSizeSubtitle: fontSizeSm
    readonly property real fontSizeDescription: fontSizeXs
    readonly property real fontSizeInput: fontSizeSm
    readonly property real fontSizeCaption: fontSizeXs
    readonly property real fontSizeSmall: fontSizeXs
    readonly property real fontSizeSidebarItem: fontSizeSm

    // === SPACING (scaled by text scale factor) ===
    readonly property int spacingXXSmall: scaled(2)
    readonly property int spacingXSmall: scaled(5)
    readonly property int spacingTiny: scaled(8)
    readonly property int spacingSmall: scaled(10)
    readonly property int spacingSmallPlus: scaled(12)
    readonly property int spacingMedium: scaled(15)
    readonly property int spacingLarge: scaled(20)
    readonly property int spacingExtraLarge: scaled(30)

    // === SIZES (scaled by text scale factor) ===
    readonly property int buttonHeightStandard: scaled(40)
    readonly property int buttonWidthMinimum: scaled(120)
    readonly property int buttonWidthSkip: scaled(150)

    // Wide enough that a resized window gives the form room rather than margins,
    // capped so a maximised window doesn't stretch a single field across the screen.
    readonly property int sectionMaxWidth: scaled(720)
    readonly property int sectionMargins: scaled(24)
    readonly property int sectionPadding: scaled(16)
    readonly property int sectionBorderWidth: 1          // not scaled — visual decoration
    readonly property int sectionBorderRadius: 8         // not scaled — visual decoration
    readonly property int listItemBorderRadius: 5        // not scaled — visual decoration
    readonly property int listItemPadding: scaled(15)
    readonly property int cardPadding: scaled(20)
    readonly property int scrollBarWidth: scaled(10)
    readonly property int sidebarWidth: scaled(200)
    readonly property int sidebarMinWidth: scaled(150)
    readonly property int sidebarMaxWidth: scaled(350)
    readonly property int sidebarDragHandleWidth: scaled(8)
    readonly property color sidebarDragHandleHoverColor: listViewHoverRowBackgroundColor
    readonly property color sidebarDragHandleHoverBackground: Qt.rgba(
        listViewHoverRowBackgroundColor.r,
        listViewHoverRowBackgroundColor.g,
        listViewHoverRowBackgroundColor.b, 0.3)
    readonly property int sidebarItemBorderRadius: 4     // not scaled — visual decoration

    // Embedded (kiosk) mode squares off corners (radius 0) to avoid software-renderer
    // antialiasing artifacts. Fixed for the session, so evaluated once.
    readonly property bool embeddedMode: ImageWriterSingleton.isEmbeddedMode()
    // Corner radius to use, given `normalRadius` as the non-embedded value.
    function cornerRadius(normalRadius) { return embeddedMode ? 0 : normalRadius }
    // Sidebar item heights
    readonly property int sidebarItemHeight: buttonHeightStandard
    readonly property int sidebarSubItemHeight: sidebarItemHeight - scaled(12)

    // === LAYOUT (scaled by text scale factor) ===
    readonly property int formColumnSpacing: scaled(20)
    readonly property int formRowSpacing: scaled(15)
    readonly property int stepContentMargins: scaled(24)
    readonly property int stepContentSpacing: scaled(16)

    // Font loaders
    FontLoader { id: manrope;     source: "fonts/Manrope-Variable.ttf" }
    FontLoader { id: roboto;      source: "fonts/Roboto-Regular.ttf" }
    FontLoader { id: robotoLight; source: "fonts/Roboto-Light.ttf" }
    FontLoader { id: robotoBold;  source: "fonts/Roboto-Bold.ttf" }
}
