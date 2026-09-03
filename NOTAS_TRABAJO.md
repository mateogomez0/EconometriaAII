# Nuestro trabajo — documentación técnica

> **"¿Son insulares las provincias italianas? Una extensión espacial al multiplicador fiscal de Acconcia, Corsetti y Simonelli (2014)"**
> Econometría Avanzada II, 2026-2 · Universidad EAFIT · Prof. Gustavo A. García
> Documento de referencia interna. Para las notas del paper original, ver [NOTAS_PAPER.md](NOTAS_PAPER.md).

---

## 1. Qué hicimos y por qué

El trabajo tiene **dos partes** que se apoyan una en la otra:

**Parte I — Replicación.** Reproducir la especificación central de Acconcia, Corsetti y Simonelli (2014, *AER*), que estima el multiplicador fiscal de la inversión pública en las provincias italianas instrumentando el gasto con las disoluciones de concejos municipales por infiltración mafiosa (Ley 164/1991).

**Parte II — Extensión espacial.** Someter a escrutinio econométrico formal la afirmación de los autores de que las economías provinciales italianas son **"insulares"** — es decir, que un shock de gasto en una provincia no se propaga a sus vecinas.

La segunda parte es la contribución. Los autores evalúan los derrames en su Sección V.A añadiendo el gasto agregado de las otras provincias de la misma región como un regresor adicional; concluyen que la evidencia es "débil". Ese procedimiento tiene limitaciones serias (vecindad administrativa en vez de geográfica, sin dependencia en la variable dependiente ni en los errores, sin descomposición de efectos), y los propios autores señalan en sus conclusiones que el estudio de los derrames locales *"requiere una especificación cuidadosa, tanto teórica como empírica, de modelos espaciales"*, calificándolo de *"nueva dirección prometedora para la investigación"*.

Nuestra pregunta es, entonces: **¿sobrevive la insularidad a un tratamiento espacial formal?**

---

## 2. Archivos

| Archivo | Qué es |
|---|---|
| `trabajo.qmd` | Código fuente Quarto — todo el análisis |
| `trabajo.pdf` | Documento final, 15 páginas |
| `trabajo.html` | Versión web autocontenida con tabla de contenido lateral |
| `refs.bib` | Bibliografía (26 referencias) |
| `apa.csl` | Estilo de citación APA |
| `it_shp/` | Shapefile de provincias italianas |
| `NOTAS_PAPER.md` | Notas de lectura del artículo original |
| `NOTAS_TRABAJO.md` | Este documento |
| `paper.pdf` | El artículo original |
| `EcheverriValencia_UribeOrrego/` | Trabajo de un grupo de semestre anterior sobre el mismo paper, más las observaciones del profesor |

**Datos:** provienen del paquete `pder` de R (`data("Mafia")`), que reproduce el dataset original de los autores. Para exportarlos:

```bash
Rscript -e 'library(pder); data(Mafia); write.csv(Mafia, "Mafia_datos.csv", row.names=FALSE)'
```

---

## 3. Parte I — La replicación

### 3.1 Especificación

$$Y_{i,t} = \beta\,G_{i,t} + \alpha_i + \lambda_t + \gamma X_{i,t} + v_{i,t}$$

Panel de 95 provincias × 1990–1999 = 950 observaciones. Instrumentos: $CDS1_{i,t}$ y $CDS2_{i,t-1}$.

Tres decisiones replican al original y resultaron **cuantitativamente decisivas**:

1. **Ponderación por población provincial.** Sin ella el multiplicador cae de 1.47 a 1.20 y el F de instrumento débil de 12.8 a 8.8.
2. **Errores agrupados a nivel región × año** — 190 clusters (19 regiones × 10 años, con Valle d'Aosta agregada a Piemonte), robustos a heterocedasticidad.
3. **El vector completo de controles**: cinco variables de criminalidad y corrupción en diferencias per cápita con dos rezagos, dos proxies laborales rezagadas, rezagos $t-2$ y $t-3$ de disoluciones, y dos rezagos de $G$.

### 3.2 Resultados de la replicación

| Parámetro | Nuestro | Paper | ✓ |
|---|---:|---:|:-:|
| OLS $G(t)$ | 0.20 | 0.21 | ✓ |
| 2SLS $G(t)$ | 1.47 [0.49] | 1.46 [0.49] | ✓ |
| 2SLS con $Y$ rezagada, $G(t)$ | 1.55 [0.43] | 1.55 [0.43] | ✓ |
| $G(t-1)$ | 0.73 / 0.79 | 0.73 / 0.79 | ✓ |
| $Y(t-1)$ | −0.20 | −0.20 | ✓ |
| 1ª etapa $CDS1(t)$ | −2.14 [0.51] | −2.07 [0.54] | ✓ |
| 1ª etapa $CDS2(t-1)$ | −3.98 [0.97] | −4.02 [0.98] | ✓ |
| F instrumento débil | 12.80 | 12.58 | ✓ |
| Observaciones | 950 | 950 | ✓ |

**Los tres multiplicadores:**

| Multiplicador | Fórmula | Nuestro | Paper |
|---|---|---:|---:|
| Impacto | $\beta$ | **1.55** | 1.55 |
| Dinámico (2 años) | $\beta/(1-\phi_1)$ | **1.30** | 1.29 |
| Acumulado | $(\beta+\beta_{G,t-1})/(1-\phi_1)$ | **1.96** | 1.95 |

**Diagnósticos de identificación:**

| Test | Estadístico | p-valor | Lectura |
|---|---:|---:|---|
| F instrumento débil | 12.80 | <0.001 | Por encima del umbral Stock–Yogo de 10 |
| Wu–Hausman | 8.42 | 0.004 | Rechaza exogeneidad de $G$ → IV justificada |
| Sargan (sobreidentificación) | 0.21 | 0.649 | No rechaza → instrumentos válidos |

La replicación es esencialmente exacta, incluidos los errores estándar. El coeficiente IV es **siete veces** el de MCO, la misma proporción que reportan los autores.

---

## 4. Parte II — La extensión espacial

### 4.1 Matrices de pesos

Construimos cuatro matrices, todas estandarizadas por filas, a partir de los centroides provinciales del shapefile:

| Matriz | Criterio |
|---|---|
| **k-NN(4)** | Cuatro vecinos más cercanos — especificación base |
| k-NN(6) | Seis vecinos más cercanos |
| Reina | Contigüidad tipo reina (comparten frontera o vértice), con corrección para islas |
| Distancia inversa | Umbral mínimo que garantiza conectividad de todas las provincias |

La elección de k-NN(4) como base responde a que garantiza conectividad del grafo sin conexiones artificiales excesivas — con contigüidad estricta, Cerdeña y Sicilia quedarían aisladas.

### 4.2 Análisis exploratorio espacial

- **Mapas descriptivos** (Figura 1): distribución provincial de $Y$, $G$, actividad mafiosa y disoluciones acumuladas. El panel D muestra visualmente que **el tratamiento se concentra abrumadoramente en el Mezzogiorno**.
- **I de Moran global por año**: autocorrelación espacial positiva y significativa en el crecimiento $Y$ en la mayoría de los años; mucho más débil en $G$, coherente con su naturaleza de cambio interanual.
- **LISA (Moran local)**: clusters High–High y Low–Low que reproducen el dualismo Norte–Mezzogiorno, con pocos outliers espaciales.

### 4.3 Tests LM de dependencia espacial

| Test | Estadístico | p-valor |
|---|---:|---:|
| LM-lag | 188.44 | 0.000 |
| LM-error | 241.49 | 0.000 |
| **LM-lag robusto** | **0.21** | **0.646** |
| **LM-error robusto** | **53.26** | **0.000** |

> **Este es uno de los resultados más informativos del trabajo.** En sus versiones estándar ambos tests rechazan, pero en las versiones robustas —que corrigen por la presencia del otro tipo de dependencia— **el LM-lag deja de ser significativo mientras el LM-error se mantiene fuertemente significativo**.
>
> La lectura sustantiva: la dependencia espacial en estos datos proviene de **choques comunes no observados entre provincias vecinas** (término de error espacial, $W\varepsilon$), **no de un canal de transmisión del crecimiento entre provincias** (rezago espacial de la dependiente, $WY$). Es exactamente el patrón que uno esperaría si las economías provinciales fueran insulares pero compartieran shocks regionales — que es justo lo que argumenta el paper original.
>
> Nota: el grupo del semestre anterior obtuvo este mismo resultado y el profesor les comentó que "les dio el SEM, lo cual es raro". No es raro: es el patrón coherente con la insularidad.

### 4.4 Modelos espaciales por máxima verosimilitud

| Modelo | $G(t)$ | Parámetro espacial |
|---|---:|---:|
| SAR | 0.149\*\*\* (0.054) | λ = 0.407\*\*\* (0.037) |
| SEM | 0.126\*\* (0.055) | ρ = 0.423\*\*\* (0.036) |
| SDM | 0.141\*\* (0.055) | λ = 0.341\*\*\* (0.039) |

**Advertencia metodológica esencial:** `splm::spml` **no admite variables instrumentales**. Estos modelos tratan $G$ como exógena, y por tanto reproducen el sesgo de atenuación que el diseño cuasi-experimental existe para eliminar. Sus coeficientes de $G$ (0.13–0.15) están mucho más cerca del MCO (0.20) que del 2SLS (1.55).

Esto **no invalida** el resultado sobre los parámetros espaciales —λ y ρ son significativos en todas las especificaciones— pero sí invalida cualquier lectura de la magnitud del multiplicador a partir de ellos.

### 4.5 Descomposición de impactos (LeSage–Pace)

$$\frac{\partial Y}{\partial G'} = (I-\rho W)^{-1}(\beta I + \theta W)$$

| Efecto | Estimación | IC 95% |
|---|---:|---|
| Directo | 0.160 | [0.050, 0.260] |
| Indirecto | 0.309 | [0.043, 0.623] |
| Total | 0.469 | [0.186, 0.818] |

Intervalos por simulación (n = 500). Es exactamente el ejercicio que el enfoque de $SG$ del paper no permite hacer.

**Cómo leerlo con cuidado:** el efecto indirecto aparenta ser sustantivo y con intervalo que excluye el cero. Pero proviene del SDM estimado por ML, es decir, **de un modelo que trata $G$ como exógena**. Dado que el sesgo por endogeneidad en el efecto directo es de un factor de siete, no hay razón para suponer que el efecto indirecto esté libre de contaminación. Este resultado es sugerente, no concluyente — y por eso el estimador de referencia de la sección es el siguiente.

### 4.6 GMM espacial con instrumentos — el estimador de referencia

`splm::spgm` implementa el estimador de Kelejian–Prucha por Momentos Generalizados, que **sí acepta instrumentos externos** y estima simultáneamente la dependencia espacial. Es el único de nuestros modelos que corrige las dos patologías a la vez.

| Parámetro | SAR-GMM (IV) | SARAR-GMM (IV) |
|---|---:|---:|
| $G(t)$ | 0.512\*\* (0.224) | 0.299 (0.194) |
| $G(t-1)$ | — | 0.252\*\*\* (0.087) |
| λ (WY) | 0.576\*\*\* (0.194) | 0.935\*\*\* (0.138) |

**Tres lecturas:**

1. Al reintroducir los instrumentos, el coeficiente de $G$ **se recupera** respecto a los modelos ML (de 0.13–0.15 a 0.30–0.51). Confirma que la atenuación era efecto de la endogeneidad, no de la corrección espacial.
2. El parámetro espacial λ **permanece positivo y significativo** en ambas especificaciones. La estructura espacial es un hecho robusto que sobrevive a la corrección por IV.
3. Corrigiendo ambas patologías simultáneamente, **no emerge un derrame del gasto grande y nítidamente estimado**; en el SARAR completo el coeficiente de $G$ pierde significancia.

**Limitación reconocida:** en el SARAR, λ = 0.935 se aproxima al límite del espacio de estacionariedad ($|\lambda|<1$), lo que en paneles cortos suele indicar que el término espacial está absorbiendo choques comunes no modelados. La estimación puntual bajo SARAR-GMM debe tomarse como orientativa.

### 4.7 Robustez a la elección de W

| Matriz | $G(t)$ | λ |
|---|---:|---:|
| k-NN(4) | 0.141\*\* (0.055) | 0.341\*\*\* (0.039) |
| k-NN(6) | 0.137\*\* (0.054) | 0.355\*\*\* (0.045) |
| Reina | 0.134\*\* (0.054) | 0.356\*\*\* (0.036) |
| Distancia inversa | 0.133\*\* (0.054) | 0.357\*\*\* (0.037) |

Los resultados son **notablemente estables** entre las cuatro definiciones de vecindad. Esto descarta que los hallazgos sean artefactos de una elección particular de $W$ — una preocupación razonable que el profesor había planteado al grupo del semestre anterior.

---

## 5. Parte III — Ejercicios complementarios

### 5.1 Heterogeneidad por macrorregión (validación del diseño)

Clasificamos las 95 provincias en las tres macrorregiones ISTAT y estimamos el 2SLS en cada submuestra.

| Región | Provincias | Obs. | Obs. con instrumento ≠ 0 | $G(t)$ | F débil |
|---|---:|---:|---:|---:|---:|
| Norte | 41 | 410 | **1** | −27.4 (501.5) | 0.00 |
| Centro | 20 | 200 | 0 | no identificado | — |
| **Mezzogiorno** | 34 | 340 | 46 | **1.20\* (0.70)** | 3.19 |

**Este es probablemente el resultado más elocuente del trabajo.** En todo el Norte de Italia, durante la década completa, hay **una sola observación provincia-año con instrumento distinto de cero**. En el Centro, ninguna. Toda la variación instrumental está en el Mezzogiorno, y el multiplicador estimado allí (1.20) es prácticamente idéntico al de la muestra completa.

Es la contrapartida exacta de un diseño de LATE: el efecto se identifica sobre la subpoblación efectivamente tratada. Metodológicamente, también **valida el diseño**: sería sospechoso encontrar el multiplicador precisamente donde el instrumento no varía.

Este resultado dialoga con la Tabla 8 del paper original ("Drop north"), donde restringir la muestra al sur eleva $\beta$ a 1.89.

### 5.2 Balance test de pre-trends

Regresamos cada variable pre-tratamiento sobre los dos instrumentos, con efectos fijos bidireccionales.

| Variable | β(CDS1) | β(CDS2ₜ₋₁) | Wald χ²(2) | p |
|---|---:|---:|---:|---:|
| $Y_{t-1}$ | −3.589 (2.789) | −0.130 (1.542) | 1.66 | 0.436 |
| $U1_{t-1}$ (empleo) | −0.352 (0.517) | −0.033 (0.286) | 0.47 | 0.789 |
| $U2_{t-1}$ (cassa integr.) | 0.041 (0.045) | 0.026 (0.025) | 1.87 | 0.392 |
| $Mafiosi_{t-1}$ | 0.103 (0.185) | 0.850\*\*\* (0.102) | 69.14 | 0.000 |
| $Murder_{t-1}$ | 0.001 (0.010) | −0.095\*\*\* (0.005) | 319.39 | 0.000 |

**El patrón es exactamente el que se necesita:**

- Las **variables económicas** pasan el test holgadamente (p > 0.39 en las tres). Las provincias que serán intervenidas no venían de una trayectoria distinta: no crecían menos, no perdían más empleo, no recurrían más a *cassa integrazione*. Esto es lo que permite leer $\hat\beta$ como efecto causal.
- Las **variables criminales** rechazan fuertemente. Esto es esperado y benigno: el Ministerio del Interior disuelve concejos precisamente en respuesta a evidencia de infiltración mafiosa, de modo que la criminalidad previa *necesariamente* predice la intervención. La especificación principal absorbe este canal incluyendo dos rezagos de todas las variables de criminalidad como controles.

Complementa el test de tendencias previas del paper (su ecuación 2 y Tabla 3, con $d_3 = -0.07$, p = 0.74).

### 5.3 Nota sobre la ventana muestral

Verificamos si la muestra podía ampliarse con los años previos que formalmente contiene la base (1986–1999). **No es posible**: las variables de gasto, disoluciones, actividad mafiosa y corrupción tienen valores faltantes estructurales en 1986 y 1987, de modo que sus segundos rezagos —que la especificación requiere— no pueden computarse para 1988 ni 1989. La ventana 1990–1999 es la máxima factible, lo que confirma que la elección muestral del paper no es arbitraria.

---

## 6. Síntesis de todos los estimadores

| Modelo | $G(t)$ | λ / ρ | Corrige endogeneidad | Modela espacio |
|---|---:|---:|:-:|:-:|
| OLS ponderado | 0.20 | — | No | No |
| **2SLS (paper)** | **1.47** | — | Sí | No |
| **2SLS con Y rezagada** | **1.55** | — | Sí | No |
| SAR (ML) | 0.149\*\*\* | 0.407\*\*\* | No | Sí |
| SEM (ML) | 0.126\*\* | 0.423\*\*\* | No | Sí |
| SDM (ML) | 0.141\*\* | 0.341\*\*\* | No | Sí |
| SAR-GMM | 0.512\*\* | 0.576\*\*\* | Sí | Sí |
| SARAR-GMM | 0.299 | 0.935\*\*\* | Sí | Sí |
| 2SLS (Mezzogiorno) | 1.20\* | — | Sí | No |

**La regularidad central:** las especificaciones que **no** instrumentan $G$ entregan multiplicadores de 0.13–0.20, con independencia de si modelan o no el espacio. Las que sí instrumentan se separan claramente: 1.47–1.55 sin estructura espacial, 0.30–0.51 con ella.

La dimensión que discrimina los resultados es **el tratamiento de la endogeneidad, no el del espacio**. Al mismo tiempo, el parámetro espacial es significativo en todas las especificaciones que lo estiman: la dependencia espacial existe, pero no altera cualitativamente la magnitud del multiplicador propio.

---

## 7. La conclusión sustantiva

**La insularidad del paper original se sostiene tras el escrutinio espacial.**

La evidencia converge desde tres direcciones:

1. **Los tests LM robustos** atribuyen la dependencia espacial al término de error ($W\varepsilon$, choques regionales comunes) y no al rezago de la dependiente ($WY$, canal de transmisión).
2. **El GMM espacial con instrumentos** —único estimador que corrige espacio y endogeneidad simultáneamente— no produce un derrame del gasto nítidamente estimado.
3. **La robustez a cuatro matrices de pesos** descarta que el resultado dependa de una definición particular de vecindad.

Los efectos indirectos que sugiere el SDM por máxima verosimilitud provienen de un modelo que trata el gasto como exógeno y no resisten la corrección por variables instrumentales.

Esto **confirma** la conclusión de Acconcia et al. en lugar de contradecirla, pero sobre una base metodológica considerablemente más sólida: ellos la establecieron con un procedimiento que imponía vecindad administrativa y no permitía descomponer efectos; nosotros llegamos al mismo resultado con vecindades geográficas explícitas, tests formales de dependencia espacial, la familia SAR–SEM–SDM, descomposición de impactos y verificación de robustez.

**Implicación de política:** el costo económico de una disolución administrativa se concentra en la jurisdicción intervenida y no se difunde sustantivamente hacia sus vecinas. Esto simplifica el diseño de mecanismos compensatorios —pueden focalizarse territorialmente sin coordinación interprovincial—, pero también implica que la provincia afectada absorbe íntegramente el ajuste, lo que refuerza el argumento a favor de transferencias contingentes durante los períodos de administración externa.

**Lección metodológica transversal:** aplicar econometría espacial sobre un diseño cuasi-experimental sin preservar la estrategia de identificación reintroduce el sesgo que el diseño buscaba eliminar. Cuando ambas patologías coexisten, la estimación por Momentos Generalizados no es un refinamiento opcional sino un requisito.

---

## 8. Errores que cometimos y corregimos

Vale documentarlos porque son fáciles de repetir.

**No haber leído el paper al principio.** Arrancamos guiándonos del trabajo del grupo anterior y del enunciado, no del artículo. Eso arrastró dos errores que sólo aparecieron al leer el original.

**Faltaba la ponderación por población.** El paper pondera todas las regresiones por población provincial (lo indica en su p. 2190). Sin ese detalle nuestro multiplicador daba 1.20 en vez de 1.47 y el F de instrumento débil quedaba en 8.8 —por debajo del umbral de 10— lo que nos llevó a redactar párrafos defensivos sobre "instrumentos moderadamente fuertes" que resultaron innecesarios.

**Errores estándar sin agrupar.** El paper agrupa a nivel región × año (190 clusters). Usábamos los errores por defecto.

**Faltaban los multiplicadores dinámicos.** Reportábamos los coeficientes sueltos de $G(t)$, $G(t-1)$ y $G(t-2)$ pero nunca calculábamos el multiplicador dinámico (1.29) ni el acumulado (1.95), que son números titulares del paper.

**La narrativa contradecía al paper sin justificarlo.** Nuestra primera versión presentaba como hallazgo principal que "el efecto indirecto del SDM es significativo, ignorar la dimensión espacial subestima el impacto", sin mencionar que el paper dedica una sección entera a argumentar lo contrario ni advertir que nuestro SDM no corregía endogeneidad. Reencuadrar esto fue el cambio más importante del trabajo.

**Un placebo mal diseñado.** Habíamos implementado una prueba de placebo por permutación de los instrumentos que daba p = 0.52 con colas explosivas (SD = 3.8, rango [−18, 32]), consecuencia conocida de las permutaciones con instrumentos moderadamente débiles. Lo reemplazamos por un balance test de pre-trends, que es económicamente interpretable y no involucra el estimador 2SLS.

**Sobre el trabajo del grupo anterior.** Vale señalar que ellos sí corrieron un FE-IV que daba 1.20 (apuntando en la dirección correcta), pero su narrativa se centró en los modelos espaciales por ML —que estructuralmente no pueden identificar el multiplicador— y su conclusión reporta el multiplicador como "entre 0.09 y 0.21", enterrando su propio resultado IV. Tampoco calcularon los multiplicadores dinámicos ni ponderaron por población.

---

## 9. Limitaciones

1. **El SARAR-GMM tiene λ = 0.935**, cerca del límite de estacionariedad. En paneles cortos esto sugiere que el término espacial absorbe choques comunes no modelados; la estimación puntual del multiplicador bajo esa especificación es orientativa.
2. **Los modelos espaciales no admiten ponderación por población.** `spml` y `spgm` no aceptan pesos, de modo que los modelos espaciales no son estrictamente comparables con la línea base ponderada. La comparación entre ambos bloques debe leerse con esa advertencia.
3. **No exploramos dinámicas de largo plazo** más allá de dos rezagos de $G$. Una especificación dinámica con $Y_{t-1}$ en el modelo espacial, o un panel VAR espacial, complementarían la evidencia contemporánea.
4. **La restricción de datos impide un placebo temporal limpio.** No se pueden analizar años previos a la Ley 164/1991 por los valores faltantes estructurales en 1986–1987.
5. **El multiplicador es un LATE**, no un ATE — identificado sobre las provincias efectivamente tratadas, que son casi exclusivamente del Mezzogiorno. Los propios autores advierten esto.

---

## 10. Notas técnicas

### 10.1 Cómo renderizar

```bash
quarto render trabajo.qmd
```

Genera PDF y HTML. Para uno solo: `--to pdf` o `--to html`.

### 10.2 Dependencias de R

```r
pacman::p_load(
  pder, dplyr, tidyr, purrr, tibble, stringr,
  sf, spdep, splm, spatialreg, plm, lmtest, sandwich, AER,
  ggplot2, scales, viridisLite, patchwork,
  knitr, kableExtra, gt, modelsummary, broom
)
```

Para el PDF hace falta LaTeX: `quarto install tinytex`.

### 10.3 Detalles de implementación que costaron trabajo

**`plm` no admite pesos en modelos IV.** Da el error `argument 'weights' not yet implemented for instrumental variable models`. La solución es usar `AER::ivreg` con dummies explícitas de provincia y año, más `sandwich::vcovCL` para los errores agrupados.

**`spml` con `spatial.lag.X = TRUE` no siempre agrega los términos WX.** En la versión instalada, el SDM salía sin ellos. Hay que construirlos manualmente con `splm::slag()` y meterlos en la fórmula.

**Convención de nombres invertida en `splm`.** El paquete llama `lambda` al parámetro del rezago espacial de la dependiente ($WY$) y `rho` al del error espacial ($W\varepsilon$) — al revés de la convención de LeSage y Pace. Cuidado al leer las tablas.

**El shapefile requiere una tabla de equivalencias.** Trece nombres de provincia difieren entre el shapefile y el dataset `Mafia` (Turin/Torino, Firenze/Florence, Reggio Emilia/Reggio Nell'Emilia, etc.). Sin ella se pierden provincias silenciosamente.

**Las macrorregiones ISTAT usan nombres italianos** para cuatro provincias donde uno esperaría el inglés: Milano, Venezia, Genova, Roma.

### 10.4 Ajustes de formato para las 15 páginas

El enunciado no fija un límite, pero acordamos 15 páginas. Los ajustes que se hicieron: sin tabla de contenido, letra 10pt, márgenes de 1.7–1.9 cm, bibliografía en `\footnotesize`, e interlineado 1.0. Si se necesita recortar más, los candidatos son la sección de robustez a $W$ (podría ir a un anexo) y la revisión de literatura.

---

## 11. Pendientes

- [ ] **Cambiar los nombres de autores** en el YAML de `trabajo.qmd` — siguen siendo marcadores de posición ("Paula (pau)", "Fernando (fer)", "Mateo (teo)"). Añadir correos EAFIT.
- [ ] Revisar que las tablas anchas no se salgan del margen en el PDF.
- [ ] Verificar que los caracteres acentuados de nombres italianos (Nell'Emilia, Forlì) rendericen bien.
- [ ] Preparar la presentación de 10 minutos.
- [ ] Decidir si se entrega el PDF, el HTML o ambos.

---

## 12. Para la presentación — el hilo argumental en seis pasos

1. **El problema.** Medir el multiplicador fiscal es difícil porque el gasto es endógeno. El MCO lo sesga hacia cero.
2. **La solución de Acconcia et al.** Las disoluciones de concejos por infiltración mafiosa producen recortes de gasto abruptos, no anticipados y ajenos al ciclo local. Sirven como instrumento.
3. **Lo replicamos.** Multiplicador de 1.55 en impacto, 1.96 acumulado. El IV es siete veces el MCO. Coincidimos con el paper hasta en los errores estándar.
4. **La brecha.** Los autores evalúan los derrames añadiendo el gasto regional como regresor y concluyen que las provincias son "insulares". Pero ese test es rudimentario, y ellos mismos piden modelos espaciales en sus conclusiones.
5. **Nuestra extensión.** Matrices de vecindad geográfica, Moran y LISA, tests LM, SAR/SEM/SDM, impactos de LeSage–Pace, y GMM espacial con instrumentos.
6. **El resultado.** La insularidad se sostiene. La dependencia espacial existe pero está en los errores (choques regionales comunes), no en un canal de transmisión del gasto. Y aprendimos que aplicar econometría espacial sin preservar los instrumentos destruye la identificación.

**Las tres cifras para recordar:** 1.55 (impacto), 1.96 (acumulado), y **1** — el número de observaciones con instrumento distinto de cero en todo el Norte de Italia durante la década.
