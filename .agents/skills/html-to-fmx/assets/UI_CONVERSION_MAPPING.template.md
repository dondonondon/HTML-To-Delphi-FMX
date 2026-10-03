# UI Conversion Mapping

## Scope

- HTML / CSS / assets: <paths>
- Target page / project / Delphi platforms: <detected context>
- Shared style mapping: <FMX_STYLE_MAPPING.md path>
- Source visual baseline: <HTML render/capture path; logical viewport, zoom/scale; or not available>

## Region mapping — complete before implementation

| HTML anchor / source region | Fixed / data list / mixed | FMX component / widget | Parent / container | Design-time / runtime | Interaction |
|---|---|---|---|---|---|
| <id, class or region> | <classification> | <unit + class/control> | <parent> | <ownership> | <handler or none> |

## Structure and list decisions

- Page tree: <root -> needed header/content/footer regions -> sections/cards/cells; explain extra containers>
- Repeated fixed UI: <source region -> fixed controls; reason it is a fixed set>
- Independent card: <card layout -> sibling background + content>
- Fixed KPI grid: <section -> grid rows/columns -> named TLayout card cells and responsive children>
- Fixed action grid: <section -> grid rows/columns -> direct TCornerButton cells, or justified cell layout>
- TListBox style: <every list name, including fixed-column lists -> design-time StyleLookup=transparentlistboxstyle; host style/theme resolution>
- Item selection: <each TListBoxItem defaults to Selectable=False; name any list that needs persistent selection and why>
- Data lists: <source region -> TListBox name -> reusable card TFrame unit; why records vary>
- Data-list spacing: <separate cards: vertical/horizontal gap and item/card geometry; or connected rows: divider; source/project spacing basis>
- Detail rows: <whether rows come from a collection, field set/order/count varies, or only fixed values change; one shared card class if a list; optional row action owner>
- Icons: <standalone TGlyph or TCornerButton.Images/ImageIndex + style glyphstyle; asset status>
- Grid widths: <smallest supported/reference/wider sizes; child anchors/align, icon gap, trimming/reflow>
- Preview status: <not used / requested demo or designer preview / isolated harness; when used, fixtures through real card binding and replacement by real data>
- Independent row actions: <item-owned sibling, variable-item factory/lifetime, stable row key, geometry/style and separate click verification; or none>

### Proposed page component tree

```text
<FrameRoot: TFrame>
  <Background: TRectangle>
  <Header: TLayout>
    <HeaderBackground: TRectangle>
    <HeaderTitle: TLabel>
    <HeaderAction: TCornerButton> (Images + ImageIndex; style glyphstyle)
  <Content: TLayout>
    <SummaryCard: TLayout>
      <CardBackground: TRectangle>
      <CardValue: TLabel>
    <FixedGridSection: TLayout>
      <SectionTitle: TLabel>
      <FixedGrid: TGridPanelLayout> (3 columns, 1 row)
        <FirstCell: TLayout>
          <FirstBackground: TRectangle> (follows cell bounds)
          <FirstTitle: TLabel> (reserves trailing icon space)
          <FirstIcon: TGlyph> (anchored right)
          <FirstValue: TLabel> (fits cell)
        <SecondCell: TLayout>
        <ThirdCell: TLayout>
    <ActionsSection: TLayout>
      <ActionsTitle: TLabel>
      <ActionsGrid: TGridPanelLayout> (2 columns, 2 rows)
        <FirstAction: TCornerButton> (direct grid child; Images/ImageIndex + glyphstyle)
        <SecondAction: TCornerButton>
        <ThirdAction: TCornerButton>
        <FourthAction: TCornerButton>
    <RecentTitle: TLabel>
    <DataList: TListBox> (StyleLookup=transparentlistboxstyle)
      <Item: TListBoxItem> (runtime, one per record; Selectable=False)
        <Card: TFrame> (runtime instance of reusable design-time card)
  <Footer: TLayout>
    <FooterBackground: TRectangle>
```

### Proposed card component trees

```text
<FCardEntity: TFCardEntity>
  <Background: TRectangle>
  <Icon: TGlyph> (when source has an icon)
  <Title: TLabel>
```

Replace the placeholders with the actual component names and every meaningful
section/cell. Omit unused regions. A content layout with several card backgrounds
and their controls as direct children fails the map. Add a short reason beside
any extra layout level. For variable label/value details, use a design-time
section/title/list and one reusable card class for all rows of that visual type;
show optional independent actions as item-owned siblings of the frame.

## Dynamic widgets

| Repeated data source | Card TFrame unit | Item model / identity | Card height + item geometry | Gap / divider | TListBox container |
|---|---|---|---|---|---|
| <records> | <unit> | <existing DTO/ID or preview model> | <bound card height; item height and alignment/margins> | <vertical/horizontal gap or divider rule> | <TListBox name> |

## Decisions / conflicts

Record responsive rules, justified extra containers, any user-authorized data-list override,
source interactivity conflicting with HitTest=False, assumptions and unsupported CSS.
Remove unused sections; do not turn this mapping into a PRD.

## Integration and validation

- Main form / StyleBook: <path + component>
- Effective runtime style source / load order: <embedded/file/named resource; initialization and existing theme reloads>
- Style deployment / designer synchronization: <strategy>
- Style survival after startup/reload: <passed/failed/not run + requested names and preserved consumers>
- Static checks: <passed/failed/not run + evidence>
- Delphi build: <command/target/result, or not run>
- Designer/resource load: <result, or not run>
- Interaction/platform/visual checks: <result, or not run>
- HTML-versus-FMX comparison: <reference/native capture paths; matched viewport, scale and data state; differences; passed/failed/not run>
- Actual `.fmx` parentage versus this map: <passed/failed/not run + differences>
