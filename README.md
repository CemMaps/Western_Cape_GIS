# Western Cape WebGIS Application

A web-based GIS viewer for Western Cape spatial data, built with Leaflet and data exported from QGIS (qgis2web).

## Features

- **Layer groups**: Admin, Environment, Socio-Economic, Infrastructure, Tourism
- **Toggle layers** on/off with checkboxes
- **Opacity slider** per layer
- **Bring to front** for overlapping layers
- **Popups** with feature attributes on click
- **Basemaps**: Dark (Carto) and Satellite (Esri)
- **Reset view** to Western Cape extent

## Data source and file names

The app loads layer data from your qgis2web export. **Data folder and file names** must match this:

- **Folder:** `qgis2web_2026_02_21-00_55_23_800671/data/` (sibling of `WC_GIS_Application`, or copied into `WC_GIS_Application/data/`).
- **File names** (one `.js` per layer):  
  `Western_Cape_29.js`, `District_municipalities_28.js`, `Local_municipalities_27.js`, `Wards_2020_clip_26.js`, `Geology_2.js`, `BiomesLowRebelo1996_3.js`, `RiversStreamsandWaterways_4.js`, `ProtectedAreas_5.js`, `Wetlands_6.js`, `ImportantBirdAreas_7.js`, `Roads_8.js`, `Petrol_stations_9.js`, `ATM_10.js`, `PublicToilets_11.js`, `Parking_12.js`, `Food_13.js`, `Accommodation_14.js`, `Attractions_15.js`, `Viewpoints_16.js`, `Museums_17.js`, `RuinsandArchaeology_18.js`, `Caves_19.js`, `MountainPeaks_20.js`, `Index_of_Multiple_Deprivation_21.js`, `PopulationDensityPeopleperpixel_22.js`, `PredominantLanguageWards_23.js`, `Predominant_Ethnic_GroupWards_24.js`, `PrecipitationByWards_Spherical_25.js`.

Layout when using the sibling folder:

```
temp_project/
├── WC_GIS_Application/
│   ├── index.html
│   └── README.md
└── qgis2web_2026_02_21-00_55_23_800671/
    └── data/
        ├── Western_Cape_29.js
        ├── District_municipalities_28.js
        ├── ATM_10.js
        └── ... (all other layer .js files above)
```

## How to run (so layers load)

**Option 1 – Server from the parent folder (recommended)**  
Start the server from the folder that **contains both** `WC_GIS_Application` and `qgis2web_2026_02_21-00_55_23_800671` (e.g. `temp_project`), then open the app URL:

```bash
cd "path/to/temp_project"
python -m http.server 8080
```

Then in the browser open: **http://localhost:8080/WC_GIS_Application/**

If you start the server from inside `WC_GIS_Application`, the app cannot see the qgis2web data folder and layers will not load.

**Option 2 – Use a local copy of the data**  
Copy the entire `data` folder from `qgis2web_2026_02_21-00_55_23_800671` into `WC_GIS_Application/data/`. Then you can run the server from inside `WC_GIS_Application` and layers will load from `WC_GIS_Application/data/`.

## Tech Stack

- **Leaflet** 1.9.4 – map and GeoJSON
- **Tailwind CSS** – layout and styling
- **Font Awesome** – icons  
- Data: qgis2web GeoJSON-in-JS files (e.g. `var json_ATM_10 = { ... }`)
