import cv2
import numpy as np
import matplotlib.pyplot as plt
import os

# Verifica la ruta actual para comprobar si las imágenes están en el directorio
print(f"Directorio actual: {os.getcwd()}")

# Paso 1: Cargar imágenes originales y verificar que existan
image_files = [f'img/frame_{str(i).zfill(2)}.jpg' for i in range(20)]
images_original = []

for file in image_files:
    img = cv2.imread(file)
    if img is not None:
        images_original.append(img)
    else:
        print(f"[WARN] No se pudo cargar la imagen: {file}")

# Verificar si se cargaron imágenes
if not images_original:
    raise FileNotFoundError("No se cargaron imágenes. Verifica las rutas o el directorio actual.")

# Paso 2: Convertir a escala de grises y aplicar ecualización CLAHE
clahe = cv2.createCLAHE(clipLimit=3.0, tileGridSize=(8, 8))
images_gray = [cv2.cvtColor(img, cv2.COLOR_BGR2GRAY) for img in images_original]
images_clahe = [clahe.apply(gray) for gray in images_gray]

# Paso 3: Inicializar variables
cumulative_deforestation = np.zeros_like(images_gray[0], dtype=np.uint8)
areas_deforestadas = []

# Escala correcta: 0.1 km² por píxel
km_per_pixel = 0.1 * 0.1  # (km²)

# Paso 4: Proceso de resta, Otsu y acumulación
for i in range(1, len(images_clahe)):
    diff = cv2.absdiff(images_clahe[i], images_clahe[i-1])
    diff_blurred = cv2.GaussianBlur(diff, (5, 5), 0)
    _, diff_otsu = cv2.threshold(diff_blurred, 0, 255, cv2.THRESH_BINARY + cv2.THRESH_OTSU)
    kernel = np.ones((3, 3), np.uint8)
    diff_closed = cv2.morphologyEx(diff_otsu, cv2.MORPH_CLOSE, kernel)
    cumulative_deforestation = cv2.bitwise_or(cumulative_deforestation, diff_closed)
    num_white_pixels = cv2.countNonZero(cumulative_deforestation)
    area_deforestada = num_white_pixels * km_per_pixel
    areas_deforestadas.append(area_deforestada)
    print(f"Año {2000 + i}: Área deforestada acumulada = {area_deforestada:.2f} km²")

# Mostrar imágenes de diferencias
plt.figure(figsize=(15, 5))
for i in range(3):
    plt.subplot(1, 3, i+1)
    plt.imshow(cumulative_deforestation, cmap='gray')
    plt.title(f"Deforestación Acumulada ({2000 + i})")
    plt.axis('off')
plt.show()

# Graficar la evolución
plt.figure(figsize=(10, 6))
years = [2000 + i for i in range(1, len(areas_deforestadas)+1)]
plt.plot(years, areas_deforestadas, marker='o', linestyle='-', color='b', label='Área deforestada acumulada')
plt.title('Evolución del Área Deforestada Acumulada (2001-2019)')
plt.xlabel('Año')
plt.ylabel('Área deforestada acumulada (km²)')
plt.grid(True)
plt.legend()
plt.show()
