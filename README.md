# 🎬 Tutorial de Instalación: Antigravity + n8n + GitHub (Guía y Recursos)

Este repositorio contiene todo el material, imágenes oficiales, guiones y scripts para producir el video tutorial didáctico de instalación para la Gerencia General.

---

## 📁 Contenido del Repositorio

* `00_presentador.jpg`: Fotografía en alta resolución del presentador.
* `01_antigravity.jpg`: Pantalla oficial de descarga y bienvenida de Antigravity IDE.
* `02_github_token.png`: Captura de pantalla de la creación del Token de GitHub (`repo`).
* `03_n8n_apikey.png`: Captura de pantalla de la creación de la API Key en n8n (`Antigravity-ProyectoPGU`).
* `04_flujo_creado.png`: El lienzo con los dos nodos conectados (`Iniciar Manualmente` ➔ `Mensaje de Bienvenida`).
* `05_flujo_ejecutado_verde.png`: La prueba de fuego exitosa con ambos nodos en verde (`1 item`).
* `crear_video.py`: Script de Python con FFmpeg y Edge-TTS para compilar el video con voz neural 100% gratis.
* `guion_tutorial.txt`: El guión palabra por palabra listo para locutar o leer.

---

## 🏠 Cómo continuar este trabajo en tu casa (Cualquier PC)

Aunque en tu casa uses otro correo personal, este repositorio es **público y accesible desde cualquier navegador o computadora**.

### Opción 1: Ver y descargar los archivos desde la web
1. En tu casa, abre tu navegador y entra a:
   👉 **[https://github.com/proyectopgu-yosmar/tutorial-antigravity-n8n](https://github.com/proyectopgu-yosmar/tutorial-antigravity-n8n)**
2. Haz clic en el botón verde **`<> Code`** ➔ **`Download ZIP`**.
3. Descomprimes la carpeta y tendrás todas las imágenes y el guión listos para trabajar.

### Opción 2: Clonar con Git en tu casa
Si tienes Git instalado en tu computadora de casa:
```bash
git clone https://github.com/proyectopgu-yosmar/tutorial-antigravity-n8n.git
```

---

## 🎙️ Guión Didáctico para el Video (Minuto a Minuto)

### Bloque 1: Introducción (0:00 - 0:15)
> *"Estimada Gerencia: Hoy aprenderemos a instalar y configurar nuestro entorno de agentes de Inteligencia Artificial para automatización de procesos. Uniremos Google Antigravity con n8n. En 4 pasos sencillos dejaremos el sistema 100% operativo."*
* **Imagen:** `00_presentador.jpg`

### Bloque 2: Paso 1 - Antigravity (0:15 - 0:30)
> *"Paso 1: Descargamos Antigravity desde antigravity.google e iniciamos sesión con Google. Es nuestro asistente inteligente que creará los flujos por nosotros."*
* **Imagen:** `01_antigravity.jpg`

### Bloque 3: Paso 2 - GitHub Token (0:30 - 0:50)
> *"Paso 2: En GitHub vamos a Settings, Developer Settings y creamos un Personal Access Token clásico marcando el permiso 'repo'. Esta es la llave para consultar librerías y componentes."*
* **Imagen:** `02_github_token.png`

### Bloque 4: Paso 3 - n8n API Key (0:50 - 1:15)
> *"Paso 3: Abrimos n8n en localhost:5678, vamos a Configuración, n8n API, y creamos la clave 'Antigravity'. Esto autoriza a la IA a crear y modificar flujos sin dibujarlos a mano."*
* **Imagen:** `03_n8n_apikey.png`

### Bloque 5: Paso 4 - Prueba y Demostración (1:15 - 1:40)
> *"Paso 4: Le pedimos a Antigravity crear la automatización y los nodos aparecen conectados. Al pulsar 'Execute workflow', ambos nodos marcan check verde con éxito total. La instalación está lista para producción."*
* **Imágenes:** `04_flujo_creado.png` y `05_flujo_ejecutado_verde.png`

---

## 🔄 Cómo sincronizar cuando vuelvas al servidor el lunes
Si haces cambios en tu casa y los subes a GitHub:
1. En el servidor del trabajo, simplemente abres la terminal en esta carpeta y ejecutas:
   ```bash
   git pull
   ```
¡Y todo lo que hayas avanzado en tu casa se descargará automáticamente aquí!
