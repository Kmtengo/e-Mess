# e-Mess Design Language Specification

## Overview
This document outlines the design language specifications for the e-Mess POS (Point of Sale) application. The e-Mess app is a Flutter-based Android application designed for self-service ordering systems in mess/cafeteria environments, featuring a vibrant, friendly, and accessible interface.

## Table of Contents
- [Color Palette](#color-palette)
- [Typography](#typography)
- [Spacing & Layout](#spacing--layout)
- [Components](#components)
- [Iconography](#iconography)
- [UI Patterns](#ui-patterns)
- [Accessibility](#accessibility)

---

## Color Palette

### Primary Colors

#### Teal Accent
- **Color**: `Colors.tealAccent`
- **Usage**: Primary background color for app bar, buttons, and accent elements
- **Hex Equivalent**: `#64FFDA` / `#1DE9B6` (depending on brightness)
- **Application**: 
  - AppBar background
  - Confirm order button background
  - Progress indicator accents

```dart
// Example Usage
AppBar(
  backgroundColor: Colors.tealAccent,
)
```

#### Teal
- **Color**: `Colors.teal`
- **Usage**: Tab indicators, button backgrounds, container backgrounds
- **Hex Equivalent**: `#009688`
- **Application**:
  - Tab bar indicator color
  - Confirm order button container

```dart
// Example Usage
TabBar(
  indicatorColor: Colors.teal,
)
```

### Secondary Colors

#### Deep Orange
- **Color**: `Colors.deepOrange`
- **Usage**: Primary accent color for text, icons, and important UI elements
- **Hex Equivalent**: `#FF5722`
- **Application**:
  - App title text
  - Price text
  - Icon colors
  - Button text
  - Progress indicator

```dart
// Example Usage
Text(
  'e-Mess',
  style: TextStyle(
    color: Colors.deepOrange,
    fontWeight: FontWeight.bold,
  ),
)
```

#### Deep Orange Accent
- **Color**: `Colors.deepOrangeAccent`
- **Usage**: Icon highlights and interactive elements
- **Hex Equivalent**: `#FF6E40` / `#FF3D00`
- **Application**:
  - Account icon in app bar

```dart
// Example Usage
Icon(
  Icons.account_circle_rounded,
  color: Colors.deepOrangeAccent,
)
```

### Color Hierarchy
1. **Primary**: Teal/Teal Accent (backgrounds, containers)
2. **Secondary**: Deep Orange (text, icons, accents)
3. **Background**: White/Default Material background
4. **Text**: 
   - Primary: Deep Orange (for prices and emphasis)
   - Secondary: Default black/dark gray (for item names)

---

## Typography

The e-Mess app uses four custom font families, each serving a specific purpose in the interface hierarchy.

### Font Families

#### 1. BungeeSpice
- **File**: `fonts/Bungee_Spice/BungeeSpice-Regular.ttf`
- **Usage**: App branding and primary headlines
- **Characteristics**: Display font, playful, bold, eye-catching
- **Application**:
  - App title in AppBar ("e-Mess")
  - "Confirm Order" button text

```dart
// Example Usage
Text(
  'e-Mess',
  style: TextStyle(
    fontFamily: 'BungeeSpice',
    color: Colors.deepOrange,
    fontSize: 30.0,
    fontWeight: FontWeight.bold,
  ),
)
```

**Specifications**:
- Font Size (AppBar): `30.0`
- Font Size (Buttons): `25.0`
- Font Weight: `FontWeight.bold`
- Color: `Colors.deepOrange`

#### 2. TiltNeon
- **File**: `fonts/Tilt_Neon/TiltNeon-Regular-VariableFont_XROT,YROT.ttf`
- **Usage**: Tab labels and navigation elements
- **Characteristics**: Modern, legible, distinctive
- **Application**:
  - Tab bar labels (Breakfast, Lunch, 4pm Tea, Supper)

```dart
// Example Usage
TabBar(
  labelStyle: TextStyle(
    fontFamily: 'TiltNeon',
    fontWeight: FontWeight.bold,
  ),
)
```

**Specifications**:
- Font Weight: `FontWeight.bold`
- Color (selected): `Colors.deepOrange`
- Used in navigation contexts

#### 3. DancingScript
- **File**: `fonts/Dancing_Script/DancingScript-VariableFont_wght.ttf`
- **Usage**: Menu item names
- **Characteristics**: Handwritten, friendly, casual, approachable
- **Application**:
  - Product names in cards (Tea, Bread, Eggs, etc.)

```dart
// Example Usage
Text(
  'Tea',
  style: TextStyle(
    fontFamily: 'DancingScript',
    fontWeight: FontWeight.w900,
    fontSize: 18.0,
  ),
)
```

**Specifications**:
- Font Size: `18.0`
- Font Weight: `FontWeight.w900`
- Color: Default (black/dark gray)

#### 4. NunitoSans
- **File**: `fonts/Nunito_Sans/NunitoSans-VariableFont_YTLC,opsz,wdth,wght.ttf`
- **Usage**: Price labels and secondary information
- **Characteristics**: Clean, readable, professional
- **Application**:
  - Price text on menu item cards

```dart
// Example Usage
Text(
  'Ksh. 15',
  style: TextStyle(
    fontFamily: 'NunitoSans',
    color: Colors.deepOrange,
    fontWeight: FontWeight.bold,
    fontSize: 8.5,
  ),
)
```

**Specifications**:
- Font Size: `8.5`
- Font Weight: `FontWeight.bold`
- Color: `Colors.deepOrange`

### Typography Scale

| Element | Font Family | Size | Weight | Color |
|---------|-------------|------|--------|-------|
| App Title | BungeeSpice | 30.0 | Bold | Deep Orange |
| Primary Button | BungeeSpice | 25.0 | Bold | Deep Orange |
| Tab Labels | TiltNeon | Default | Bold | Deep Orange (active) |
| Item Names | DancingScript | 18.0 | w900 | Default |
| Prices | NunitoSans | 8.5 | Bold | Deep Orange |

---

## Spacing & Layout

### Grid System
- **Menu Items Grid**: 3 columns (`crossAxisCount: 3`)
- **Main Axis Spacing**: `5.0` - `10.0` dp
- **Cross Axis Spacing**: `5.0` - `10.0` dp

```dart
GridView.count(
  crossAxisCount: 3,
  mainAxisSpacing: 5.0,  // or 10.0 for some tabs
  crossAxisSpacing: 5.0, // or 10.0 for some tabs
)
```

### Padding & Margins

#### Progress Indicator
- **Vertical Padding**: `20.0` dp
- **Horizontal Padding**: `10.0` dp

```dart
Padding(
  padding: const EdgeInsets.symmetric(
    vertical: 20.0,
    horizontal: 10.0,
  ),
)
```

#### Card Content
- **All sides**: `3.0` dp for image containers
- **Text padding**: `EdgeInsets.fromLTRB(8.0, 0.0, 16.0, 0.0)`

```dart
Padding(
  padding: const EdgeInsets.all(3.0),
  child: ClipRRect(
    // Image content
  ),
)
```

### Dimensions

#### Icons
- **AppBar Icons**: `30.0` dp
- **Standard Icons**: Material default

#### Images
- **Card Image Height**: `90.0` dp

#### Buttons
- **Confirm Order Button Height**: `80.0` dp

#### Progress Indicator
- **Min Height**: `8.0` dp

```dart
LinearProgressIndicator(
  minHeight: 8.0,
  borderRadius: BorderRadius.circular(10.0),
)
```

---

## Components

### 1. AppBar

The AppBar serves as the primary navigation header.

**Specifications**:
- Background Color: `Colors.tealAccent`
- Title Alignment: Center
- Leading Icon: Account circle (Deep Orange Accent, 30.0 dp)
- Action Icon: QR Code Scanner (Deep Orange, 30.0 dp)

```dart
AppBar(
  leading: IconButton(
    icon: const Icon(
      Icons.account_circle_rounded,
      color: Colors.deepOrangeAccent,
      size: 30.0,
    ),
  ),
  title: const Text(
    "e-Mess",
    style: TextStyle(
      fontFamily: 'BungeeSpice',
      color: Colors.deepOrange,
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  centerTitle: true,
  backgroundColor: Colors.tealAccent,
  actions: [
    IconButton(
      icon: const Icon(
        Icons.qr_code_scanner_rounded,
        color: Colors.deepOrange,
        size: 30.0,
      ),
    )
  ],
)
```

### 2. Progress Indicator

Visual feedback for the ordering process.

**Specifications**:
- Type: `LinearProgressIndicator`
- Height: `8.0` dp minimum
- Color: `Colors.deepOrange`
- Border Radius: `10.0` dp
- Values: `0.25`, `0.5`, `0.75`, `1.0` (based on step)

```dart
LinearProgressIndicator(
  value: 0.25,  // or 0.5, 0.75, 1.0
  minHeight: 8.0,
  color: Colors.deepOrange,
  borderRadius: BorderRadius.circular(10.0),
)
```

### 3. Tab Bar

Navigation between meal categories.

**Specifications**:
- Indicator Color: `Colors.teal`
- Label Color (Active): `Colors.deepOrange`
- Label Font: TiltNeon, Bold
- Tabs: Breakfast, Lunch, 4pm Tea, Supper

```dart
TabBar(
  indicatorColor: Colors.teal,
  labelColor: Colors.deepOrange,
  labelStyle: const TextStyle(
    fontFamily: 'TiltNeon',
    fontWeight: FontWeight.bold,
  ),
  controller: _tabController,
  tabs: const [
    Tab(text: 'Breakfast'),
    Tab(text: '  Lunch  '),
    Tab(text: '4pm Tea'),
    Tab(text: 'Supper')
  ],
)
```

### 4. Menu Item Card

Individual menu item display component.

**Specifications**:
- Container: `Card` widget
- Button Padding: `EdgeInsets.zero`
- Image Height: `90.0` dp
- Image Border Radius: `15.0` dp
- Layout: Column (image, name, price)

```dart
TextButton(
  onPressed: () {},
  style: TextButton.styleFrom(
    padding: EdgeInsets.zero,
  ),
  child: Card(
    child: Column(
      children: [
        // Image Container
        SizedBox(
          height: 90.0,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset(
                'images/tea.png',
                height: 30.0,
              ),
            ),
          ),
        ),
        // Item Name
        const Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(8.0, 0.0, 16.0, 0.0),
                child: Text(
                  'Tea',
                  style: TextStyle(
                    fontFamily: 'DancingScript',
                    fontWeight: FontWeight.w900,
                    fontSize: 18.0,
                  ),
                ),
              )
            ],
          ),
        ),
        // Price
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(8.0, 0.0, 16.0, 0.0),
              child: Text(
                'Ksh. 15',
                style: TextStyle(
                  fontFamily: 'NunitoSans',
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold,
                  fontSize: 8.5,
                ),
              ),
            )
          ],
        )
      ],
    ),
  ),
)
```

### 5. Confirm Order Button

Primary action button for order confirmation.

**Specifications**:
- Width: Full width
- Height: `80.0` dp
- Background Color: `Colors.teal`
- Border Radius: Top corners `15.0` dp, bottom corners `0.0` dp
- Text Font: BungeeSpice
- Text Color: `Colors.deepOrange`
- Text Size: `25.0` dp
- Text Weight: Bold

```dart
TextButton(
  onPressed: () {},
  child: ClipRRect(
    borderRadius: const BorderRadius.vertical(
      top: Radius.circular(15.0),
      bottom: Radius.circular(0.0),
    ),
    child: Container(
      color: Colors.teal,
      height: 80.0,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Confirm Order',
            style: TextStyle(
              fontFamily: 'BungeeSpice',
              color: Colors.deepOrange,
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
            ),
          )
        ],
      ),
    ),
  ),
)
```

### 6. Drawer

Side navigation panel.

**Specifications**:
- Position: Left side
- Trigger: Account icon in AppBar
- Current Implementation: Placeholder (basic centered text)

```dart
Drawer(
  child: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('This is the Drawer'),
      ],
    ),
  ),
)
```

---

## Iconography

### Icon Style
- **Style**: Material Icons with rounded variants
- **Size**: `30.0` dp for primary actions
- **Color Scheme**: Deep Orange / Deep Orange Accent

### Icon Usage

| Icon | Name | Location | Color | Size |
|------|------|----------|-------|------|
| Account Circle | `Icons.account_circle_rounded` | AppBar Leading | Deep Orange Accent | 30.0 |
| QR Scanner | `Icons.qr_code_scanner_rounded` | AppBar Actions | Deep Orange | 30.0 |

```dart
// Account Icon
Icon(
  Icons.account_circle_rounded,
  color: Colors.deepOrangeAccent,
  size: 30.0,
)

// QR Scanner Icon
Icon(
  Icons.qr_code_scanner_rounded,
  color: Colors.deepOrange,
  size: 30.0,
)
```

### Icon Guidelines
1. Use rounded variants when available for consistency
2. Maintain consistent sizing (30.0 dp for AppBar)
3. Apply appropriate color from the color palette
4. Ensure icons have proper tooltips for accessibility

---

## UI Patterns

### 1. Navigation Pattern
- **Primary**: Tab-based navigation for meal categories
- **Secondary**: Drawer for additional options
- **Tertiary**: Progress indicator for multi-step processes

### 2. Content Display Pattern
- **Layout**: Grid-based (3 columns) for menu items
- **Cards**: Contained components with image, title, and price
- **Buttons**: Full-width action buttons at the bottom

### 3. Interaction Pattern
- **Selection**: Tap on menu item cards
- **Confirmation**: Single large button for order confirmation
- **Scanning**: QR code scanner accessible from AppBar

### 4. Feedback Pattern
- **Progress**: Linear progress indicator at top
- **Dialogs**: AlertDialog for confirmations and notifications
- **Visual States**: Color changes for selected/active tabs

### 5. Border Radius Pattern
- **Cards**: `15.0` dp for rounded corners
- **Progress Indicator**: `10.0` dp
- **Buttons**: Varies (`15.0` dp for top, `0.0` dp for bottom on confirm button)

### 6. Image Display Pattern
- **Container**: Fixed height `90.0` dp
- **Clipping**: Rounded corners with `15.0` dp radius
- **Padding**: `3.0` dp around images
- **Source**: Local assets from `images/` directory

---

## Accessibility

### Color Contrast
- Ensure sufficient contrast between Deep Orange text and white/teal backgrounds
- Primary color combinations meet WCAG AA standards:
  - Deep Orange (#FF5722) on White background ✓
  - Deep Orange (#FF5722) on Teal Accent background (verify in production)

### Touch Targets
- All interactive elements (buttons, cards) meet minimum 48dp touch target
- Icons sized at 30.0 dp with adequate padding

### Text Readability
- Minimum font size: 8.5 dp (may need review for accessibility compliance)
- Primary content uses 18.0 dp (DancingScript) which is readable
- High contrast between text and backgrounds

### Tooltips
- Icons include descriptive tooltips (e.g., "scan QR Code")
- Helps users understand icon functions

### Recommendations
1. Consider increasing price font size from 8.5 to at least 12.0 for better readability
2. Test color combinations with accessibility tools
3. Ensure all interactive elements have proper semantic labels
4. Consider adding support for system font scaling
5. Test with screen readers for proper navigation flow

---

## Asset Management

### Image Assets
All food item images are stored in the `images/` directory with PNG format:

- `beef.png`, `beef1.png`
- `bread1.jpg`
- `cabbage.png`
- `chapati.png`
- `coffee.png`
- `eggs.png`
- `madondo.png`
- `mandazi.png`
- `matumbo1.png`
- `ndengu.png`
- `pilau.png`, `pilau1.png`
- `rice.png`
- `sukuma.png`
- `tea.png`
- `toast.png`
- `ugali.png`

**Image Specifications**:
- Format: PNG (preferred), JPG (acceptable)
- Recommended Resolution: 512x512 px or higher
- Optimization: Compress for mobile usage
- Display Size: 90.0 dp height in cards

### Font Assets
Custom fonts are organized by family in the `fonts/` directory:

- `fonts/Bungee_Spice/BungeeSpice-Regular.ttf`
- `fonts/Tilt_Neon/TiltNeon-Regular-VariableFont_XROT,YROT.ttf`
- `fonts/Dancing_Script/DancingScript-VariableFont_wght.ttf`
- `fonts/Nunito_Sans/NunitoSans-VariableFont_YTLC,opsz,wdth,wght.ttf`

---

## Design Principles

### 1. Vibrant & Welcoming
The design uses bright, energetic colors (teal and orange) to create an inviting, friendly atmosphere appropriate for a cafeteria setting.

### 2. Clarity & Simplicity
- Clear visual hierarchy with large, readable text
- Simple grid layout for easy browsing
- Prominent action buttons
- Minimal cognitive load

### 3. Playful & Approachable
- Custom fonts add personality (BungeeSpice for branding, DancingScript for items)
- Rounded corners throughout create a softer, more approachable feel
- Colorful product photography

### 4. Efficiency
- Tab-based navigation for quick category switching
- Grid layout maximizes visible items
- One-tap selection with confirmation
- Progress indicators keep users informed

### 5. Consistency
- Consistent color usage throughout
- Uniform card design for all menu items
- Standardized spacing and sizing
- Predictable interaction patterns

---

## Future Considerations

### Potential Enhancements
1. **Dark Mode**: Consider adding dark theme support
2. **Animation**: Add subtle transitions between tabs and states
3. **Responsive Design**: Optimize for different screen sizes and orientations
4. **Haptic Feedback**: Add tactile feedback for button presses
5. **Localization**: Support for multiple languages
6. **Dynamic Theming**: Allow for seasonal or promotional theme changes

### Scalability
- Design system can accommodate additional meal categories
- Card pattern can scale to different product types
- Color system can be extended with tertiary colors if needed
- Typography scale can be expanded for new content types

---

## Version History

- **Version 1.0** (2025-11-23): Initial design language specification documented

---

## Contact & Contribution

For questions, suggestions, or contributions to this design language, please refer to the main repository documentation or contact the development team.

