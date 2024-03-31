import { createStore } from 'vuex';
import VuexPersistence from 'vuex-persist';

// Crea una instancia de VuexPersistence configurada para usar el almacenamiento local
const vuexLocal = new VuexPersistence({
  storage: window.localStorage,
  reducer: (state) => ({ usuario: state.usuario }), // Solo haz persistente el estado necesario
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
  },
  actions: {
    iniciarSesion({ commit }, usuario) {
      commit('setUsuario', usuario);
    },
    cerrarSesion({ commit }) {
      commit('clearUsuario');
    },
  },
  getters: {
    usuario: (state) => state.usuario,
    isUsuarioLogueado: (state) => !!state.usuario,
  },
  plugins: [vuexLocal.plugin], // Añade VuexPersistence como un plugin a tu store
});
