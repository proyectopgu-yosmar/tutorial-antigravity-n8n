import os
import subprocess
import asyncio
import edge_tts
from PIL import Image, ImageDraw, ImageFont

BASE_DIR = os.path.dirname(os.path.abspath(__file__))

# Script text per scene
SCENES = [
    {
        "text": "Estimada Gerencia: Hoy aprenderemos a instalar y configurar nuestro entorno de agentes de Inteligencia Artificial para automatización de procesos. Uniremos Google Antigravity con n8n. En cuatro pasos sencillos dejaremos el sistema cien por ciento operativo.",
        "image": "00_presentador.jpg",
        "title": "TUTORIAL DE INSTALACIÓN: AGENTES DE IA",
        "audio": "audio_1.mp3"
    },
    {
        "text": "Paso uno: Descargamos Antigravity desde antigravity.google e iniciamos sesión con Google. Es nuestro asistente inteligente que creará las automatizaciones por nosotros.",
        "image": "01_antigravity.jpg",
        "title": "PASO 1: INSTALAR GOOGLE ANTIGRAVITY",
        "audio": "audio_2.mp3"
    },
    {
        "text": "Paso dos: En GitHub vamos a Settings, Developer Settings y creamos un Personal Access Token clásico marcando el permiso repo. Esta es la llave para consultar librerías y componentes.",
        "image": "02_github_token.png",
        "title": "PASO 2: CREAR TOKEN EN GITHUB (repo)",
        "audio": "audio_3.mp3"
    },
    {
        "text": "Paso tres: Abrimos n8n en el navegador en localhost 5678, vamos a Configuración, n8n API, y creamos la clave Antigravity. Esto autoriza a la inteligencia artificial a crear y modificar flujos sin dibujarlos a mano.",
        "image": "03_n8n_apikey.png",
        "title": "PASO 3: OBTENER API KEY EN n8n",
        "audio": "audio_4.mp3"
    },
    {
        "text": "Paso cuatro: Le pedimos a Antigravity crear la automatización y los nodos aparecen conectados. Al pulsar Execute workflow, ambos nodos marcan check verde con éxito total. La instalación está lista para producción.",
        "image": "05_flujo_ejecutado_verde.png",
        "title": "PASO 4: PRUEBA Y VERIFICACIÓN EXITOSA",
        "audio": "audio_5.mp3"
    }
]

async def generate_audios():
    voice = "es-VE-SebastianNeural"
    for i, s in enumerate(SCENES):
        path = os.path.join(BASE_DIR, s["audio"])
        tts = edge_tts.Communicate(s["text"], voice)
        await tts.save(path)
        print(f"Audio {i+1} generado.")

def get_audio_duration(audio_path):
    try:
        import imageio_ffmpeg
        ffmpeg_exe = imageio_ffmpeg.get_ffmpeg_exe()
    except Exception:
        ffmpeg_exe = "ffmpeg"
    
    cmd = [ffmpeg_exe, "-i", audio_path]
    result = subprocess.run(cmd, stderr=subprocess.PIPE, stdout=subprocess.PIPE, text=True)
    for line in result.stderr.splitlines():
        if "Duration:" in line:
            parts = line.split("Duration:")[1].split(",")[0].strip().split(":")
            return float(parts[0]) * 3600 + float(parts[1]) * 60 + float(parts[2])
    return 10.0

def build_scene_image(scene, out_path):
    # 1280x720 canvas
    width, height = 1280, 720
    bg = Image.new("RGB", (width, height), color=(20, 22, 28))
    
    # Load step image
    step_img_path = os.path.join(BASE_DIR, scene["image"])
    if os.path.exists(step_img_path):
        img = Image.open(step_img_path)
        # fit inside left/main area (e.g. 960x600)
        img.thumbnail((940, 580))
        bg.paste(img, (20, 80))
    
    # Load presenter photo on bottom right badge
    pres_path = os.path.join(BASE_DIR, "00_presentador.jpg")
    if os.path.exists(pres_path) and scene["image"] != "00_presentador.jpg":
        pres = Image.open(pres_path)
        pres.thumbnail((260, 260))
        bg.paste(pres, (980, 420))
    
    # Title bar
    draw = ImageDraw.Draw(bg)
    draw.rectangle([(0, 0), (width, 60)], fill=(35, 40, 52))
    draw.text((30, 18), scene["title"], fill=(255, 255, 255))
    
    bg.save(out_path)

def main():
    print("1. Generando audios con voz neural...")
    asyncio.run(generate_audios())
    
    import imageio_ffmpeg
    ffmpeg_exe = imageio_ffmpeg.get_ffmpeg_exe()
    
    concat_list = []
    
    print("2. Creando escenas y clips...")
    for i, s in enumerate(SCENES):
        img_out = os.path.join(BASE_DIR, f"slide_{i+1}.png")
        build_scene_image(s, img_out)
        
        audio_file = os.path.join(BASE_DIR, s["audio"])
        dur = get_audio_duration(audio_file) + 1.0  # 1s padding
        
        clip_out = os.path.join(BASE_DIR, f"clip_{i+1}.mp4")
        
        # Build clip
        cmd = [
            ffmpeg_exe, "-y",
            "-loop", "1", "-i", img_out,
            "-i", audio_file,
            "-c:v", "libx264", "-tune", "stillimage", "-c:a", "aac", "-b:a", "192k",
            "-pix_fmt", "yuv420p", "-t", str(dur),
            clip_out
        ]
        subprocess.run(cmd, check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        print(f"Clip {i+1} creado ({dur:.1f}s).")
        concat_list.append(clip_out)
    
    # Concat
    list_path = os.path.join(BASE_DIR, "clips.txt")
    with open(list_path, "w") as f:
        for c in concat_list:
            f.write(f"file '{c}'\n")
            
    final_video = os.path.join(BASE_DIR, "tutorial_instalacion_gerencia.mp4")
    cmd_concat = [
        ffmpeg_exe, "-y",
        "-f", "concat", "-safe", "0",
        "-i", list_path,
        "-c", "copy",
        final_video
    ]
    subprocess.run(cmd_concat, check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    print(f"\n¡VIDEO FINAL COMPLETADO CON ÉXITO!\nGuardado en: {final_video}")

if __name__ == "__main__":
    main()
