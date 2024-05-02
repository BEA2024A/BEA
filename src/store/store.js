import { createStore } from 'vuex';
import VuexPersistence from 'vuex-persist';

// Crea una instancia de VuexPersistence configurada para usar el almacenamiento local
const vuexLocal = new VuexPersistence({
  storage: window.localStorage,
  reducer: (state) => ({ usuario: state.usuario }), 
});

export default createStore({
  state: {
    usuario: null, // Aquí almacenas la información del usuario
  },
  mutations: {
    setUsuario(state, usuario) {
      state.usuario = usuario;
    },
    clearUsuario(state) {
      state.usuario = null;
    },
    setFotoPerfil(state, imageUrl) {
      if (state.usuario) {
        state.usuario.foto_perfil = imageUrl;
      }
    },
  },
  actions: {
    iniciarSesion({ commit }, usuario, correo, id, a_paterno, a_materno, tipo, foto_perfil) {
      commit('setUsuario', usuario, correo, id, a_paterno, a_materno, tipo, foto_perfil);
    },
    cerrarSesion({ commit }) {
      commit('clearUsuario');
    },
  },
  getters: {
    usuario: (state) => state.usuario,
    isUsuarioLogueado: (state) => !!state.usuario,
  },
  plugins: [vuexLocal.plugin], 
});