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
      <div class="fondo-psicologos">
      <section class="seccion-psicologos">
        <h1>Psicólogos Asociados</h1>
        <div class="profile-cards">
          <div v-for="(psicologo, index) in psicologos" :key="index" class="card" @mouseenter="psicologo.mostrarDescripcion = true" @mouseleave="psicologo.mostrarDescripcion = false">
            <img :src="psicologo.imagen" alt="Foto de perfil">
            <div class="descripcion-psicologo" :class="{ 'mostrar-descripcion': psicologo.mostrarDescripcion }">
              <h3>{{ psicologo.nombre }}</h3>
              <p class="title">{{ psicologo.puesto }}</p>
              <button @click="redirigirPerfil(psicologo.perfil)">Perfil</button>
            </div>
          </div>
        </div>
      </section>
    </div>
    </div>
  </plantilla>
</template>

<script>
import axios from 'axios';
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
      psicologos: [],
      temporizadorBanner: null,
    };
  },

  mounted() {
    this.iniciarTemporizadorBanner();
    this.cargarPsicologos();
  },

  beforeDestroy() {
    this.detenerTemporizadorBanner();
  },

  methods: {
    cargarPsicologos() {
      axios.get('http://localhost/bea/back/obtenerPsicologos.php')
        .then(response => {
          this.psicologos = response.data.map(psicologo => ({
            ...psicologo,
            perfil: `/ps1/${psicologo.id}` // Asigna un perfil dinámico basado en el ID
          }));
        })
        .catch(error => {
          console.error('Error al cargar los psicólogos:', error);
        });
    },
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

@keyframes slideIn {
  from {
    opacity: 0;
    transform: translateY(-50px); 
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
/*BANNER BIENVENIDA */
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

  /*METODO DE TRABAJO */
  .seccion-metodo {
  display: flex;
  flex-wrap: nowrap;
  justify-content: space-around;
  
}

  .item-metodo {
    position: relative;
    text-align: center;
    margin-top: 20px;
    margin-bottom: 20px;
    overflow: hidden;
    transition: transform 0.3s ease, filter 0.3s ease;  
    cursor: pointer;
   
    padding-right: 10px;
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

/*PSICOLOGOS */
  .fondo-psicologos{
    background-color:#ff5900;
    padding: 30px;
    margin-top: 50px
  }

  .seccion-psicologos {
    margin: 30px;
    background-color:#ffffff ;
    border-radius: 10px;
    padding: 30px;
   
  }

  .seccion-psicologos h1 {
    font-size: 28px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
    background-color: rgba(240, 248, 255, 0.788);
    padding: 20px;
    border-radius: 10px;
    margin-left: 10px;
    transition: font-size 0.3s;
  }
  .seccion-psicologos h1:hover {
    font-size: 32px; 
  }

  .profile-cards {
  background-color: rgb(255, 255, 255);
  display: flex;
  justify-content: space-around; 
  flex-wrap: wrap;
}

  .card {
    text-align: center;
    transition: transform 0.3s ease;
    position: relative;
  }
  .card:hover {
    transform: scale(1.02);
  }
  .card img {
  border-radius: 10px;
    box-shadow: 0 5px 5px rgba(0, 0, 0, 0.541);
    width: 100%;
    height: 250px; 
    object-fit: cover; 
    animation: slideIn 1s ease forwards;
  }
  .descripcion-psicologo {
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    background-color: rgba(19, 17, 17, 0.9);
    padding: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
    text-align: center;
    transition: opacity 0.3s ease;
    opacity: 0;
    color :rgb(255, 255, 255);
  }
  .mostrar-descripcion {
    opacity: 1;
  }
  
  button {
    background-color: #fcfcfc;
    font-size: 18px;
    color:black;
  }


/* RESPONSIVIDAD*/

@media (max-width: 639px) {

/*BANNER BIENVENIDA */
.banner-bienvenida {
    margin-top: 0px;
    margin-bottom: 30px;
  }

/*METODO DE TRABAJO */

  .seccion-metodo {
  display:block;
  padding-left: 10px;
  padding-right: 15px;
}

  .item-metodo {
    padding-left: 5px;
    padding-right: 5px;
    border-radius: 10px;
  }

  .item-metodo img {
    object-fit: cover;
    width: 400px;
  }

/*PSICOLOGOS */
.fondo-psicologos{
    padding: 0px;
    padding-top: 20px;
    padding-bottom: 20px;
  }

  .seccion-psicologos {
    margin: 10px;
    padding: 20px;
   
  }

  .seccion-psicologos h1 {
    font-size: 25px;
  }
  .seccion-psicologos h1:hover {
    font-size: 25px; 
  }


  
  .card img {
  border-radius: 10px;
    box-shadow: 0 5px 5px rgba(0, 0, 0, 0.541);
    width: 100%;
    height: 300px; 
    object-fit: cover; 
    animation: slideIn 1s ease forwards;
  }
  .descripcion-psicologo {
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    background-color: rgba(19, 17, 17, 0.9);
    padding: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
    text-align: center;
    transition: opacity 0.3s ease;
    opacity: 0;
    color :rgb(255, 255, 255);
  }
  .mostrar-descripcion {
    opacity: 1;
  }
  
  button {
    background-color: #fcfcfc;
    font-size: 18px;
    color:black;
  }



}


</style>
