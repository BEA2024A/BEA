<template>
  <plantilla>
    
    <!-- Contenido de la Página -->
    <div class="contenido-pagina">
      <router-view></router-view>
      <!-- Sección de Autoayuda -->
      <section class="banner-autoayuda">
        <div class="fondo-autoayuda">
          <img src="https://gaceta.cch.unam.mx/sites/default/files/styles/imagen_articulos_1920x1080/public/2022-07/pag_24a_1.jpg?h=e5aec6c8&itok=5c2W5L4Y" alt="Banner Autoayuda">
        </div>
        <div class="titulo-autoayuda">
          <h1>ANSIEDAD</h1>
        </div>
      </section>
      <!-- Sección "¿Qué es la ansiedad?" -->
      <section class="seccion-ansiedad">
        <div class="ansiedad-info">
          <div class="texto-ansiedad">
            <h2>¿Qué es la ansiedad?</h2>
            <p>
              La ansiedad es una respuesta natural del cuerpo frente a situaciones percibidas como amenazantes o estresantes.
              Se manifiesta como un estado emocional caracterizado por inquietud, nerviosismo, preocupación y tensión.
              Aunque es una parte normal de la vida, la ansiedad puede volverse problemática cuando es excesiva o persistente,
              afectando el bienestar y el funcionamiento diario de una persona.
            </p>
          </div>
          <div class="imagen-ansiedad">
            <img src="https://www.balancegroup.cl/wp-content/uploads/2022/04/psicologi%CC%81a-adultos-533x533.png" alt="Psicología Adultos">
          </div>
        </div>
      </section>
       <!-- Sección "Sesiones que podrían ayudarte" -->
       <section class="sesiones-ayuda">
        <div class="sesiones-titulo">
          <h2>Sesiones que podrían ayudarte</h2>
        </div>
        <div class="swiper-container">
          <div class="swiper-wrapper">
            <!-- Iterar sobre los videos -->
            <div class="swiper-slide" v-for="(video, index) in videos" :key="index">
              <iframe width="100%" height="315" :src="video.src" frameborder="0" allowfullscreen></iframe>
            </div>
          </div>
        </div>
      </section>
    </div>
  </plantilla>
</template>
<script>
import Plantilla from './plantilla.vue';

export default {
  components: {
    Plantilla,
  },
  data() {
    return {
      // Array de videos
      videos: [
        { src: "https://www.youtube.com/embed/LE2tlZLmzG4?si=XESO68vyLhp42Ccn" },
        { src: "https://www.youtube.com/embed/lAXdkk6O2Nc?si=wg9oUUGpRsutaPSR" },
        { src: "https://www.youtube.com/embed/nAR2PUPyH1I?si=B3_yOEwBT7iaV50K" }
      ],
    };
  },
 
  methods: {
    abrirEnlace(url) {
      window.location.href = url;
    },
    mostrarSintomas(item) {
      this.itemsMetodo.forEach((otherItem) => {
        if (otherItem !== item) {
          otherItem.mostrarSintomas = false;
        }
      });
      item.mostrarSintomas = true;
    },
    ocultarSintomas() {
      this.itemsMetodo.forEach((item) => {
        item.mostrarSintomas = false;
      });
    },
  },
};
</script>

<style scoped>

/* Estilos para la sección de Autoayuda */
.banner-autoayuda {
position: relative;
text-align: center;
margin-top: 20px;
}
.fondo-autoayuda {
overflow: hidden;
max-width: 1900px; 
margin: 0 auto;
border-radius: 10px;
}
.fondo-autoayuda img {
max-width: 100%;
height: auto;
filter: brightness(50%); 
border-radius: 10px;
box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}
.fondo-autoayuda:hover img {
filter: brightness(30%); 
}
.titulo-autoayuda {
position: absolute;
top: 50%;
left: 50%;
transform: translate(-50%, -50%);
color: white;
text-align: center;
}
.titulo-autoayuda h1 {
font-size: 50px;
margin: 0;
opacity: 0;
animation: fadeIn 1s ease forwards;
}
@keyframes fadeIn {
from {
  opacity: 0;
}
to {
  opacity: 1;
}
}
/* Estilos para la sección de Ansiedad */
.seccion-ansiedad {
  background-color: #e6e3e3;
  overflow: hidden;
  text-align: center;
  padding: 20px;
  margin-top: 20px;
  animation: fadeIn 7s ease forwards;
}
.ansiedad-info {
  display: flex;
  justify-content: space-around;
  align-items: center;
}
.texto-ansiedad {
  max-width: 50%;
  text-align: left;
}
.texto-ansiedad h2 {
  font-size: 24px;
  margin-bottom: 10px;
}
.imagen-ansiedad img {
  max-width: 100%;
  height: auto;
  border-radius: 10px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

/* Estilos para la sección "Sesiones que podrían ayudarte" */
.sesiones-ayuda {
  margin-top: 20px;
  text-align: center;
}
.swiper-slide {
  margin: 0 auto;
  width: 80%;
}

</style>