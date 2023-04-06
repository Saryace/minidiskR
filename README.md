
### 🇺🇸: This repository contains R scripts for importing and analyzing data from the Minidic Infiltrometer.


Units:
time = secondss
infiltration= cm

* The file naming is in the style of the Soil Biophysics Lab.
* Collaboration? Comments? contact seaceved@uc.cl

| Script | Objetivo |
| ------------- | ------------- |
| main.R  | Reads all scripts from 00 in order |
| scripts/00_libraries.R  | Load the libraries  |
| scripts/01_vg_parameters.R  | Copy the VG parameters  |
| scripts/02_data_example.R  | Dummy data as example  |
| scripts/03_infiltracion.R  | Scripts with infiltration calculation and fitting  |
| scripts/04_plots.R  | Plots infiltration vs. sqrt(time)  |
| scripts/05_style_plots.R  | Plot styling  |
| scripts/06_change_slope.R  | Automation of linear adjustment segments (library ´segmented´)  |

### :es: Este repositorio contiene R scripts para importar y analizar los datos del equipo Minidisk

Unidades:
tiempo = segundos
infiltracion = cm

* El naming de los archivos es al estilo del Laboratorio de Biofísica de Suelos
* Colaboración? Comentarios? contactar a seaceved@uc.cl

| Script | Objetivo |
| ------------- | ------------- |
| main.R  | Lee todos los scripts desde el 00 en orden |
| scripts/00_libraries.R  | Cargar las librerias necesarias  |
| scripts/01_vg_parameters.R  | Copia de las tablas de VG parametros  |
| scripts/02_data_example.R  | Datos ejemplo  |
| scripts/03_infiltracion.R  | Scripts con los cálculos y ajustes  |
| scripts/04_plots.R  | Gráficos en base a infiltration vs. raiz del tiempo  |
| scripts/05_style_plots.R  | Ajuste de estilo para gráficos  |
| scripts/06_change_slope.R  | Automatización de segmentos de ajuste lineal (paquete ´segmented´)  |

### Figuras - Figuress

![plot_1](https://github.com/Saryace/minidiskR/blob/main/figures/plot_bysoilID_plot.png?raw=true)

![plot_2](https://github.com/Saryace/minidiskR/blob/main/figures/plot_bysoil_plot.png?raw=true)
