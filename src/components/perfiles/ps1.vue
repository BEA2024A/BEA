<template>
  <plantilla>
    <div class="contenido-pagina">
      <!-- Cabecera con animación de aparición -->
      <div class="cabecerapsico" v-if="loaded" :style="{ backgroundImage: 'url(' + informacion.imagen_fondo + ')' }">
        
        <!-- Lado izquierdo: Nombre y especialidad -->
        <div class="info-izquierda" ref="infoIzquierda">
          <h1>{{ informacion.nombre }}</h1>
          <h3>{{ informacion.tipo }}</h3>
          <div class="contacto">
            <img src="https://cdn.icon-icons.com/icons2/1993/PNG/512/direction_gps_location_map_maps_navigation_pin_icon_123198.png" alt="Icono de Ubicación">
            <a href="https://maps.app.goo.gl/2FA8ovzMAt5UbWrM9" target="_blank"><p>{{ informacion.direccion }}</p></a>
            <img src="https://cdn.icon-icons.com/icons2/2248/PNG/512/whatsapp_icon_138013.png" alt="Icono de WhatsApp">
            <a :href="'https://wa.me/' + informacion.telefono" target="_blank"><p>ir a whatsApp</p>
</a>


          </div>
          <p>{{ informacion.modalidad }}</p>
        </div>
        <!-- Lado derecho: Imagen en círculo con sombra naranja -->
        <div class="imagen-derecha" ref="imagenDerecha">
          <div class="circulo-con-sombra">
            <img :src="informacion.imagen" alt="Imagen del psicoterapeuta">
          </div>
        </div>

        <!-- Botón de scroll-down con el icono proporcionado -->
        <button class="boton-scroll" @click="scrollDown">
          <img class="icono-scroll" src="https://cdn-icons-png.freepik.com/512/9923/9923629.png" alt="Icono de scroll-down">
        </button>
      </div>

      <!-- Información del psicoterapeuta con animación de aparición -->
      <div class="informacion-psicoterapeuta"  v-if="loaded" ref="informacionPsicoterapeuta">
        <div class="trabajo">
          <div class="columna-izquierda">
            <h3>ESPECIALIDAD</h3>
            <p>{{ informacion.especialidad }} </p>
            <h3>POBLACIÓN A ATENDER</h3>
            <p>{{ informacion.poblacion }}</p>
          </div>
          <div class="columna-derecha">
            <h3>FORMACIÓN ACADÉMICA</h3>
            <div v-html="formatFormacion(informacion.formacion)"></div>
          </div>
        </div>
      </div>
      <!-- Botón Regresar al inicio -->
      <router-link to="/" class="boton-regresar"  v-if="loaded" >Regresar al inicio</router-link>
    </div>
  </plantilla>
</template>

<script>
import Plantilla from '../plantilla.vue';
import axios from 'axios';

export default {
  components: {
    Plantilla,
  },
  data() {
    return {
      informacion: {
        "nombre": "",
        "tipo": "",
        "telefono": "",
        "especialidad": "",
        "direccion": "",
        "poblacion": "",
        "formacion": "",
        "modalidad": "",
        "imagen": "",
        "imagen_fondo": "",
      }, 

      loaded:false,
    };
  },
  mounted() {
    this.cargarInformacionPsicologo();
    setTimeout(() => {
      this.loaded = true;
    }, 5);
  },
  methods: {
    cargarInformacionPsicologo() {
      const id = this.$route.params.id;
      axios.get(`http://localhost/bea/back/ps1.php?id=${id}`)
        .then(response => {
          this.informacion = response.data;
        })
        .catch(error => {
          console.error('Error al cargar los detalles del psicólogo:', error);
        });
    },
    formatFormacion(formacion) {
      return formacion.split('\n').map(parrafo => `<p>${parrafo}</p>`).join('');
    },
    scrollDown() {
      window.scrollBy({
        top: window.innerHeight,
        behavior: 'smooth'
      });
    }
  }
};
</script>




<style scoped>
@keyframes fadeIn {
  from {
    opacity: 0; /* Opacidad inicial */
  }
  to {
    opacity: 1; /* Opacidad final */
  }
}

@keyframes slideIn {
  from {
    opacity: 0;
    transform: translateY(-50px); /* Por ejemplo, deslizamiento desde arriba */
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

@keyframes bounce{
  0% {transform: translateY(0);}
  40%{transform: translateY(-20px);}
  60%{transform: translateY(-10px);}
  80%{transform: translateY(-20px);}
  100%{transform: translateY(0);}
}


.cabecerapsico {
  position: relative;
  display: flex;
  justify-content: space-between;
  align-items: center;
  height: 100vh; /* Ajusta la altura al 100% del viewport */ 
  background-size: cover;
  background-position: center;
}


/* Estilos para el contenido dentro de la cabecera */
.info-izquierda{
  z-index: 1; /* Asegura que el contenido esté sobre la imagen de fondo */
  margin: 0 auto; /* Centra horizontalmente los elementos */
  animation: slideIn 1s ease forwards; /* Animación de aparición */
}
.imagen-derecha {
  z-index: 1; /* Asegura que el contenido esté sobre la imagen de fondo */
  margin: 0 auto; /* Centra horizontalmente los elementos */
  animation: slideIn 1s ease forwards;
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

.boton-scroll {
  position: absolute;
  bottom: 120px; /* Distancia desde la parte inferior */
  left: 50%; /* Centrar horizontalmente */
  transform: translateX(-50%); /* Centrar horizontalmente */
  right: 50%; 
  transform: translateY(-50%); /* Centrar horizontalmente */
  background-color: rgba(240, 248, 255, 0.603); /* Color de fondo */
  border: none; /* Sin borde */
  border-radius: 50%; /* Botón circular */
  width: 60px; /* Ancho del botón */
  height: 60px; /* Altura del botón */
  font-size: 24px; /* Tamaño del ícono */
  color: #000; /* Color del ícono */
  cursor: pointer; /* Cursor de puntero al pasar sobre el botón */
  transition: background-color 0.3s; /* Transición suave al cambiar de color */
  transition: transform 0.3s;
  animation: fadeIn 5s ease forwards;
  animation: bounce 2s infinite;
}
.icono-scroll {
  margin-top: 3px;
  width: 40px; /* Tamaño del icono */
  height: 40px; /* Tamaño del icono */
  transition: transform 0.3s;
}

.icono-scroll:hover{
  transform: scale(1.2);
}

.boton-scroll:hover {
  background-color: rgba(200, 220, 255, 0.8); /* Color de fondo al pasar el cursor */
  transform: scale(1.2);
}

/* Estilos para el ícono dentro del botón */

/* Estilos para la información del psicoterapeuta */
.informacion-psicoterapeuta {
  margin-top: 80px; /* Aumenta el margen superior */
  margin-bottom: 100px; /* Aumenta el margen inferior */
  padding: 20px; /* Aumenta el espacio interno */
  color: #000000; /* Cambio de color del texto a un tono más oscuro */
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
  margin-inline-end: 90px;
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
  margin-bottom: 60px; /* Aumenta el margen inferior */
}

.boton-regresar:hover {
  background-color: #e04400;
}


@media (max-width: 639px) {

  .cabecera {
  flex-direction: column; /* Cambiar la dirección del flex a columna */
  align-items: center; /* Centrar verticalmente */
  text-align: center; /* Alinear el texto al centro */
  padding-top: 20px; /* Agregar espacio en la parte superior */
}

.info-izquierda {
  margin-top: 20px; /* Espacio entre el círculo y el nombre */
}

.imagen-derecha {
  margin-top: 20px; /* Espacio entre la información y el círculo */
}

}
</style>