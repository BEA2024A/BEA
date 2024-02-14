<template>
  <div>
    <!-- Barra de Navegación -->
    <nav class="barra-navegacion">
      <!-- Logo -->
      <div class="logo">
        <router-link to="/" class="enlace-navegacion">  <img src="https://i.ibb.co/TkHLsmX/anahuac-oaxaca.png" alt="Logo Anáhuac"></router-link>
      </div>

      <!-- Secciones -->
      <div class="secciones-navegacion">
        <router-link to="/PrimeraCita" class="enlace-navegacion">Primera Cita</router-link>
        <router-link to="/seguimiento" class="enlace-navegacion">Seguimiento</router-link>
        <router-link to="/horario" class="enlace-navegacion">Horario</router-link>
        <router-link to="/autoayuda" class="enlace-navegacion">Autoayuda</router-link>
      </div>

      <!-- Botón de Inicio de Sesión -->
      <div class="boton-inicio-sesion">
        <button @click="abrirEnlace('/inicio-sesion')">Iniciar sesión</button>
      </div>
    </nav>

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

      <!-- Pie de Página -->
      <footer class="pie-pagina">
        <div class="contenido-pie">
          <!-- Imagen a la derecha -->
          <div class="derecha-pie">
            <img src="https://www.anahuac.mx/oaxaca/sites/default/files/img/Inicial.png" alt="Logo Anáhuac">
          </div>

          <!-- Información de contacto -->
          <div class="contacto-pie">
            <button class="boton-pie" @click="abrirMapa" target="_blank">
              <strong>Dirección:</strong> Blvd. Guadalupe Hinojosa de Murat No. 1100.<br>San Raymundo Jalpan, Oaxaca C.P. 71248.
            </button>
            <p><strong>Teléfono:</strong> (951) 50-1-62-50<br>Lada sin costo: 800-737-26-24<br>E-mail: orientacionpsicologica.uao@anahuac.mx</p>
          </div>

          <!-- Enlaces a Aviso de Privacidad y Compendio Reglamentario como botones -->
          <div class="botones-pie">
            <button v-for="(enlace, texto) in enlacesPie" :key="texto" class="boton-pie" @click="abrirEnlace(enlace)">{{ texto }}</button>
          </div>

          <!-- Botones de redes sociales como botones -->
          <div class="botones-sociales-pie">
            <button v-for="(botonSocial, index) in botonesSociales" :key="index" class="boton-pie" @click="abrirEnlace(botonSocial.enlace)" target="_blank">
              <img :src="botonSocial.icono" alt="Icono de red social">
            </button>
          </div>
        </div>
      </footer>
    </div>
  </div>
</template>

<script>
export default {
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
        { link: '/login', imagen: 'https://img.freepik.com/fotos-premium/chico-estudiante-usando-computadora_102671-6672.jpg', descripcion: 'Inicia Sesión' },
        { link: '/agenda-cita', imagen: 'https://static.ohga.it/wp-content/uploads/sites/24/2020/04/psicologo-ospedale.jpg', descripcion: 'Agenda tu Primera Cita' },
        { link: '/administra-seguimiento', imagen: 'https://www.shutterstock.com/image-photo/two-diverse-business-executive-partners-600nw-2021639234.jpg', descripcion: 'Administra tus Sesiones de Seguimiento' },
        { link: '/autoayuda', imagen: 'https://img.freepik.com/fotos-premium/mujer-joven-meditando-computadora-portatil-casa_768733-4666.jpg', descripcion: 'Sesiones de Autoayuda en Casa' },
      ],
      fondoEquipo: 'https://www.anahuac.mx/oaxaca/themes/custom/anahuac/img/school.png',
      
      botonesSociales: [
        { icono: 'https://www.anahuac.mx/oaxaca/sites/default/files/img/redFacebook_1.png', enlace: 'https://www.facebook.com/anahuacoaxaca/' },
        { icono: 'https://www.anahuac.mx/oaxaca/sites/default/files/img/redInstagram.png', enlace: 'https://www.instagram.com/anahuacoaxaca' },
        { icono: 'https://www.anahuac.mx/oaxaca/sites/default/files/img/redTwitter.png', enlace: 'https://twitter.com/anahuacoaxaca' },
        { icono: 'https://www.anahuac.mx/oaxaca/sites/default/files/img/redYoutube.png', enlace: 'https://www.youtube.com/channel/UCk5xAk91c-F_lNKn6ceDVZQ' },
      ],
      enlacesPie: {
        'Aviso de Privacidad': 'https://www.anahuac.mx/oaxaca/aviso-privacidad',
        'Compendio Reglamentario': 'https://www.anahuac.mx/oaxaca/compendio-reglamentario',
      },
    };
  },
  mounted() {
    this.iniciarTemporizadorBanner();
  },
  beforeDestroy() {
    this.detenerTemporizadorBanner();
  },
  methods: {
    abrirMapa() {
      window.location.href = 'https://maps.app.goo.gl/te3G28WuD56cTgyHA';
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

/* Barra de Navegación */
.barra-navegacion {
  display: flex;
  justify-content: space-around;
  align-items: center;
  padding: 15px;
  background-color: black;
  color: white;
}

.logo img {
  max-height: 40px;
}

.secciones-navegacion {
  display: flex;
}

.enlace-navegacion {
  margin-right: 30px;
  color: white;
  text-decoration: none;
  transition: color 0.3s ease;
}

.enlace-navegacion:hover {
  color: #d45c37;
}

.boton-inicio-sesion button {
  background-color: #d45c37;
  color: white;
  border: none;
  padding: 10px 15px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  cursor: pointer;
  border-radius: 5px;
  transition: background-color 0.3s ease;
}

.boton-inicio-sesion button:hover {
  background-color: #a03722;
}

/* Contenido de la Página */
.contenido-pagina {
  padding: 10px;
}

/* Banner de Bienvenida */
.banner-bienvenida {
  text-align: center; /* Alinea el contenido al centro */
  margin-top: 20px;
}

.banner-bienvenida img {
  max-width: 100%;
  height: auto;
  border-radius: 10px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  
}



/* Método de Trabajo */
.seccion-metodo {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-around;
  margin-top: 20px;
}

.item-metodo {
  position: relative;
  text-align: center;
  margin-bottom: 20px;
  overflow: hidden;
  transition: transform 0.3s ease, filter 0.3s ease;
}

.item-metodo:hover {
  transform: scale(1.1);
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
  margin-top: 20px;
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
  background-size: cover;
  background-position: center;
  padding: 20px;
  border-radius: 10px;
}

.perfil-psicologo {
  flex: 0 0 calc(48% - 20px);
  margin-bottom: 20px;
  background-color: rgba(66, 58, 56, 0.9);
  transition: background-color 0.3s ease;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  padding: 20px;
  border-radius: 10px;
  color:white;
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



/* Pie de Página */
.pie-pagina {
  background-color: black;
  color: white;
  padding: 30px;
}

.contenido-pie {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-around;
  align-items: center;
}

.derecha-pie img {
  max-height: 80px;
}

.contacto-pie p {
  margin: 10px;
}

.botones-pie {
  display: flex;
  flex-direction: column;
}

.boton-pie {
  background-color: #000000;
  color: white;
  border: none;
  text-align: center;
  cursor: pointer;
  border-radius: 5px;
  margin-bottom: 10px;
}

.botones-sociales-pie img {
  max-height: 35px;
  margin-right: 5px;
}

.botones-sociales-pie button {
  background: none;
  border: none;
  padding: 0;
  cursor: pointer;
}

</style>