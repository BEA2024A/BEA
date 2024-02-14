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
        <router-link to="/primeracita" class="enlace-navegacion">Primera Cita</router-link>
        <router-link to="/seguimiento" class="enlace-navegacion">Seguimiento</router-link>
        <router-link to="/horario" class="enlace-navegacion">Horario</router-link>
        <router-link to="/autoayuda" class="enlace-navegacion">Autoayuda</router-link>
      </div>
      <!-- Botón de Inicio de Sesión -->
      <div class="boton-inicio-sesion">
        <button @click="abrirEnlace('/InicioSesion')">Iniciar sesión</button>
      </div>
    </nav>
    <!-- Contenido de la Página -->
    <div class="contenido-pagina">
      <router-view></router-view>     
<!-- Sección de Autoayuda -->
<section class="banner-autoayuda">
      <div class="fondo-autoayuda">
        <img src="https://imagenes.20minutos.es/files/image_1920_1080/uploads/imagenes/2023/01/05/estres.jpeg" alt="Banner Autoayuda">
      </div>
      <div class="titulo-autoayuda">
        <h1>ESTRÉS</h1>
      </div>
    </section>
<!-- Sección "¿Qué es la ansiedad?" -->
<section class="seccion-ansiedad">
      <div class="ansiedad-info">
        <div class="texto-ansiedad">
          <h2>¿Qué es el estrés?</h2>
          <p>
            El estrés es una respuesta fisiológica y psicológica del cuerpo frente a situaciones que percibe como desafiantes o amenazadoras. Esta reacción puede desencadenar cambios físicos y emocionales, como aumento del ritmo cardíaco, tensión muscular y ansiedad. El estrés puede ser tanto agudo (a corto plazo) como crónico (a largo plazo). Mientras que cierto nivel de estrés es normal y puede ser motivador, el estrés constante o abrumador puede tener efectos negativos en la salud mental y física. La gestión adecuada del estrés es importante para mantener un equilibrio saludable en la vida cotidiana.
          </p>
        </div>
        <div class="imagen-ansiedad">
          <img src="https://www.balancegroup.cl/wp-content/uploads/2022/04/psicologi%CC%81a-adultos-533x533.png" alt="Psicología Adultos">
        </div>
      </div>
    </section>
 <!-- Sección "Sesiones que podrían ayudarte" con Swiper -->
 <section class="sesiones-ayuda">
        <div class="sesiones-titulo">
          <h2>Sesiones que podrían ayudarte</h2>
        </div>
        <div class="swiper-container">
          <div class="swiper-wrapper">
            <!-- Slide 1 -->
            <div class="swiper-slide">
              <iframe width="100%" height="315" src="https://www.youtube.com/embed/LE2tlZLmzG4?si=XESO68vyLhp42Ccn" frameborder="0" allowfullscreen></iframe>
            </div>

            <!-- Slide 2 -->
            <div class="swiper-slide">
              <iframe width="100%" height="315" src="https://www.youtube.com/embed/lAXdkk6O2Nc?si=wg9oUUGpRsutaPSR" frameborder="0" allowfullscreen></iframe>
            </div>

            <!-- Slide 3 -->
            <div class="swiper-slide">
              <iframe width="100%" height="315" src="https://www.youtube.com/embed/nAR2PUPyH1I?si=B3_yOEwBT7iaV50K" frameborder="0" allowfullscreen></iframe>
            </div>
          </div>
        </div>
      </section>
      <!-- Pie de Página -->
      <br><br>
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
      indiceBannerActual: 0,
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
  methods: {
    abrirMapa() {
      window.location.href = 'https://maps.app.goo.gl/te3G28WuD56cTgyHA';
    },
    abrirEnlace(url) {
      window.location.href = url;
    },
  }, 
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
font-size: 30px;
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