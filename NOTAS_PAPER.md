# Acconcia, Corsetti y Simonelli (2014) — Notas de lectura

> **"Mafia and Public Spending: Evidence on the Fiscal Multiplier from a Quasi-Experiment"**
> *American Economic Review*, 104(7), julio 2014, pp. 2185–2209.
> Antonio Acconcia (Università di Napoli Federico II), Giancarlo Corsetti (Cambridge), Saverio Simonelli (Napoli Federico II).
> Códigos JEL: D72, E62, H71, K42.

---

## 1. La pregunta

**¿Cuánto crece (o cae) el producto de una economía local cuando cambia el gasto público que recibe?** Es decir, ¿cuál es el multiplicador fiscal a nivel subnacional?

La pregunta es vieja pero se reactivó con la crisis de 2008: primero por la ola de estímulos fiscales, y después por la necesidad de consolidar déficits. La literatura tradicional se había concentrado en efectos agregados a nivel nacional; este paper forma parte del giro hacia la **dimensión local**, motivado por dos razones:

1. **Razón de política**: interesa saber si redistribuir recursos fiscales entre regiones sirve para contrarrestar recesiones localizadas, y qué consecuencias geográficas tienen los recortes cuando las administraciones locales se ven forzadas a ajustar.
2. **Razón econométrica**: las economías regionales son mucho más abiertas que las nacionales y enfrentan una política monetaria y presupuestaria fijada a nivel nacional, que no responde a sus condiciones idiosincráticas. Eso permite identificar el efecto del gasto manteniendo constante todo lo macro.

La respuesta del paper: **el multiplicador de impacto es 1.5, y llega a 1.9 incorporando efectos dinámicos.**

---

## 2. El problema de identificación

Estimar el multiplicador por MCO no funciona, por dos razones que los autores explicitan:

**(a) Anticipación.** El gasto en infraestructura se planea años antes de ejecutarse. Si el modelo no captura los efectos de anticipación entre el anuncio y la realización de los proyectos, el multiplicador queda **sesgado hacia abajo** de forma sustancial.

**(b) Asignación endógena.** El gobierno central puede haber asignado fondos en respuesta a la evolución económica local. Por ejemplo, si sistemáticamente se destinan proyectos grandes a provincias de bajo crecimiento para estimularlas, el MCO subestima el multiplicador.

Ambos sesgos apuntan en la misma dirección: hacia cero. Y en efecto, el paper encuentra que el estimador IV es **siete veces mayor** que el MCO.

Se necesita, entonces, una fuente de variación en el gasto público que sea **exógena al ciclo económico local**.

---

## 3. El experimento natural: la Ley 164/1991

### 3.1 Contexto institucional

Tres piezas institucionales se combinan para crear el cuasi-experimento:

**Pieza 1 — El federalismo fiscal italiano (Leyes 281/1970 y 382/1975).**
El gobierno central presupuesta el flujo global de recursos hacia los gobiernos locales, pero **los gobiernos locales conservan el control total de esos fondos**: eligen los proyectos y las empresas que los ejecutan. Del lado de los ingresos, en cambio, los municipios tienen muy poca capacidad de fijar tasas impositivas.

> **Por qué esto importa tanto:** los recursos que el gobierno central canaliza hacia proyectos locales **no se corresponden con variaciones en la carga tributaria de los residentes locales**. Esto libera a los autores de tener que controlar por cambios impositivos o deuda —un problema serio en la literatura de multiplicadores. El multiplicador que estiman es "puro", sin contaminación de ajustes tributarios.

**Pieza 2 — La legislación antimafia (1982).**
Los artículos 416-bis y 416-ter del código penal tipifican las organizaciones de tipo mafioso: el uso de intimidación, vínculos asociativos y *omertà* (código de silencio) para adquirir control directo o indirecto sobre actividades económicas, **especialmente en inversión pública y provisión de servicios públicos**. Durante los años del estudio, la obra pública gestionada por administraciones locales se convirtió en una de las fuentes de negocio más lucrativas para las mafias.

**Pieza 3 — El Decreto Ley 164 del 31/05/1991.**
Permite al gobierno central **remover a los funcionarios locales electos** cuando hay evidencia de que sus decisiones fueron determinadas o influidas por las mafias. Al disolver un concejo municipal, el gobierno central nombra **tres comisarios externos no electos** que gobiernan el municipio durante **18 meses**.

El cambio que introduce esta ley es cualitativo: antes de 1991, la evidencia incriminatoria contra —digamos— un concejal llevaba al arresto de esa persona. Después de 1991, **la misma evidencia podía llevar a la disolución del concejo completo**. Esto le dio a los fiscales una herramienta nueva y potente para atacar las redes que conectan empresas mafiosas con administraciones públicas.

### 3.2 Geografía de las disoluciones

Las disoluciones se concentran fuertemente donde la infiltración es histórica (Tabla 1 del paper, período 1991–2012):

| Región | Total | Provincias principales |
|---|---:|---|
| Campania | 90 | Napoli 48, Caserta 31, Salerno 6, Avellino 4, Benevento 1 |
| Calabria | 62 | Reggio C. 37, Vibo Valentia 12, Catanzaro 8, Crotone 3, Cosenza 2 |
| Sicilia | 55 | Palermo 23, Catania 9, Agrigento 7, Trapani 6, Caltanissetta 6, Messina 3, Ragusa 1 |
| Puglia | 7 | Bari 5, Lecce 2 |
| **Resto de Italia** | **7** | — |

En la muestra del estudio hay **110 casos** de concejos bajo administración forzosa que, al agregarse a nivel provincial, producen **47 observaciones** tratadas.

### 3.3 El mecanismo: disolución → recorte del gasto

Cuando llegan los comisarios externos, típicamente **cortan los flujos financieros hacia obras públicas y proyectos de inversión**. El primer año de administración forzosa se asocia con una contracción fuerte del gasto en obra pública a nivel provincial.

**Tabla 2 del paper** compara el grupo tratado (observaciones provincia-año en el primer año calendario tras una disolución) contra dos grupos de control:

| Medida | vs. resto de muestra | vs. sólo provincias con al menos una disolución |
|---|---:|---:|
| % de la inversión rezagada | **−19.65\*\*\*** [5.36] | **−23.67\*\*\*** [7.12] |
| % del valor agregado rezagado | **−0.46\*\*** [0.19] | **−0.49\*** [0.26] |

La contracción promedio es de **~20 puntos porcentuales de la inversión**, equivalente a cerca de **medio punto porcentual del valor agregado provincial**. Es una magnitud comparable a la de los shocks fiscales usados en los principales estudios empíricos de multiplicadores.

Crucialmente, las columnas 5 y 6 de esa tabla muestran que las variaciones de gasto **no difieren estadísticamente entre los dos grupos de control** — consistente con que tratados y controles son homogéneos salvo por el tratamiento.

### 3.4 El caso de Pompei (ilustración del mecanismo)

Los autores documentan en detalle un caso para mostrar cómo opera el recorte en la práctica. El concejo de Pompei (provincia de Nápoles) fue disuelto el 11 de septiembre de 2001, tras el arresto del presidente del concejo municipal y del concejal de mantenimiento vial por asociación mafiosa. El concejal era el enlace principal entre la administración local y el jefe del clan mafioso local, también arrestado.

- El presupuesto de 2001, preparado por los funcionarios electos **antes** de la disolución, asignaba **4 millones de euros** a obras públicas.
- Los comisarios ratificaron formalmente el presupuesto pero **recortaron más de 3 millones** del gasto en obra pública (contablemente, moviéndolos a la partida *economie*, es decir, ahorros).
- El gasto efectivo de 2001 terminó siendo apenas el **20% de lo planeado**.

Los recortes tocaron: mantenimiento vial extraordinario, alumbrado público, compra de equipo mecánico, demoliciones, mantenimiento del sistema de agua, parques y jardines, alcantarillado, restauración de edificios y cementerios municipales. Nótese que la lista incluye proyectos bajo investigación policial, pero **los comisarios recortaron transversalmente** — probablemente para obtener más información antes de avalar decisiones de gasto previas.

---

## 4. Los datos

**Panel:** 95 provincias italianas × 10 años (**1990–1999**) = **950 observaciones**. Una provincia italiana es una entidad geográfica similar a un condado estadounidense y contiene varios municipios.

### 4.1 Variables principales

| Símbolo | Definición | Construcción |
|---|---|---|
| $y_i$ | Valor agregado real per cápita | Millones de euros a precios corrientes, deflactado por el deflactor del PIB nacional |
| $Y_{i,t}$ | **Variable dependiente**: tasa de crecimiento | $(y_{i,t} - y_{i,t-1})/y_{i,t-1}$ |
| $g_i$ | Inversión pública real per cápita en infraestructura | Deflactada por el deflactor del PIB nacional |
| $G_{i,t}$ | **Variable de tratamiento** | $(g_{i,t} - g_{i,t-1})/y_{i,t-1}$ — cambio interanual normalizado por el **producto** rezagado |

Nótese la asimetría en la construcción de $G$: el numerador es el cambio en gasto, pero el denominador es el **valor agregado** rezagado, no el gasto rezagado. Esto hace que $\beta$ se interprete directamente como multiplicador: cuánto cambia el producto (en %) por cada punto porcentual del producto que cambia el gasto.

**Composición del gasto en infraestructura** (Apéndice de datos):
- Transporte: carreteras y aeropuertos, ferrocarriles, otros medios de transporte, puertos y ríos, telecomunicaciones
- Saneamiento-Energía-Recuperación: hospitales, plantas eléctricas, pantanos, recuperación de tierras
- Edificaciones: edificios públicos y escuelas, gasto público destinado a edificios privados

### 4.2 Controles ($X$)

**Cinco variables de criminalidad y corrupción**, todas en diferencias per cápita, entradas contemporáneamente y **con hasta dos rezagos**:

1. Personas reportadas por asociación de tipo mafioso (art. 416-bis)
2. Personas reportadas por extorsión
3. Personas reportadas por homicidios vinculados a actividad mafiosa
4. Personas reportadas por corrupción
5. Número de delitos de corrupción reportados

*(Corrupción se define incluyendo peculado, malversación de fondos públicos, extorsión y cohecho.)*

**Por qué estos controles son esenciales:** los episodios de disolución coinciden con investigación policial intensa y/o cambios en la escala de la actividad mafiosa. La disuasión criminal que implica una disolución **podría afectar la actividad económica independientemente del recorte de gasto** — lo cual violaría la restricción de exclusión. El supuesto mantenido es que la escala de la actividad mafiosa está correlacionada con el resultado de la investigación policial (arrestos, personas imputadas).

Una sutileza importante: transversalmente, las áreas con alta presencia mafiosa tendrán un promedio alto de mafiosos arrestados. Pero **los efectos fijos de provincia se hacen cargo de esas diferencias entre provincias**. Y la intensidad del cumplimiento de la ley puede variar en el tiempo (presión política o mediática, prioridades cambiantes, esfuerzos de jueces y fiscales) — de eso se hacen cargo **los efectos fijos de año**.

**Dos proxies de mercado laboral** (rezagos $t-1$ y $t-2$ de la diferencia logarítmica):
- Empleo per cápita
- Horas de *Cassa Integrazione Guadagni* (CIG) — el principal esquema de subsidio salarial temporal en Italia, que cubre empleados de grandes empresas privadas

Se incluyen porque los cambios en empleo son altamente persistentes.

**Otros controles:**
- Rezagos $t-2$ y $t-3$ del número de municipios bajo administración forzosa, ponderados por población relativa
- Dos rezagos de la variable de gasto $G$

### 4.3 Fuentes

| Variable | Fuente |
|---|---|
| Gasto en infraestructura | ISTAT, *Annuario delle Opere Pubbliche* (serie provincial 1987–1999) |
| Valor agregado | Istituto Guglielmo Tagliacarne |
| Población, deflactor | ISTAT (*Statistiche Demografiche*, *Contabilità Nazionale*) |
| Empleo | Tagliacarne e ISTAT |
| Cassa Integrazione | Tagliacarne |
| Disoluciones por mafia | *Commissione parlamentare d'inchiesta sul fenomeno della criminalità organizzata mafiosa o similare* |
| Criminalidad y corrupción | ISTAT, *Statistiche giudiziarie* |

> **Detalle relevante para la replicación:** la serie de valor agregado se construye empalmando **dos series distintas** (1985–1991 y 1991–1999). Los datos de la primera se usan para construir $Y$ hasta 1991; de ahí en adelante se usa la serie más reciente.

---

## 5. El modelo econométrico

### 5.1 Ecuación principal

$$Y_{i,t} = \beta\, G_{i,t} + \alpha_i + \lambda_t + \gamma\, X_{i,t} + v_{i,t} \tag{1}$$

donde $\beta$ es el multiplicador contemporáneo de un año, $\alpha_i$ el efecto fijo de provincia, $\lambda_t$ el efecto fijo de año, y $X$ el vector de controles.

**Los efectos fijos de año cumplen dos funciones distintas:**

1. Controlan por los **componentes nacionales** de la inversión pública y del PIB comunes a todas las provincias. Las variaciones agregadas de gasto y producto suelen ser predecibles y endógenas al ciclo, lo que produciría estimaciones espurias por causalidad reversa.
2. Controlan por la **política monetaria y fiscal nacional**. La transmisión de un estímulo o contracción fiscal depende crucialmente de la postura monetaria y de la anticipación de medidas fiscales dictadas por la necesidad de estabilizar la deuda pública. No controlar por esto haría que el multiplicador estimado confundiera el efecto del shock fiscal con el de la política monetaria y presupuestaria esperada.

**Los efectos fijos de provincia** atacan la endogeneidad por características provinciales correlacionadas con los criterios de asignación del gasto.

### 5.2 Ponderación y errores estándar

**Ponderación:** las provincias tienen tamaños muy distintos. Las regresiones se **ponderan por población provincial**.

**Errores estándar:** la inferencia en paneles puede ser muy engañosa si hay correlación espacial dentro de grupos, correlación serial, o ambas.
- Contra correlación **serial**: se incluyen hasta dos rezagos de la variable dependiente.
- Contra correlación **espacial**: siguiendo a Guiso, Sapienza y Zingales (2004), se asume que las provincias de una misma región están correlacionadas por un efecto de conglomerado no observado derivado de reglas y políticas regionales comunes. Los errores se agrupan permitiendo **190 conglomerados** = 10 años × 19 regiones (Valle d'Aosta se agrega con Piemonte por su tamaño pequeño), y son robustos a heterocedasticidad.

> Ambas decisiones —ponderar y agrupar— son **cuantitativamente importantes**. Sin ponderar, el multiplicador estimado cae de 1.47 a 1.20 y el estadístico F de instrumento débil baja de 12.8 a 8.8.

### 5.3 Supuesto de identificación dinámica

Siguiendo a la literatura SVAR posterior a Blanchard y Perotti (2002), se asume que **los rezagos de $G_{i,t}$ están predeterminados respecto a $Y_{i,t}$**. Bajo ese supuesto, los coeficientes sobre los rezagos de $G$ estiman el **multiplicador dinámico**, complementando la estimación IV del multiplicador contemporáneo.

---

## 6. Los instrumentos

### 6.1 Construcción

Dos hechos obligan a construir los instrumentos con cuidado:

1. Al agregar a nivel provincial, los efectos de una disolución en uno o más municipios deben **ponderarse apropiadamente**.
2. La disolución puede ocurrir en cualquier momento del año. El flujo anual de gasto de inversión —y por tanto su efecto sobre el cambio interanual del valor agregado— depende crucialmente de **qué tan cerca del fin de año calendario** ocurre la disolución.

**$CDS1_{i,t}$ ("Council-dismissal-S1")**
Número de municipios puestos bajo administración forzosa **cuando el decreto oficial se publica en el primer semestre del año**, ponderado por la fracción de población provincial que reside en esos municipios.
- Incluir el *número de municipios* aproxima el número de proyectos cuyo financiamiento puede ser recortado.
- El *peso poblacional relativo* captura la importancia económica del área bajo administración forzosa.

**$CDS2_{i,t}$ ("Council-dismissal-S2")**
Definido igual, salvo que: para cada caso de administración forzosa se calcula primero el **número de días entre la disolución y el fin de año**, y se promedia sobre todos los municipios de la misma provincia-año. Para cada observación provincia-año en que ese promedio es **menor a 180 días**, $CDS2$ toma el valor del número de municipios bajo administración forzosa.

**Primera etapa:**

$$G_{i,t} = \delta_1\, CDS1_{i,t} + \delta_2\, CDS2_{i,t-1} + \alpha_i + \lambda_t + \gamma\, X_{i,t} + e_{i,t} \tag{3}$$

Nótese que se usa $CDS1$ **contemporáneo** y $CDS2$ **rezagado un período**: si la disolución ocurre tarde en el año, su efecto sobre el gasto se materializa mayormente al año siguiente.

### 6.2 ¿Por qué es plausible la restricción de exclusión?

El instrumento descansa en dos hechos:
1. La investigación policial y la aparición de evidencia incriminatoria que lleva a la disolución **no están relacionadas con fluctuaciones de la actividad económica local**.
2. La administración forzosa por comisarios externos se traduce típicamente en un recorte **inmediato, no anticipado y temporal** de proyectos de inversión pública.

Según los informes de la *Commissione Parlamentare d'Inchiesta*, las disoluciones típicamente se originan en:
- Investigaciones de delitos cometidos por administradores o políticos locales (no necesariamente ligados a sus funciones oficiales)
- Investigaciones de extorsiones, tráfico ilegal de armas y drogas, y guerras mafiosas por el control del territorio
- Investigaciones motivadas por denunciantes que aportan información sobre infiltración mafiosa en la administración
- Investigaciones motivadas por la renuncia del alcalde o de un concejal, que sugiere presión mafiosa

El mismo documento enfatiza algo clave: **las disoluciones no se disparan por indicadores de ineficiencia administrativa en los procesos de contratación**. Al contrario, los procedimientos de contratación que involucran empresas conectadas con la mafia suelen completarse rápido y a bajo precio, sin desperdicio aparente de recursos públicos.

**Velocidad del proceso:** el lapso entre la aparición de evidencia y el reemplazo por comisarios externos es corto — en la muestra, con frecuencia el proceso completo toma **dos meses**. Por eso, condicional a la noticia de que el procedimiento se puso en marcha, es poco probable que la anticipación de las contracciones de gasto juegue un papel significativo con observaciones anuales.

### 6.3 Test formal de tendencias previas

$$Y_{i,t} = d_0 + d_1 D_{i,t} + d_2 t + d_3 (t \times D_{i,t}) + \psi_{i,t} \tag{2}$$

donde $t$ es una tendencia temporal y $D_{i,t}$ es una dummy igual a 1 para toda observación provincia-año **anterior** al primer episodio de disolución. Muestra 1986–1999.

**Resultado:** $d_3 = -0.07$, error estándar ajustado por conglomerados $= 0.19$, **p-valor $= 0.74$**. No se rechaza $d_3 = 0$ → **no hay tendencia diferencial en las tasas de crecimiento antes de las disoluciones**. Tampoco se rechaza $d_1 = 0$, lo que indica que la tasa de crecimiento promedio de las provincias tratadas no difiere del resto de la muestra.

**Tabla 3** complementa: para las provincias con al menos una disolución, se calcula si el crecimiento en los dos y tres años previos estuvo siempre por encima, siempre por debajo, o fluctuando alrededor del promedio nacional.

| Ventana | Siempre encima | Siempre debajo | Fluctuando |
|---|---:|---:|---:|
| $t-1$ y $t-2$ | 1/3 | 1/6 | 1/2 |
| $t-1$, $t-2$ y $t-3$ | 1/9 | 0 | 8/9 |

No emerge ningún patrón sistemático.

---

## 7. Resultados principales (Tabla 4)

| Parámetro | OLS (1) | OLS (2) | 2SLS 1ª etapa (3) | 2SLS 2ª etapa (4) | 2SLS 1ª etapa (5) | 2SLS 2ª etapa (6) |
|---|---:|---:|---:|---:|---:|---:|
| $G(t)$ | 0.21\*\* [0.07] | 0.23\*\* [0.07] | — | **1.46\*\*** [0.49] | — | **1.55\*\*\*** [0.43] |
| $G(t-1)$ | 0.22\*\* [0.08] | 0.26\*\* [0.08] | −0.41\*\*\* [0.07] | 0.73\*\*\* [0.21] | −0.41\*\*\* [0.07] | 0.79\*\*\* [0.19] |
| $G(t-2)$ | 0.00 [0.07] | 0.04 [0.07] | −0.13\* [0.06] | 0.14 [0.11] | −0.13\* [0.06] | 0.19 [0.11] |
| $Y(t-1)$ | — | −0.16\* [0.06] | — | — | 0.03 [0.02] | −0.20\*\* [0.06] |
| $Y(t-2)$ | — | −0.03 [0.05] | — | — | −0.02 [0.02] | −0.02 [0.05] |
| $CDS1(t)$ | — | — | **−2.07\*\*\*** [0.54] | — | **−1.97\*\*\*** [0.56] | — |
| $CDS2(t-1)$ | — | — | **−4.02\*\*\*** [0.98] | — | **−4.08\*\*\*** [0.94] | — |
| **F instrumentos** | — | — | **12.58** | | **11.83** | |
| Observaciones | 950 | 950 | 950 | 950 | 950 | 950 |

*Errores estándar entre corchetes, agrupados a nivel región × año y robustos a heterocedasticidad. Como los p-valores empiezan en 0.001, el esquema de significancia del paper es: \*\*\* 0.1%, \*\* 1%, \* 5%.*

### 7.1 Lecturas

**El sesgo del MCO es enorme.** El estimador IV es **siete veces mayor** que el MCO (0.21 → 1.46). Los autores lo atribuyen razonablemente al proceso administrativo largo y complejo que gobierna la asignación e implementación de proyectos públicos: el gasto efectivo difícilmente se relaciona con movimientos cíclicos del producto local, y parte de los efectos se materializan antes de que los proyectos se ejecuten. Diferencias grandes y negativas entre MCO e IV también aparecen en Serrato y Wingender (2011) y Nakamura y Steinsson (2014) con datos de EE.UU. — allí incluso mayores.

**El multiplicador de impacto es estable.** El coeficiente se mantiene notablemente estable entre las dos versiones del modelo (1.46 vs 1.55), con o sin rezagos del crecimiento del producto. Interpretación: **un recorte exógeno de infraestructura pública equivalente al 1% del valor agregado local produce una reducción contemporánea del producto local de cerca de 1.5%.**

**Los instrumentos son fuertes.** F de 12.58 y 11.83, por encima del umbral convencional de 10. Ambos coeficientes de primera etapa son negativos —como se espera— y altamente significativos.

### 7.2 Las tres magnitudes del multiplicador

Este es un punto que se pierde fácilmente al leer rápido. El paper reporta **tres** números distintos:

| Multiplicador | Fórmula | Valor | Interpretación |
|---|---|---:|---|
| **Impacto** | $\beta$ | **1.55** | Efecto contemporáneo dentro del mismo año |
| **Dinámico (2 años)** | $\beta/(1-\phi_1)$ | **1.29** | Corrige por la persistencia del producto ($\phi_1$ = coef. de $Y_{t-1}$) |
| **Acumulado** | $(\beta + \beta_{G,t-1})/(1-\phi_1)$ | **1.95** | Suma además el efecto del gasto rezagado |

- El **dinámico** vale 1.29 porque el primer rezago del crecimiento del producto es significativamente distinto de cero ($-0.20$). Significa una reducción acumulada del valor agregado local de 1.29% en dos años.
- El **acumulado** de 1.95 requiere el supuesto adicional de que el gasto rezagado es exógeno al producto corriente. En esa especificación, **no se puede rechazar $H_0: \beta \le 1$ contra $\beta > 1$ al 5%**.

### 7.3 Tests adicionales de identificación

- **Anderson–Rubin**: rechaza $H_0: \beta = 0$ al 5% (p-valor ≈ 0.01) en ambas especificaciones. Este test es robusto a instrumentos débiles.
- **Estadístico J de Hansen**: p-valor muy alto → los instrumentos no están correlacionados con el término de error.

### 7.4 Dos advertencias que hacen los propios autores

**(a) Es un LATE, no un ATE.** La transmisión de la política fiscal puede diferir entre provincias según sus características. Si la probabilidad de tratamiento está correlacionada con esas características, la regresión IV entrega el multiplicador **para las áreas tratadas**, no un promedio poblacional. Es razonable esperar que la mafia afecte la productividad del gasto público local de forma distinta entre provincias: la involucración mafiosa puede causar mala asignación del capital público, pero también podría "engrasar las ruedas" de la inversión pública. Los autores consideran que esta heterogeneidad es más relevante para evaluar efectos de **largo plazo** sobre el stock de capital público que para el multiplicador de corto plazo.

**(b) La crítica de Sims.** En un modelo de ecuación única, los efectos estimados del gasto no incorporan la posible retroalimentación del producto hacia el gasto; estrictamente, los resultados no son comparables con los de modelos SVAR (Sims 2010). Sin embargo, en esta muestra **la inversión en infraestructura no reacciona a cambios del valor agregado**: en la primera etapa, los coeficientes de los dos rezagos del valor agregado no son estadísticamente distintos de cero (columna 5 de la Tabla 4). La crítica no aplica aquí.

---

## 8. ¿Afectan las disoluciones al producto por vías distintas del gasto? (Sección IV)

Para que la estimación IV sea válida, el instrumento debe estar **no correlacionado con el término de error condicional a los controles**. Los efectos fijos de provincia ya se hacen cargo de muchas razones plausibles por las que la restricción podría fallar. Pero quedan dos canales que merecen discusión.

### 8.1 Canal A: variación en la actividad mafiosa

**El problema.** Una guerra exitosa contra la mafia debería mejorar la actividad económica en el **largo plazo** (más inversión de empresarios locales y extranjeros). Como el objetivo de las disoluciones es reducir permanentemente la presencia mafiosa, no controlar por este canal produciría un **sesgo hacia abajo**: el efecto negativo del recorte de gasto quedaría parcialmente compensado por el efecto positivo de "menos mafia".

En el **corto plazo** el signo es ambiguo: por un lado, remover funcionarios conectados con la mafia y reducir la corrupción política y delitos como la extorsión —que funcionan como un "impuesto" sobre empresas y hogares— puede estimular la economía. Por otro, la mafia puede reducir o cerrar actividades que antes generaban valor agregado, causando pérdidas de producto. Además, la relocalización de actividades mafiosas entre provincias podría hacer los resultados sensibles al nivel de agregación.

**El test.** Verificar si el multiplicador sube o baja al **omitir** los controles de actividad mafiosa.

**Resultado (Tabla 5, columna 1):** el multiplicador **cae** a 1.30\*\* [0.45] cuando se excluyen esos controles (vs. 1.55 en la línea base). El efecto del recorte sobre el producto se vuelve *menos* negativo. Es decir, el efecto directo neto del canal de actividad mafiosa empuja el producto en **dirección opuesta** al recorte del gasto.

**Evidencia complementaria — la forma reducida:**

$$Y_{i,t} = \delta_1 CDS1_{i,t} + \delta_2 CDS2_{i,t-1} + \alpha_i + \lambda_t + \varsigma X_{i,t} + \xi_{i,t} \tag{4}$$

| Especificación | $F$ para $H_0: \delta_1 = \delta_2 = 0$ | p-valor |
|---|---:|---:|
| Con todos los controles | **5.13** | 0.0067 |
| Omitiendo controles de mafia | 2.77 | 0.0651 |

Los controles de actividad mafiosa **sí están correlacionados con los instrumentos**, y el efecto conjunto de los instrumentos sobre el producto es significativo sólo con ellos.

Un ejercicio elegante (nota al pie 28): reemplazar el lado izquierdo de la forma reducida por $Y - \hat\beta G$ imponiendo $\hat\beta = 1.55$. El estadístico F se vuelve **prácticamente cero** (p = 0.99), consistente con que las condiciones de ortogonalidad son válidas.

**Conclusión:** el efecto neto de corto plazo de la investigación policial contra la mafia, si existe, es **positivo** — el mismo signo que se argumenta comúnmente para sus efectos de largo plazo. Esto **alivia** la preocupación de que un canal de actividad mafiosa no controlado induzca sesgo al alza en los multiplicadores estimados.

### 8.2 Canal B: "shock al gobierno"

**El problema.** Independientemente de sus efectos sobre el gasto, las disoluciones *per se* podrían ser shocks negativos a la productividad de la administración local. El reemplazo súbito de funcionarios electos por comisarios externos podría reducir el producto administrativo — por ejemplo, podrían caer las licencias de negocio emitidas.

**Argumento institucional.** Los autores muestran que esta preocupación es infundada. Las disoluciones están concebidas como una iniciativa **proactiva** en la lucha antimafia; los comisarios tienen el mandato de actuar con la mayor eficiencia posible, con el objetivo explícito de mostrar a la población los beneficios sociales de liberar las instituciones locales de la mafia. Dos citas de documentos oficiales:

> "La administración forzosa debe ser en sí misma una oportunidad para mejorar la administración, la política y las relaciones entre el gobierno y los ciudadanos" (De Rita 1995, p. 10)

> "La administración forzosa no debe ser un simple puente hacia nuevas elecciones, sino una oportunidad para el desarrollo y crecimiento de las instituciones locales, así como una oportunidad para un nuevo comienzo para la comunidad local" (Commissione Parlamentare d'Inchiesta 2005, p. 9)

Un informe del Ministro dell'Interno (2000) sobre 19 municipios concluye que los comisarios cumplieron su mandato escrupulosamente: se aseguraron de que actos administrativos (como nuevas contrataciones) que estaban de facto bloqueados o suspendidos por distorsiones atribuibles a la mafia fueran completados, en áreas que abarcan salud, educación, policía y trabajo social.

**Test empírico.** Los autores construyeron un dataset con **todos** los casos de disolución de concejos en Italia **no relacionados** con la ley antimafia de 1991. Motivos: (i) renuncia de funcionarios electos; (ii) fallo en organizar elecciones; (iii) casos especiales de inelegibilidad del alcalde; (iv) fallo en aprobar el presupuesto anual; (v) crisis política en las coaliciones gobernantes. Durante el período muestral hubo **2,031** disoluciones por estos motivos — la más común fue la renuncia de funcionarios electos (~la mitad de los casos).

**Resultado clave:** las disoluciones no relacionadas con infiltración mafiosa **no están correlacionadas con una caída del gasto público** — en la primera etapa del modelo aumentado, ninguna de las nuevas covariables es significativa al 5%. Y las columnas 2–5 de la Tabla 5 muestran que los coeficientes estimados no son significativamente distintos de cero.

**Conclusión:** ni los documentos administrativos ni el análisis estadístico producen evidencia de un "canal de administración forzosa" que afecte la actividad económica vía deterioro del desempeño burocrático local. **Los efectos sobre el producto aparecen únicamente cuando las disoluciones se asocian a un recorte del gasto público.**

---

## 9. Resultados adicionales (Sección V)

### 9.1 Efectos transfronterizos — la sección crítica para nuestro trabajo

Los autores plantean explícitamente el problema de los derrames y proponen dos canales con **signos opuestos**:

**Canal 1 — Fugas de demanda (*demand leakage*).** Parte de la contracción de demanda en un municipio puede "filtrarse" hacia áreas cercanas, deprimiendo la actividad económica simultáneamente dentro y fuera de la provincia donde se recorta. Esto induciría una **correlación positiva** en la respuesta del valor agregado de provincias adyacentes.

**Canal 2 — Relocalización.** En respuesta a un shock de gasto localizado, los factores de producción pueden relocalizarse, cruzando las fronteras de la provincia golpeada. La caída de actividad en la provincia bajo administración forzosa correspondería a un **aumento** de actividad en áreas cercanas, induciendo una **correlación negativa**.

Si cualquiera de los dos canales fuera empíricamente relevante, las estimaciones estarían perdiendo parte de los efectos del shock de gasto.

**Cómo lo miden (Tabla 6):**

Definen $SG_{i,t} = \dfrac{Sg_{i,t} - Sg_{i,t-1}}{Sy_{i,t-1}}$, donde $Sg_{i,t}$ es la inversión per cápita de las provincias que están **en la misma región**, excluyendo a la provincia $i$ misma, y $Sy_{i,t-1}$ se define análogamente.

| Parámetro | (1) | (2) | (3) |
|---|---:|---:|---:|
| $G(t)$ | 1.44\*\* [0.47] | 1.50\*\*\* [0.41] | 1.24\*\* [0.45] |
| $G(t-1)$ | 0.73\*\*\* [0.20] | 0.76\*\*\* [0.17] | 0.74\*\*\* [0.23] |
| $SG(t)$ | 0.20 [0.18] | — | — |
| $SG(t-1)$ | **0.35\*** [0.16] | — | — |
| $G(t-1) \times SG(t-1)$ | — | 0.19 [0.12] | — |
| F instrumentos | 10.61 | 12.00 | **24.20** |
| Observaciones | 950 | 950 | 410 |

- **Columna 1**: añade $SG(t)$ y su primer rezago. Los autores escriben: *"Los coeficientes de la variable recién definida y su rezago son bajos; el de $SG_{i,t}$ no es significativamente distinto de cero."*
- **Columna 2**: interactúa $SG_{i,t-1}$ con $G_{i,t-1}$, ambos medidos en desviación de su media. Esto permite complementariedad (por fugas de demanda) o sustituibilidad (por alta movilidad espacial de factores). El coeficiente de la interacción **no es significativo**.
- **Columna 3**: reemplaza las observaciones de provincias pequeñas agregando dos o tres provincias adyacentes en una sola área. El F de instrumentos excluidos sube a ~24. El coeficiente de $G_{i,t}$ cae algo; el de $G_{i,t-1}$ queda más o menos inalterado.

**Su conclusión:** *"En conjunto, de estos ejercicios, la evidencia sobre los efectos de derrame de las contracciones de gasto es débil."*

> ⚠️ **Ojo con este detalle:** aunque los autores describen la evidencia como "débil", **$SG(t-1) = 0.35$ es significativo al 5%**. Ellos lo minimizan, pero está ahí. Este matiz es importante para nuestro trabajo: no es que hayan encontrado un cero rotundo, sino que consideraron la evidencia insuficiente para afirmar la existencia de derrames.

### 9.2 Influencia de provincias individuales (Tabla 7)

Algunos episodios podrían tener influencia desproporcionada, igual que se reconoce que ciertos episodios de expansión fiscal (como el rearme de EE.UU. en la Segunda Guerra) son clave para identificar multiplicadores agregados. Los autores re-estiman excluyendo por turnos las provincias con más episodios de disolución.

| Provincia excluida | $G(t)$ | $G(t-1)$ | F |
|---|---:|---:|---:|
| Napoli | 1.86\*\*\* | 0.93\*\*\* | 19.59 |
| Caserta | 1.47\*\* | 0.76\*\*\* | 9.48 |
| Palermo | 1.46\* | 0.76\*\*\* | 11.31 |
| Catania | 1.35 | 0.72\*\* | 10.90 |
| Salerno | 1.36\*\* | 0.72\*\*\* | 9.25 |
| Bari | 1.53\*\*\* | 0.78\*\*\* | 11.85 |
| Reggio Calabria | 1.37\*\* | 0.73\*\*\* | 9.42 |

Ninguna provincia individual resulta determinante. Las estimaciones puntuales de $\beta$ (todas significativas al 5%) quedan en el rango **1.35–1.86**, en proporción aproximadamente constante respecto a los coeficientes del primer rezago del gasto.

### 9.3 Heterogeneidad por macro-área, tiempo y efectos fijos (Tabla 8)

| Parámetro | Excluir norte | Sin $\lambda_t$ | Sin $\alpha_i$ |
|---|---:|---:|---:|
| $G(t)$ | 1.89\*\*\* [0.42] | 1.92\*\*\* [0.52] | 1.62\*\*\* [0.37] |
| $G(t-1)$ | 0.95\*\*\* [0.19] | 0.75\*\* [0.27] | 0.74\*\*\* [0.18] |
| $Y(t-1)$ | −0.34\*\*\* [0.10] | −0.14\* [0.06] | −0.11 [0.07] |
| F instrumentos | 10.54 | 23.89 | 13.16 |
| Observaciones | **340** | 950 | 950 |

- **Excluir el norte** (sólo provincias del sur): los coeficientes contemporáneo y rezagado suben algo (1.89 y 0.95), pero también sube en valor absoluto el coeficiente del crecimiento rezagado (−0.34). Como el multiplicador dinámico divide por $(1-\phi_1)$, **la estimación del multiplicador global queda inalterada**.
- **Quitar efectos fijos de año**: el contemporáneo sube a 1.92, pero los rezagos quedan inalterados.
- **Quitar efectos fijos de provincia**: $\beta = 1.62$.

Conclusión: *"ninguno de estos experimentos parece producir resultados significativamente distintos de los de la estimación base."*

---

## 10. Conclusiones del paper

1. **Efecto de corto plazo no despreciable** del gasto público a nivel local: multiplicador de **1.5 en impacto** y **1.9 incluyendo efectos dinámicos**, apoyándose en episodios de contracciones fuertes del gasto en infraestructura.

2. **No encuentran derrames relevantes** del shock de gasto de una provincia sobre la actividad económica de provincias cercanas.

3. Por las características del modelo y los datos, estas estimaciones **no reflejan interacciones de política presupuestaria y monetaria** — interacciones que sí juegan un rol clave en determinar los efectos agregados del gasto público financiado con déficit a nivel nacional.

4. **Relevancia de política:**
   - Iluminan hasta qué punto (y bajo qué condiciones) las herramientas fiscales, principalmente vía redistribución de recursos, pueden ser instrumentos efectivos para atender caídas económicas localizadas.
   - En tiempos de crisis, el estrés financiero y fiscal puede forzar a gobiernos locales a implementar recortes profundos y súbitos, con gran variación en su intensidad entre áreas. Las diferencias en la intensidad de ese ajuste pueden traducirse en **variación geográfica significativa de la actividad económica**.

5. **La interpretación teórica**: las provincias italianas son economías muy pequeñas y muy abiertas que comparten una moneda común. Los resultados sugieren que economías con estas características pueden ser bastante **"insulares"** en su respuesta dinámica a variaciones temporales del gasto público.

   El mecanismo (nota al pie 32 del paper) es interesante: en un área monetaria, una contracción inesperada de la demanda pública tiende a reducir los precios locales en el corto plazo. Dados los tipos nominales, esto eleva la tasa de interés real de corto plazo en la región. Pero como la paridad de poder adquisitivo se cumple en el mediano-largo plazo, se espera que los precios locales vuelvan al nivel prevaleciente fuera de la región; correspondientemente, se espera que las tasas reales futuras de corto plazo caigan. Estos movimientos opuestos implican que **la respuesta de la tasa real de largo plazo —la relevante para las decisiones de gasto privado— es bastante pequeña**. Como resultado, la demanda privada no se estimula apreciablemente y la actividad económica tiende a caer inicialmente por la magnitud completa de la contracción fiscal inesperada.

---

## 11. Por qué hace falta ampliar a modelos espaciales

Esta es la justificación de nuestro trabajo. Hay cuatro argumentos, en orden de fuerza.

### 11.1 Los propios autores lo piden explícitamente

En el penúltimo párrafo de las conclusiones, Acconcia, Corsetti y Simonelli escriben:

> "Sin embargo, el análisis de multiplicadores locales plantea cuestiones distintivas, típicamente no abordadas en los estudios de economía abierta. Como se discutió en la Sección VI de este artículo, por ejemplo, los **derrames transfronterizos a nivel local pueden diferir** de los implicados por las 'fugas de demanda' que enfatiza la literatura de economía abierta. **Su estudio requiere una especificación cuidadosa, tanto a nivel teórico como empírico, de modelos espaciales que den cuenta de la movilidad transfronteriza tanto de capital como de trabajo. Esta es una nueva dirección prometedora para la investigación**, que podría ayudar a tender un puente entre las dimensiones local y agregada del multiplicador, proporcionando un marco para evaluar los efectos combinados a nivel nacional de transferir recursos entre regiones."

No es que nosotros estemos forzando una extensión artificial: **el paper señala los modelos espaciales como el siguiente paso natural de su propia agenda de investigación.**

### 11.2 Su test de derrames es rudimentario

Lo que hacen en la Sección V.A es añadir $SG_{i,t}$ —el gasto agregado de las otras provincias de la misma región— como un regresor más. Eso tiene cinco limitaciones concretas:

| Limitación | Consecuencia |
|---|---|
| **Vecindad administrativa, no geográfica** | Dos provincias limítrofes que pertenecen a regiones distintas **no cuentan como vecinas**. Reggio Calabria y Messina están separadas por 3 km de estrecho, pero pertenecen a regiones distintas (Calabria y Sicilia) → el método las trata como no vecinas |
| **Pesos implícitos uniformes** | Todas las provincias de una región pesan igual, sin importar distancia ni contigüidad efectiva |
| **No modela dependencia en la variable dependiente** | No permite que $Y_i$ dependa de $Y_j$ (rezago espacial $WY$), sólo que $Y_i$ dependa de $G_j$ |
| **No modela dependencia en los errores** | No permite choques regionales comunes no observados en $\varepsilon$ (término $W\varepsilon$) |
| **No permite descomponer efectos** | No se pueden calcular efectos directos, indirectos y totales en el sentido de LeSage y Pace (2009) |

La última limitación es especialmente relevante. En un modelo espacial con rezago de la dependiente, el efecto de un cambio en $G_i$ sobre $Y_i$ **no es simplemente $\beta$**: incluye la retroalimentación que pasa por los vecinos y vuelve ($i \to j \to i$). La matriz de efectos es

$$\frac{\partial Y}{\partial G'} = (I - \rho W)^{-1}(\beta I + \theta W)$$

de donde el **efecto directo** es el promedio de la diagonal, el **indirecto** el promedio de las sumas de filas fuera de la diagonal, y el **total** su suma. Con el enfoque de $SG$ esta descomposición simplemente no existe.

### 11.3 Hay razones sustantivas para esperar dependencia espacial

Los propios autores reconocen que las provincias de una misma región están correlacionadas — de hecho **agrupan los errores estándar a nivel región × año precisamente por eso**, citando a Guiso, Sapienza y Zingales (2004). Pero agrupar errores es una corrección de **inferencia**, no un modelo de la dependencia: reconoce que existe correlación sin modelar su estructura ni extraer información de ella.

Además, los canales económicos que ellos mismos describen son intrínsecamente espaciales:
- **Cadenas de suministro de contratistas**: las empresas que ejecutan obra pública operan en mercados que no respetan fronteras provinciales
- **Movilidad laboral**: los trabajadores de la construcción se desplazan entre provincias
- **Relocalización de factores**: el canal 2 que ellos plantean es literalmente un fenómeno de difusión espacial
- **Relocalización de actividades mafiosas**: los autores mencionan explícitamente en la Sección IV.A que "cualquier relocalización de actividades mafiosas entre provincias puede hacer nuestros resultados sensibles al nivel de agregación que usamos"

### 11.4 La evidencia que reportan no es un cero limpio

Como se señaló en la sección 9.1: $SG(t-1) = 0.35$ **es significativo al 5%** en su propia Tabla 6. Los autores lo describen como evidencia "débil", pero la lectura estricta es que su especificación detecta *algo* y no puede caracterizarlo bien. Un tratamiento espacial formal puede: (a) confirmar que ese coeficiente es ruido, o (b) revelar estructura que su método no capta. Ambos resultados son informativos.

### 11.5 Qué aporta concretamente el enfoque espacial

| Herramienta | Qué permite hacer que el paper no hace |
|---|---|
| **Matriz de pesos $W$** (k-vecinos, contigüidad reina, distancia inversa) | Definir vecindad por geografía efectiva, con robustez a la definición elegida |
| **I de Moran global y local (LISA)** | Documentar y visualizar la estructura espacial del crecimiento provincial; identificar clusters High-High y Low-Low |
| **Tests LM de Anselin / protocolo de Elhorst (2010)** | Contrastar formalmente si la dependencia está en la variable dependiente, en los errores, o en ambas |
| **SAR** ($\rho WY$) | Modelar que el crecimiento de una provincia depende del de sus vecinas |
| **SEM** ($\lambda W\varepsilon$) | Modelar choques regionales comunes no observados |
| **SDM** ($\rho WY + WX\theta$) | Modelar ambos canales y permitir que el gasto de los vecinos afecte directamente |
| **Impactos de LeSage-Pace** | Descomponer en efecto directo, indirecto y total, con intervalos de confianza |
| **GMM espacial (Kelejian-Prucha)** | Corregir dependencia espacial **y** endogeneidad simultáneamente |

### 11.6 Una advertencia metodológica esencial

Hay un punto técnico que resulta decisivo y que conviene tener muy claro:

> **La estimación por máxima verosimilitud de modelos espaciales de panel (`splm::spml` en R) NO admite variables instrumentales.**

Esto significa que si uno estima un SAR, SEM o SDM por ML sobre estos datos, **está tratando $G$ como exógena** — exactamente el supuesto que todo el diseño cuasi-experimental del paper se construyó para evitar. Y como el paper demuestra que el sesgo de tratar $G$ como exógena es de un factor de **siete**, los coeficientes que salen de esos modelos son esencialmente estimaciones tipo MCO con una corrección espacial encima.

En la práctica esto se ve inmediatamente: los modelos ML entregan multiplicadores de 0.13–0.15, muy cerca del MCO (0.20) y lejísimos del 2SLS (1.55).

**La solución** es el estimador de Momentos Generalizados de Kelejian-Prucha (`splm::spgm`), que sí acepta instrumentos externos y estima la dependencia espacial simultáneamente. Cualquier extensión espacial seria de este paper **tiene que** preservar la estrategia de identificación; de lo contrario se está tirando por la borda justamente lo que hace valioso al artículo original.

---

## 12. Resumen ejecutivo en diez puntos

1. **Pregunta**: ¿cuál es el multiplicador fiscal del gasto público a nivel subnacional?
2. **Problema**: el gasto es endógeno (anticipación de proyectos + asignación contracíclica), lo que sesga el MCO hacia cero.
3. **Solución**: instrumentar con las disoluciones de concejos municipales por infiltración mafiosa (Ley 164/1991), que producen recortes de gasto abruptos, no anticipados y ajenos al ciclo económico local.
4. **Datos**: panel de 95 provincias italianas, 1990–1999, 950 observaciones.
5. **Método**: 2SLS con efectos fijos de provincia y año, ponderado por población, con errores agrupados a nivel región × año (190 clusters).
6. **Instrumentos**: $CDS1$ (disoluciones decretadas en el primer semestre) y $CDS2_{t-1}$ (disoluciones con menos de 180 días hasta fin de año, rezagadas), ambas ponderadas por población.
7. **Resultado principal**: multiplicador de impacto **1.5**, dinámico a dos años **1.29**, acumulado **1.95**. El IV es siete veces el MCO.
8. **Validación**: sin tendencias previas diferenciales; los instrumentos son fuertes (F ≈ 12); Hansen no rechaza; disoluciones no mafiosas no producen ni recortes de gasto ni efectos sobre el producto; excluir los controles de mafia *reduce* el multiplicador (lo que descarta sesgo al alza por ese canal).
9. **Sobre derrames**: los evalúan con un método simple (gasto regional agregado como regresor) y concluyen que la evidencia es débil, calificando a las economías provinciales de "insulares".
10. **La brecha que llenamos**: el tratamiento de los derrames es rudimentario y los propios autores señalan los modelos espaciales como la dirección prometedora. Aplicamos la caja de herramientas completa de econometría de panel espacial —preservando la identificación por IV mediante GMM espacial— para someter esa conclusión a escrutinio formal.

---

## Referencias clave citadas en el paper

- **Blanchard, O. y Perotti, R. (2002)**, QJE — identificación SVAR de shocks fiscales; de ahí viene el supuesto de que los rezagos de $G$ están predeterminados
- **Nakamura, E. y Steinsson, J. (2014)**, AER — multiplicadores locales de 1.4–1.9 con gasto militar en EE.UU.; también encuentran gran brecha MCO-IV
- **Chodorow-Reich et al. (2012)**, AEJ:Policy — efectos del ARRA sobre empleo estatal; implican multiplicador cercano a 2
- **Serrato, J.C.S. y Wingender, P. (2011)** — reasignación de fondos por revisiones de estimaciones poblacionales; multiplicador 1.88
- **Shoag, D. (2010)** — retornos de fondos de pensiones estatales como instrumento; multiplicador 2.12
- **Fishback, P. y Kachanovskaya, V. (2010)** — voto pendular como instrumento durante el New Deal; multiplicador de obras públicas 1.67
- **Clemens, J. y Miran, S. (2012)**, AEJ:Policy — multiplicadores no significativos usando reglas de presupuesto equilibrado
- **Guiso, L., Sapienza, P. y Zingales, L. (2004)** — de donde toman el esquema de agrupamiento de errores por región
- **Corsetti, G., Kuester, K. y Müller, G. (2013)** — modelos neokeynesianos de política fiscal regional en unión monetaria; racionalizan multiplicadores en torno o por encima de 1
- **Sims, C. (2010)** — la crítica sobre modelos de ecuación única frente a SVAR
- **Bertrand, M., Duflo, E. y Mullainathan, S. (2004)** — problemas de inferencia con correlación serial en diferencias-en-diferencias
