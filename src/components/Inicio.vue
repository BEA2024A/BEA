<template>
  <plantilla>
    <!-- Contenido de la Página -->
    <div class="contenido-pagina">
      <router-view></router-view>
      <!-- Banner de Bienvenida -->
      <section class="banner-bienvenida">
        <img :src="bannerActual" width="1800" alt="Banner de Bienvenida">
      </section>
      <section class="seccion-metodo">
        <div v-for="(item, index) in itemsMetodo" :key="index" class="item-metodo" @click="abrirEnlace(item.link)">
          <img :src="item.imagen" alt="Método de Trabajo">
          <div class="descripcion-metodo">{{ item.descripcion }}</div>
        </div>
      </section>
      <section class="seccion-psicologos">
        <h1>Psicólogos Asociados</h1>
        <div class="profile-cards">
          <div v-for="(psicologo, index) in psicologos" :key="index" class="card" @mouseenter="psicologo.mostrarDescripcion = true" @mouseleave="psicologo.mostrarDescripcion = false">
            <img :src="psicologo.imagen" alt="Foto de perfil">
            <div class="descripcion-psicologo" :class="{ 'mostrar-descripcion': psicologo.mostrarDescripcion }">
              <h3>{{ psicologo.nombre }}</h3>
              <p class="title">{{ psicologo.puesto }}</p>
              <p><button @click="redirigirPerfil(psicologo.perfil)">Ir al perfil</button></p>
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
      indiceBannerActual: 0,
      banners: [
        "https://i.postimg.cc/VLBkG7K4/banner-1.png",
        "https://i.postimg.cc/t4qCLhfb/banner-2.png",
        "https://i.postimg.cc/XY13mtdK/banner3.png",
      ],
      itemsMetodo: [
        { link: '/PrimeraCita', imagen: 'https://static.ohga.it/wp-content/uploads/sites/24/2020/04/psicologo-ospedale.jpg', descripcion: 'Agenda tu Primera Cita' },
        { link: '/Seguimiento', imagen: 'https://www.shutterstock.com/image-photo/two-diverse-business-executive-partners-600nw-2021639234.jpg', descripcion: 'Administra tus Sesiones de Seguimiento' },
        { link: '/autoayuda', imagen: 'https://img.freepik.com/fotos-premium/mujer-joven-meditando-computadora-portatil-casa_768733-4666.jpg', descripcion: 'Sesiones de Autoayuda en Casa' },
      ],
      psicologos: [
        { nombre: 'DRA. ELVIRA GOPAR CANSECO', puesto: 'TERAPIA HUMANISTA', perfil: '/ps1', imagen: 'https://i.postimg.cc/NFNY2Krd/DRA-ELVIRA-GOPAR-CANSECO.png'},
        { nombre: 'MTRA. KENIA GARCÍA GUTIÉRREZ', puesto: 'TERAPIA GESTALT',perfil: '/ps1', imagen: 'https://i.postimg.cc/BZNJVVw2/MTRA-KENIA-GARC-A-GUTI-RREZ.png'},
        { nombre: 'MTRA. SYLVIA GUTIÉRREZ CANDIANI', puesto: 'TERAPIA COGNITIVO CONDUCTUAL',perfil: '/ps1', imagen: 'https://i.postimg.cc/SRQkK6jX/MTRA-SYLVIA-GUTI-RREZ-CANDIANI.png'},
        { nombre: 'LIC. MARÍA GODARD ZAPATA', puesto: 'TERAPIA HUMANISTA', perfil: '/ps1', imagen: 'https://i.postimg.cc/Hx9THZWD/LIC-MAR-A-GODARD-ZAPATA.png'},
        { nombre: 'MTRA. LAURA LORENA HERNÁNDEZ VELASCO', puesto: 'TERAPIA HUMANISTA',perfil: '/ps1', imagen: 'https://i.postimg.cc/653BJfDg/MTRA-LAURA-LORENA-HERN-NDEZ-VELASCO.png'},
        { nombre: 'DR. JORGE G. JIMÉNEZ SÁNCHEZ', puesto: 'PSIQUIATRIA DE ENLACE', perfil: '/ps1', imagen: 'https://i.postimg.cc/YCTrxLDV/DR-JORGE-G-JIM-NEZ-S-NCHEZ.png'},
        { nombre: 'DR. JORGE LUIS CORTÉS LÓPEZ', puesto: 'PSIQUIATRIA DE ENLACE', perfil: '/ps1', imagen: 'https://i.postimg.cc/Kz2m6S2D/DR-JORGE-LUIS-CORT-S-L-PEZ.png'},
        { nombre: 'DR. VIRGILIO SANTIAGO LÓPEZ', puesto: 'TERAPIA COGNITIVO CONDUCTUAL', perfil: '/ps1', imagen: 'https://i.postimg.cc/k58nYMk5/DR-VIRGILIO-SANTIAGO-L-PEZ.png'},
      ],
      temporizadorBanner: null,
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
    redirigirPerfil(perfil) {
    this.$router.push(perfil);
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
  .banner-bienvenida {
    text-align: center;
    margin-top: 20px;
    margin-bottom: 50px;
  }
  .banner-bienvenida img {
    max-width: 100%;
    height: auto;
    box-shadow: 0 4px 8px rgba(194, 160, 160, 0.1);
  }
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
    width: 500px;
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
  .seccion-psicologos {
    text-align: center;
    margin-top: 100px;
    margin-bottom: 50px;
  }
  .seccion-psicologos h1 {
    font-size:28px;
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.5); 
   background-color: rgba(240, 248, 255, 0.603);
   display: inline-block;
   padding: 10px 20px;
   border-radius: 5px;
   margin-left: 10px;
  }
  .profile-cards {
    display: flex;
    justify-content:center;
    flex-wrap: wrap;
    background-color: rgba(0, 0, 0, 0.089);
  }
  .card {
    max-width: 300px;
    margin: 25px;
    text-align: center;
    transition: transform 0.3s ease;
    position: relative;
  }
  .card:hover {
    transform: scale(1.02);
  }
  .card img {
    width: 100%;
    border-top-left-radius: 10px;
    border-top-right-radius: 10px;
  }
  .descripcion-psicologo {
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    background-color: rgba(255, 255, 255, 0.9);
    padding: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
    text-align: center;
    transition: opacity 0.3s ease;
    opacity: 0;
  }
  .mostrar-descripcion {
    opacity: 1;
  }
  .title {
    color: grey;
    font-size: 18px;
  }
  button {
    border: none;
    outline: 0;
    display: inline-block;
    padding: 8px;
    color: white;
    background-color: #000000;
    text-align: center;
    cursor: pointer;
    width: 100%;
    font-size: 18px;
  }
  button:hover,
  a:hover {
    opacity: 0.7;
  }
@media only screen and (max-width: 600px) {
  .item-metodo {
    width: 100%;
  }
  .item-metodo img {
    width: 350px;
    height: 200px;
  }
  .card {
    max-width: calc(50% - 30px); 
    margin: 15px;
  }
}
  @media only screen and (min-width: 601px) and (max-width: 1024px) {
    .item-metodo img {
      width: 250px;
      height: 200px;
    }

    .card {
    max-width: calc(50% - 30px); 
    margin: 15px;
  }
  }
</style>