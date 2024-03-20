<template>
  <plantilla>
    <div class="contenido-pagina">
      <!-- Cabecera -->
      <div class="cabecera">
        <!-- Lado izquierdo: Nombre y especialidad -->
        <div class="info-izquierda">
          <h1>{{ informacion.nombre }}</h1>
          <h3>{{ informacion.especialidad }}</h3>
          <div class="contacto">
            <img src="https://cdn.icon-icons.com/icons2/1993/PNG/512/direction_gps_location_map_maps_navigation_pin_icon_123198.png" alt="Icono de Ubicación">
            <a href="https://maps.app.goo.gl/2FA8ovzMAt5UbWrM9" target="_blank"><p>{{ informacion.direccion }}</p></a>
            <img src="https://cdn.icon-icons.com/icons2/2248/PNG/512/whatsapp_icon_138013.png" alt="Icono de WhatsApp">
            <a href="https://wa.me" target="_blank"><p>{{ informacion.telefono }}</p></a>
          </div>
          <p>{{ informacion.modalidad }}</p>
        </div>
        <!-- Lado derecho: Imagen en círculo con sombra naranja -->
        <div class="imagen-derecha">
          <div class="circulo-con-sombra">
            <img :src="imagenPsicologo[0]" alt="Imagen del psicoterapeuta">
          </div>
        </div>
      </div>
      <!-- Información del psicoterapeuta -->
      <div class="informacion-psicoterapeuta">
        <div class="trabajo">
          <div class="columna-izquierda">
            <h3>ESPECIALIDAD</h3>
            <p>{{ informacion.especialidad }}</p>
            <h3>POBLACIÓN A ATENDER</h3>
            <p>{{ informacion.poblacion }}</p>
          </div>
          <div class="columna-derecha">
            <h3>FORMACIÓN ACADÉMICA</h3>
            <div v-html="formatFormacion(informacion.formacion)" ></div>
          </div>
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
        whatsapp: '549511096372',
        direccion: 'Independencia 305, interior 105. Casi esquina con Crespo, Centro.',
        poblacion: 'Niños, adolescentes, adultos y pareja.',
        formacion: 'Licenciada en Psicología. Cédula Profesional: 6092318\nMaestría en Psicoterapia Humanista. Cédula Profesional: 9475952\nMaestría en Sexualidad Humana. Cédula Profesional: 12274318\nDoctorado en Psicología, por el Instituto Universitario Carl Rogers, Puebla.',
        modalidad: 'Presencial / Virtual'
      }
    };
  },
  methods: {
    formatFormacion(formacion) {
      return formacion.split('\n').map(parrafo => `<p>${parrafo}</p>`).join('');
    }
  } 
};
</script>



<style scoped>
/* Estilos para la cabecera */
.cabecera {
  position: relative;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 200px;
}

.cabecera::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-image: url('https://media.licdn.com/dms/image/C4D12AQEKxoyM6Eh4TQ/article-cover_image-shrink_720_1280/0/1638387238044?e=2147483647&v=beta&t=RR7sSnAFIBtbK39vAQZx7ilT02ZCeZJsfOd9VLh1eYw');
  background-size: cover;
  background-position: center;
  filter: brightness(0.5); /* Se aplica el filtro de oscuridad solo a la imagen de fondo */
}

/* Estilos para el contenido dentro de la cabecera */
.info-izquierda,
.imagen-derecha {
  z-index: 1; /* Asegura que el contenido esté sobre la imagen de fondo */
}

.info-izquierda h1 {
  text-shadow: 0 0 20px rgba(0, 0, 0, 0.705); /* Sombra naranja */
  color: aliceblue;
}

.info-izquierda h3 {
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.5); /* Sombra naranja */
  background-color: rgba(240, 248, 255, 0.603);
  display: inline-block;
  padding: 10px 20px;
  border-radius: 5px;
  margin-left: 10px;
}
.info-izquierda p{
  color:aliceblue;
}


.imagen-derecha {
  margin-left: 200px;
}

.circulo-con-sombra {
  width: 350px; /* Tamaño del círculo */
  height: 350px; /* Tamaño del círculo */
  border-radius: 50%; /* Hace que el círculo tenga forma circular */
  overflow: hidden; /* Oculta el exceso de la sombra */
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.5); /* Sombra naranja */
}

.circulo-con-sombra img {
  width: 100%;
  height: 100%;
  object-fit: cover; /* Ajusta la imagen para cubrir el círculo */
}

/* Estilos para la información del psicoterapeuta */
.informacion-psicoterapeuta {
  margin-top: 40px; /* Aumenta el margen superior */
  margin-bottom: 100px; /* Aumenta el margen inferior */
  padding: 20px; /* Aumenta el espacio interno */
  color: #333; /* Cambio de color del texto a un tono más oscuro */
  font-size: 18px; /* Aumenta el tamaño de la fuente */
}

/* Estilos para el contacto */
.contacto {
  margin-bottom: 20px; /* Aumenta el margen inferior */
  display: flex;
  align-items: center;
}


.contacto img {
  width: 30px; /* Tamaño del icono */
  height: 30px; /* Tamaño del icono */
  margin-right: 5px; /* Espacio entre el icono y el texto */
  filter: invert(1);
}


.contacto a {
  color:aliceblue;
  text-decoration: none;
  margin-block: 10px;
  margin-inline-end: 10px;
}



/* Estilos para el trabajo */
.trabajo h3 {
  color: rgb(255, 118, 5); /* Color del texto */
  margin-top: 30px; /* Aumenta el margen superior */
  margin-bottom: 30px;
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.5); /* Sombra naranja */
  background-color: rgba(240, 248, 255, 0.603);
  display: inline-block;
  padding: 10px 20px;
  border-radius: 5px;
  margin-left: 10px;
}

.trabajo {
  display: flex;
}

/* Estilos para la columna izquierda */
.columna-izquierda {
  flex: 1; /* Ocupa el 50% del ancho disponible */
  padding-right: 20px; /* Espacio entre las dos columnas */
}

/* Estilos para la columna derecha */
.columna-derecha {
  flex: 1; /* Ocupa el 50% del ancho disponible */
}

.columna-derecha p {
  text-align: left; /* Justificar el texto */
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
