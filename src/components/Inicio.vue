<template>
  <plantilla>
    <!-- Contenido de la Página -->
    <div class="contenido-pagina">
      <router-view></router-view>
      <!-- Banner de Bienvenida -->
      <section class="banner-bienvenida">
        <img :src="bannerActual" width="1800" alt="Banner de Bienvenida">
      </section>
      <!-- Sección de Método de Trabajo -->
      <section class="seccion-metodo">
        <div v-for="(item, index) in itemsMetodo" :key="index" class="item-metodo" @click="abrirEnlace(item.link)">
          <img :src="item.imagen" alt="Método de Trabajo">
          <div class="descripcion-metodo">{{ item.descripcion }}</div>
        </div>
      </section>
      <!-- Sección de Equipo de Psicólogos -->
      <section class="seccion-equipo" :style="{ backgroundImage: 'url(' + fondoEquipo + ')' }">
        <div class="perfil-psicologo">
          <div class="detalles-perfil">
            <h3>NUESTRO EQUIPO</h3>
          </div>
        </div>
        <!-- Perfiles -->
        <div v-for="psicologo in psicologos" :key="psicologo.id" class="perfil-psicologo">
          <img :src="psicologo.imagen" :alt="'Perfil ' + psicologo.nombre">
          <div class="detalles-perfil">
            <h3>{{ psicologo.nombre }}</h3>
            <p>{{ psicologo.experiencia }}</p>
            <p>{{ psicologo.especializacion }}</p>
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
      psicologos: [
        { id: 1, nombre: 'Nombre del Psicólogo 1', imagen: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png', experiencia: 'Experiencia Académica y Profesional', especializacion: 'Áreas de Especialización: Ansiedad, Depresión, Relaciones' },
        { id: 2, nombre: 'Nombre del Psicólogo 2', imagen: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png', experiencia: 'Experiencia Académica y Profesional', especializacion: 'Áreas de Especialización: Ansiedad, Depresión, Relaciones' },
        { id: 3, nombre: 'Nombre del Psicólogo 3', imagen: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png', experiencia: 'Experiencia Académica y Profesional', especializacion: 'Áreas de Especialización: Ansiedad, Depresión, Relaciones' },
        { id: 4, nombre: 'Nombre del Psicólogo 4', imagen: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png', experiencia: 'Experiencia Académica y Profesional', especializacion: 'Áreas de Especialización: Ansiedad, Depresión, Relaciones' },
        { id: 5, nombre: 'Nombre del Psicólogo 5', imagen: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png', experiencia: 'Experiencia Académica y Profesional', especializacion: 'Áreas de Especialización: Ansiedad, Depresión, Relaciones' },
      ],
      indiceBannerActual: 0,
      banners: [
        "https://i.ibb.co/G0DQd1D/Whats-App-Image-2024-02-11-at-6-53-05-PM.jpg",
        "https://i.ibb.co/2yLFNQf/Whats-App-Image-2024-02-11-at-7-50-21-PM.jpg",
        "https://i.ibb.co/Qv8WMW5/Whats-App-Image-2024-02-11-at-7-50-21-PM-1.jpg",
      ],
      itemsMetodo: [
        { link: '/InicioSesion', imagen: 'https://img.freepik.com/fotos-premium/chico-estudiante-usando-computadora_102671-6672.jpg', descripcion: 'Inicia Sesión' },
        { link: '/PrimeraCita', imagen: 'https://static.ohga.it/wp-content/uploads/sites/24/2020/04/psicologo-ospedale.jpg', descripcion: 'Agenda tu Primera Cita' },
        { link: '/Seguimiento', imagen: 'https://www.shutterstock.com/image-photo/two-diverse-business-executive-partners-600nw-2021639234.jpg', descripcion: 'Administra tus Sesiones de Seguimiento' },
        { link: '/autoayuda', imagen: 'https://img.freepik.com/fotos-premium/mujer-joven-meditando-computadora-portatil-casa_768733-4666.jpg', descripcion: 'Sesiones de Autoayuda en Casa' },
      ],
      fondoEquipo: 'https://www.anahuac.mx/oaxaca/themes/custom/anahuac/img/school.png',
      
    };
  },
  mounted() {
    this.iniciarTemporizadorBanner();
  },
  beforeDestroy() {
    this.detenerTemporizadorBanner();
  },
  methods: {
    abrirEnlace(url) {
      window.location.href = url;
    },
    iniciarTemporizadorBanner() {
      this.temporizadorBanner = setInterval(this.cambiarBanner, 6000);
    },
    detenerTemporizadorBanner() {
      clearInterval(this.temporizadorBanner);
    },
    cambiarBanner() {
      this.indiceBannerActual = (this.indiceBannerActual + 1) % this.banners.length;
    },
    redirigirA(ruta) {
      this.$router.push(ruta);
    },
  },
  computed: {
    bannerActual() {
      return this.banners[this.indiceBannerActual];
    },
  }
};
</script>

<style scoped>

/* Banner de Bienvenida */
.banner-bienvenida {
  text-align: center;
  margin-top: 20px;
  margin-bottom: 50px; /* Añadido: espacio inferior */
}
.banner-bienvenida img {
  max-width: 100%;
  height: auto;
  border-radius: 10px;
  box-shadow: 0 4px 8px rgba(194, 160, 160, 0.1);
  
}
/* Método de Trabajo */
.seccion-metodo {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-around;
}
.item-metodo {
  position: relative;
  text-align: center;
  margin-top: 20px;
  margin-bottom: 20px;
  overflow: hidden;
  transition: transform 0.3s ease, filter 0.3s ease;
}
.item-metodo:hover {
  transform: scale(1.02);
}
.item-metodo img {
  width: 400px;
  height: 300px;
  object-fit: cover;
  border-radius: 10px;
  filter: brightness(50%);
  transition: filter 0.3s;
}
.item-metodo:hover img {
  filter: brightness(20%);
}
.descripcion-metodo {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  color: white;
  font-weight: bold;
  text-align: center;
  width: 80%;
  opacity: 0.8;
  transition: opacity 0.3s ease;
}
.item-metodo:hover .descripcion-metodo {
  opacity: 1;
}
/* Sección de Equipo de Psicólogos */
.seccion-equipo {
  margin-top: 60px;
  display: center;
  flex-wrap: wrap;
  justify-content: space-between;
  background-size: cover;
  background-position: center;
  padding: 20px;
  border-radius: 10px;
  margin-bottom: 50px;
}

.perfil-psicologo {
  flex: 0 0 90%; /* Modificado para que ocupe todo el ancho en pantallas pequeñas */
  margin-bottom: 20px;
  background-color: rgba(66, 58, 56, 0.9);
  transition: background-color 0.3s ease;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  padding: 20px;
  border-radius: 10px;
  color: white;
}

.perfil-psicologo:hover {
  background-color: #f6f6f6;
  color: black;
}

.perfil-psicologo h3 {
  font-weight: bold;
}

.perfil-psicologo img {
  width: 80px;
  height: 80px;
  border-radius: 50%;
  margin-bottom: 10px;
}



/* Pantallas medianas (tabletas) */
@media only screen and (min-width: 601px) and (max-width: 1024px) {
  .item-metodo img {
    width: 100%;
    height: auto;
  }
}

/* Pantallas grandes (escritorios) */
@media only screen and (min-width: 1025px) {
  /* Agrega tus estilos específicos para pantallas más grandes aquí */
}


</style>