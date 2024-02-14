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

   <!-- Título de la Sección -->
   <br>
   <div class="titulo-seccion-sintomas">
  <h1>¿CON QUE CASO TE IDENTIFICAS MAS?</h1>
</div>


      <!-- Sección de Método de Trabajo -->
    <section class="seccion-metodo">
      <div
        v-for="(item, index) in itemsMetodo"
        :key="index"
        class="item-metodo"
        @click="abrirEnlace(item.link)"
        @mouseover="mostrarSintomas(item)"
        @mouseleave="ocultarSintomas"
      >
        <img :src="item.imagen" alt="Método de Trabajo">
        <div class="descripcion-metodo" v-if="!item.mostrarSintomas">{{ item.descripcion }}</div>
        <div class="sintomas-metodo" v-if="item.mostrarSintomas">
          <ul>
            <li v-for="(sintoma, i) in item.sintomas" :key="i">{{ sintoma }}</li>
          </ul>
        </div>
      </div>
    </section>
    

    <!-- Agregando la sección de Autoayuda General -->
<section class="seccion-autoayuda">
  <div class="titulo-seccion-autoayuda">
    <h1>SESIONES DE MEDITACIÓN</h1>
  </div>

  <!-- Primer Cajón -->
  <div class="cajon-autoayuda" :class="{ 'inverted': (index % 2 !== 0) }" v-for="(video, index) in videosAutoayuda" :key="index">
    <div class="contenido-cajon">
      <div class="texto-cajon">
        <h2>{{ video.titulo }}</h2>
        <p>{{ video.descripcion }}</p>
      </div>
      <div class="video-cajon">
        <iframe :src="video.enlace" frameborder="0" allowfullscreen></iframe>
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
      banners: [
        "https://i.ibb.co/G0DQd1D/Whats-App-Image-2024-02-11-at-6-53-05-PM.jpg",
        "https://i.ibb.co/2yLFNQf/Whats-App-Image-2024-02-11-at-7-50-21-PM.jpg",
        "https://i.ibb.co/Qv8WMW5/Whats-App-Image-2024-02-11-at-7-50-21-PM-1.jpg",
      ],
      botonesSociales: [
        { icono: 'https://www.anahuac.mx/oaxaca/sites/default/files/img/redFacebook_1.png', enlace: 'https://www.facebook.com/anahuacoaxaca/' },
        { icono: 'https://www.anahuac.mx/oaxaca/sites/default/files/img/redInstagram.png', enlace: 'https://www.instagram.com/anahuacoaxaca' },
        { icono: 'https://www.anahuac.mx/oaxaca/sites/default/files/img/redTwitter.png', enlace: 'https://twitter.com/anahuacoaxaca' },
        { icono: 'https://www.anahuac.mx/oaxaca/sites/default/files/img/redYoutube.png', enlace: 'https://www.youtube.com/channel/UCk5xAk91c-F_lNKn6ceDVZQ' },
      ],
      itemsMetodo: [
        { 
          link: '/ansiedad',
          imagen: 'https://clicandpost.com/wp-content/uploads/2021/02/young-woman-is-depressed-on-white-bed-scaled-1.jpg',
          descripcion: 'Ansiedad',
          sintomas: [
            'Tienes preocupación excesiva.',
            'Sientes inquietud o nerviosismo.',
            'Te dan palpitaciones, sudoración o temblores.',
            'Llegas a tener dificultad para respirar.',
            'Problemas para conciliar el sueño.'
          ],
          mostrarSintomas: false,
        },
        { 
          link: '/estrés',
          imagen: 'https://staticnew-prod.topdoctors.cl/files/Image/large/6352d12da0b186ad8dd0b6810704aa56.jpg',
          descripcion: 'Estrés',
          sintomas: [
            ' Sientes fatiga o agotamiento.',
            ' Te duele el cuerpo.',
            'Te cuesta concentrarte.',
            'Cambios en tus patrones de sueño.'
          ],
          mostrarSintomas: false,
        },
        { 
          link: '/depresión',
          imagen: 'https://www.huelvainformacion.es/2023/07/15/vivir_en_huelva/joven-muestra-tristeza-junto-ventana_1811529230_188959071_667x375.jpg',
          descripcion: 'Depresión',
          sintomas: [
            'Te sientes triste de manera persistente.',
            'Pierdes de interés en actividades que te gustan.',
            'Cambios en tu apetito o peso.',
            'Sientes problemas para conciliar el sueño o duermes en exceso.'
          ],
          mostrarSintomas: false,
        },
        { 
          link: '/fatiga-mental',
          imagen: 'https://www.eltiempo.com/files/article_main_1200/uploads/2017/10/31/59f8cefa7bcab.jpeg',
          descripcion: 'Fatiga Mental',
          sintomas: [
            'Te sientes agotado.',
            'Se te dificulta concentrarte.',
            'Sensación de falta de energía cognitiva.',
            'Sientes que no puedes para manejar el estrés mental.'
          ],
          mostrarSintomas: false,
        },
      ],

      enlacesPie: {
        'Aviso de Privacidad': 'https://www.anahuac.mx/oaxaca/aviso-privacidad',
        'Compendio Reglamentario': 'https://www.anahuac.mx/oaxaca/compendio-reglamentario',
      },

      videosAutoayuda: [
        {
          enlace: 'https://www.youtube.com/embed/aBsnQjJ2_Nk?si=JjuEzSsuCh2UxwV8',
          titulo: 'Superar situaciones difíciles',
          descripcion: 'Esta meditación guiada busca eliminar la ansiedad y superar situaciones difíciles. Se invita a sentarse cómodamente, cerrar los ojos y observar la respiración. A través de la visualización, la emoción negativa se representa como un objeto que rodea al individuo. La meditación se centra en respirar para disolver esa energía, creando espacio y purificando el entorno. La exhalación impregna el aire con una "ola de calma" que alivia el dolor.',
        },
        {
          enlace: 'https://www.youtube.com/embed/4mSwSMO8cEQ?si=cIrOaUMu1mo60Ukg',
          titulo: 'Relájate y descansa',
          descripcion: 'Jorge Benito te da la bienvenida a una meditación para calmar la mente y liberar el estrés al final del día. Invita a adoptar una postura cómoda, mover suavemente los hombros y el cuello, y cerrar los ojos. La respiración se convierte en el foco, inhalando y exhalando lentamente. Con los ojos cerrados, se presta atención a los sonidos y la temperatura ambiente.',
        },
        {
          enlace: 'https://www.youtube.com/embed/gxBNte5VDJE?si=BU7t3G1f73szUFgA',
          titulo: 'Meditación para los momentos difíciles',
          descripcion: 'Esta meditación guiada, liderada por Rosario Vicencio, invita a cerrar los ojos y comenzar inhalando y exhalando suave y profundamente. Se visualiza una luz poderosa y llena de certeza que cae sobre la coronilla, iluminando el cuerpo y proporcionando fortaleza. La fe se destaca como la certeza absoluta de influir sobre lo físico con la mente y la energía. Se insta a confiar y mantener la certeza de que todo estará bien.',
        },
      ],
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
    // Nuevas funciones para mostrar/ocultar síntomas
    mostrarSintomas(item) {
      // Ocultar síntomas de otros items
      this.itemsMetodo.forEach((otherItem) => {
        if (otherItem !== item) {
          otherItem.mostrarSintomas = false;
        }
      });

      // Mostrar síntomas del item actual
      item.mostrarSintomas = true;
    },
    ocultarSintomas() {
      // Ocultar síntomas al sacar el mouse de cualquier item
      this.itemsMetodo.forEach((item) => {
        item.mostrarSintomas = false;
      });
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

/* Agrega este estilo para la barra negra */
.barra-separadora {
  background-color: black;
  height: 10px; /* Puedes ajustar la altura según tus preferencias */
  width: 100%;
}

/* Ajusta el margen superior de la sección de Autoayuda General para dejar espacio para la barra */
.seccion-autoayuda {
  margin-top: 10px; /* Ajusta según la altura de la barra */
}



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

/* Estilos del Título de la Sección */
.titulo-seccion-sintomas {
  background-color: #423a38;
  text-align: center;
  margin-bottom: 20px;
  width: 70%; /* Cambiado para que no ocupe el ancho completo */
  padding: 10px;
  border-radius: 15px; /* Añadido para esquinas redondeadas */
  margin-left: auto;
  margin-right: auto;
}

.titulo-seccion-sintomas h1 {
  font-size: 30px;
  color: white;
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


/* Método de Trabajo */

.sintomas-metodo {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  color: white;
  font-weight: bold;
  text-align:justify;
  width: 80%;
  opacity: 0.8;
  transition: opacity 0.3s ease;
}
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
  height: 500px;
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

/* Estilos para la sección de Autoayuda General */
.seccion-autoayuda {
  margin-top: 40px;
  background-image: url('https://i.ibb.co/MNhbG6b/Campus-Ana-huac-Oaxaca.png"'); /* URL de la imagen */
  background-size: cover;
  background-position: center;
  padding: 20px;
  border-radius: 10px;
}

.titulo-seccion-autoayuda {
  background-color: rgba(255, 255, 255, 0.5); /* Blanco transparente */
  text-align: center;
  margin-bottom: 20px;
  width: 70%;
  padding: 20px;
  border-radius: 15px;
  margin-left: auto;
  margin-right: auto;
  color: rgb(3, 3, 3); /* Color del texto */
  transition: background-color 0.3s ease, transform 0.3s ease;
}

.titulo-seccion-autoayuda:hover {
  background-color: rgba(255, 255, 255, 0.8); /* Blanco más sólido al pasar el mouse */
  transform: scale(1.05); /* Agrandar al pasar el mouse */
}

.titulo-seccion-autoayuda h1 {
  font-size: 30px;
  margin: 0;
  opacity: 0;
  animation: fadeIn 1s ease forwards;
}

.cajon-autoayuda {
  background-color: rgba(255, 255, 255, 0.5); /* Blanco transparente */
  border-radius: 15px;
  margin-bottom: 50px;
  overflow: hidden;
  width: 70%;
  margin-left: auto;
  margin-right: auto;
  display: flex;
  flex-direction: column;
  transition: background-color 0.3s ease, transform 0.3s ease; /* Transición en el cambio de color y tamaño */
}

.cajon-autoayuda:hover {
  background-color: rgba(255, 255, 255, 0.8); /* Blanco más sólido al pasar el mouse */
  transform: scale(1.05); /* Agrandar al pasar el mouse */
}

.cajon-autoayuda.inverted .contenido-cajon {
  flex-direction: row-reverse;
}

.contenido-cajon {
  display: flex;
  align-items: center;
}

.texto-cajon {
  flex: 1;
  padding: 20px;
  text-align: center;
}

.texto-cajon h2 {
  color: black;
  font-size: 24px;
  margin-bottom: 10px;
}

.texto-cajon p {
  color: black;
}

.video-cajon {
  flex: 1;
}

.video-cajon iframe {
  width: 100%;
  height: 500px;
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




