<template>
    <plantilla>
      <!-- Contenido de la Página -->
      <div class="contenido-pagina">
        <div class="perfil-header">
          <!-- Título del psicoterapeuta -->
          <h1 class="titulo-psicoterapeuta">PSICOTERAPEUTA</h1>
          <!-- Barra de color con círculo -->
          <div class="barra-color">
            <div class="circulo" :style="{ backgroundImage: 'url(' + imagenPsicologo + ')' }"></div>
          </div>
        </div>
        <!-- Información del psicoterapeuta -->
        <div class="informacion-psicoterapeuta">
          <h2>{{ informacion.nombre }}</h2>
          <div class="especialidad">{{ informacion.especialidad }}</div>
          <p class="contacto"><a :href="'tel:' + informacion.telefono">{{ informacion.telefono }}</a></p>
          <p class="contacto"><a :href="'https://www.google.com/maps/search/?api=1&query=' + encodeURIComponent(informacion.direccion)">{{ informacion.direccion }}</a></p>
          <div class="trabajo">
            <h3>ESPECIALIDAD</h3>
            <p>{{ informacion.especialidad }}</p>
            <h3>POBLACIÓN A ATENDER</h3>
            <p>{{ informacion.poblacion }}</p>
            <h3>FORMACIÓN ACADÉMICA</h3>
            <p>{{ informacion.formacion }}</p>
            <h3>MODALIDAD</h3>
            <p>{{ informacion.modalidad }}</p>
          </div>
        </div>
        <!-- Botón Regresar al inicio -->
        <router-link to="/" class="boton-regresar">Regresar al inicio</router-link>
      </div>
    </plantilla>
  </template>
  
  <script>
  import Plantilla from '../plantilla.vue';
  
  export default {
    components: {
      Plantilla,
    },
    data() {
      return {
        imagenPsicologo: [
          "https://i.postimg.cc/NFNY2Krd/DRA-ELVIRA-GOPAR-CANSECO.png",
          // Agrega más URL de imágenes según sea necesario
        ],
        informacion: {
          nombre: 'DRA. ELVIRA GOPAR CANSECO',
          especialidad: 'TERAPIA HUMANISTA',
          telefono: '951 109 63 72',
          direccion: 'Independencia 305, interior 105. Casi esquina con Crespo, Centro.',
          poblacion: 'Niños, adolescentes, adultos y pareja.',
          formacion: 'Licenciada en Psicología. Cédula Profesional: 6092318\nMaestría en Psicoterapia Humanista. Cédula Profesional: 9475952\nMaestría en Sexualidad Humana. Cédula Profesional: 12274318\nDoctorado en Psicología, por el Instituto Universitario Carl Rogers, Puebla.',
          modalidad: 'Presencial / Virtual'
        }
      };
    },
  };
  </script>
  
  <style scoped>
  /* Estilos para la barra de color y el círculo */
  .perfil-header {
    margin-top: 60px;
    margin-bottom: 60px;
    background-color: #2e271f;
    height: 200px; /* Altura de la barra */
    position: relative;
  }
  
  .barra-color {
    position: absolute;
    top: 0;
    right: 0;
    width: 20px; /* Ancho de la barra de color */
    height: 100%;
  }
  
  .circulo {
    width: 300px; /* Diámetro del círculo */
    height: 300px; /* Diámetro del círculo */
    background-color: #2e271f; /* Color del círculo */
    border-radius: 50%; /* Hace que el círculo tenga forma circular */
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    right: 100px; /* Ajusta la posición del círculo hacia la izquierda */
    background-size: contain; /* Ajusta el tamaño de la imagen para contenerla dentro del círculo */
    background-position: center; /* Centra la imagen dentro del círculo */
  }
  
  /* Estilos para el título del psicoterapeuta */
  .titulo-psicoterapeuta {
    position: absolute;
    top: 50%;
    left: 20px; /* Ajusta la posición del título hacia la izquierda */
    transform: translateY(-50%);
    color: white;
    font-weight: bold;
  }
  
  /* Estilos para la información del psicoterapeuta */
  .informacion-psicoterapeuta {
    margin-top: 40px; /* Aumenta el margen superior */
    margin-bottom: 100px; /* Aumenta el margen inferior */
    padding: 20px; /* Aumenta el espacio interno */
    color: black; /* Color del texto */
    font-size: 18px; /* Aumenta el tamaño de la fuente */
  }
  
  /* Estilos para la especialidad */
  .especialidad {
    background-color: #ff5901; /* Color de fondo de la especialidad */
    color: rgb(255, 255, 255); /* Color del texto */
    padding: 20px;
    margin-bottom: 20px; /* Aumenta el margen inferior */
    font-size: 24px; /* Aumenta el tamaño de la fuente */
    display: inline-block; /* Ajusta el ancho del fondo al ancho del texto */
  }
  
  /* Estilos para el contacto */
  .contacto {
    margin-bottom: 20px; /* Aumenta el margen inferior */
  }
  
  /* Estilos para los enlaces */
  .contacto a {
    color: black; /* Color del texto */
    text-decoration: none;
  }
  
  .contacto a:hover{
    color: #ff5901;
  }
  
  /* Estilos para el trabajo */
  .trabajo h3 {
    color: black; /* Color del texto */
    font-weight: bold;
    margin-top: 30px; /* Aumenta el margen superior */
  }
  
  /* Estilos para el trabajo */
  .trabajo p {
    margin-bottom: 20px; /* Aumenta el margen inferior */
  }
  
  /* Estilos para el botón de regresar */
  .boton-regresar {
    display: inline-block;
    background-color: #ff5901;
    color: white;
    padding: 10px 20px;
    text-decoration: none;
    border-radius: 5px;
    margin-top: 20px;
    margin-bottom: 20px; /* Aumenta el margen inferior */
  }
  
  .boton-regresar:hover {
    background-color: #e04400;
  }
  </style>
  