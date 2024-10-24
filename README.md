[Nuestra web](https://beta-web-llm.netlify.app/index.html)


**Integrantes actuales**
---------------
- Félix Francisco Canosa
- Tiziano Aguilar
- Carlos Gomes


**¿De qué trata?**
=====================

**Pantallazo general**
--------------------

Un juego (programa) educativo, sostenible y que concientiza el cuidado de la naturaleza a través del interativo diálogo generado por IAs (MLL) y el motor gráfico Godot Engine para sostener la arquitectura y lógica del juego.

**Premisa del juego**
--------------------

La premisa sería que el protagonista (un ser no-humano, hecho de hojas y madera), nace en un bosque milenario producto de la deforestación de los humanos, siendo su misión principal solucionar el problema de la deforestación.


## Diagrama de Gantt del Desarrollo

```mermaid
gantt
    title Desarrollo del Proyecto OrBER y Página Web
    dateFormat YYYY-MM-DD
    section Juego Alpha 1.0
    Configuración de Godot Engine      :done, a1, 2024-01-01, 14d
    Implementación de Godot LLM (IA) - Prototipo :done, a2, after a1, 21d
    Diseño del personaje principal     :done, a3, 2024-01-15, 14d
    Creación del bosque milenario (En progreso) :active, a4, after a3, 21d
    Refinamiento de prototipos IA      :a5, after a2, 30d
    Mecánicas básicas del jugador      :a6, after a4, 14d
    Implementación de diálogos IA      :a7, after a5, 21d
    Sistema de misiones básico         :a8, after a6 a7, 14d
    Optimización y pruebas             :a9, after a8, 14d
    
    section Update 2.0
    Diseño del pueblo a las afueras    :b1, 2024-07-01, 21d
    Mejora de mecánicas del jugador    :b2, after b1, 14d
    Implementación de NPCs con IA      :b3, after b2, 21d
    Sistema de misiones avanzado       :b4, after b3, 14d
    Integración de temas ambientales   :b5, after b4, 14d
    Implementación de efectos y sonidos :b6, after b5, 10d
    Optimización para múltiples plataformas :b7, after b6, 14d
    Pruebas de usuario y ajustes       :b8, after b7, 14d
    
    section Lanzamiento y Mantenimiento
    Preparación para lanzamiento       :c1, 2024-12-01, 14d
    Lanzamiento versión beta           :milestone, c2, after c1, 0d
    Recopilación de feedback           :c3, after c2, 21d
    Actualizaciones y correcciones     :c4, after c3, 30d
    Desarrollo de contenido adicional  :c5, after c4, 60d

    section Página Web (Wiki)
    Diseño inicial Frontend            :done, w1, 2024-01-01, 30d
    Implementación sección Home        :done, w2, after w1, 7d
    Implementación sección Personajes  :active, w3, after w2, 14d
    Implementación sección General     :w4, after w3, 14d
    Implementación sección Registro    :w5, after w4, 7d
    Implementación sección Nosotros    :w6, after w5, 7d
    Refinamiento del Frontend          :w7, after w6, 21d
    Diseño de la arquitectura Backend  :w8, 2024-10-01, 21d
    Desarrollo del Backend             :w9, after w8, 45d
    Integración Frontend-Backend       :w10, after w9, 30d
    Pruebas y optimización             :w11, after w10, 21d
    Lanzamiento de la página web       :milestone, w12, after w11, 0d
    Mantenimiento y actualizaciones    :w13, after w12, 90d
```
## Diagrama de Gantt del Desarrollo actual

```mermaid
gantt
    title Desarrollo del Proyecto OrBER y Página Web
    dateFormat YYYY-MM-DD
    
    section Juego Alpha 1.0
    Configuración de Godot Engine :done, a1, 2024-09-01, 14d
    Diseño del personaje principal :done, a3, 2024-09-15, 14d
    Implementación de mecánicas básicas del jugador :done, a6, 2024-09-29, 14d
    Implementación de NPCs con personalidad :done, a7, 2024-10-13, 5d
    Implementación de diálogos básicos :active, a8, 2024-10-17, 7d
    
    section Futuras Actualizaciones
    Diseño del bosque milenario :b1, 2024-11-01, 21d
    Implementación de Godot LLM (IA) :b2, after b1, 30d
    Sistema de misiones básico :b3, after b2, 14d
    Optimización y pruebas :b4, after b3, 14d
    
    section Página Web (Wiki)
    Diseño inicial Frontend :done, w1, 2024-09-01, 30d
    Implementación sección Home :done, w2, 2024-10-01, 7d
    Implementación sección Personajes :active, w3, 2024-10-08, 14d
    Implementación sección General :w4, after w3, 14d
    Implementación sección Registro :w5, after w4, 7d
    Implementación sección Nosotros :w6, after w5, 7d
    
    section Desarrollo Futuro
    Refinamiento del Frontend :f1, 2025-01-01, 21d
    Diseño de la arquitectura Backend :f2, after f1, 21d
    Desarrollo del Backend :f3, after f2, 45d
    Integración Frontend-Backend :f4, after f3, 30d
    Pruebas y optimización :f5, after f4, 21d
    Lanzamiento de la página web completa :milestone, f6, after f5, 0d
```

---

# Registro de Actualizaciones del Proyecto

## 2024

### Agosto

#### 25 de agosto de 2024 (4 horas de implementación)

- 🎮 Nuevo prototipo del juego de Godot exportado directamente en la web
  - Etapa muy temprana de desarrollo
  - Exportado para funcionar en navegadores web
  ![Captura del prototipo del juego](https://iili.io/dXPMBDu.png)

- 📝 Inicio de la documentación del proceso de desarrollo
  - Este medio se utilizará para documentar todo el proceso de creación y evolución del juego



#### 28 de noviembre de 2024 (6 horas de implementación)

- 🦋 Implementación de NPC Mariposa
  - Primer NPC ambiental añadido al mundo del juego
  - Mejora la inmersión y la vivacidad del entorno

##### Características principales:

- Implementación de un NPC mariposa utilizando CharacterBody2D
- Movimiento autónomo con NavigationRegion2D para un vuelo realista
- Animaciones fluidas con AnimatedSprite2D, incluyendo direcciones up, down, left, y right
- Sistema de puntos de navegación para definir la ruta de vuelo de la mariposa

##### Nodos utilizados:
- CharacterBody2D
- NavigationAgent2D
- AnimatedSprite2D

##### Captura de pantalla:

![Captura de la Mariposa NPC](https://iili.io/djPTCBI.png)

##### Video demostrativo:

[Ver video completo en YouTube](https://youtu.be/_rCgBa5-MK4)




---


