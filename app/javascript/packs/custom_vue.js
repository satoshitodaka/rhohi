import Vue from 'vue/dist/vue.esm'
import App from '../app.vue'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#hello2',
    data: {
      message: "聞こえますか？これはvue.jsなのです。htmlの書き込みではありません"
    },
    components: { App }
  })
})

constapp=newVue({
  el:'#app',
    data:{
      items:[
        {no:'1',name:'そら',sex:'♂',age:'8',kind:'キジトラ',favorite:'犬の人形'},
        {no:'2',name:'りく',sex:'♂',age:'7',kind:'長毛種',favorite:'人間'},
        {no:'3',name:'うみ',sex:'♀',age:'6',kind:'ミケ',favorite:'高級ウェットフード'},
        {no:'4',name:'こうめ',sex:'♀',age:'4',kind:'サビ',favorite:'横取りフード'},
      ]
    }
  })
