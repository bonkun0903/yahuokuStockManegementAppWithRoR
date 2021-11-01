<template>
  <div class="container">
    <!-- <v-form 
      v-model="valid"
      @submit.prevent="createProduct"
    >
      <v-container>
        <v-row>
          <v-col
            cols="12"
            md="4"
          >
            <v-text-field
              v-model="title"
              :rules="nameRules"
              :counter="10"
              label="Add any task"
              required
            ></v-text-field>
          </v-col>
          <v-col>
            <v-btn
              class="mr-4"
              type="submit"
            >
              submit
            </v-btn>
          </v-col>
        </v-row>
      </v-container>
    </v-form> -->
    <ul>
      <li v-for="(product, index) in products" :key="product.id">
        <!-- <input
          type="checkbox"
          v-on:change="doneChange(index, product.id, product.done)"
          v-model="product.done"
        > -->
        <span>{{ product.title }}</span>
        <span>{{ product.shelf_id }}</span>
        <button v-on:click="deleteProduct(index, product.id)">削除</button>
      </li>
    </ul>
  </div>
</template>

<script>
import axios from "axios"

export default {
  data: function () {
    return {
 //productリスト
      products: [],
      //テキストボックスの値
      title: "",
    }
  },
  //一覧読み込み
  mounted () {
    axios.get('/api/v1/products').then((response) => {
      this.products = response.data
      }).catch(() => {
        alert("エラー");
      });
  },
  methods: {
    //Product作成
    createProduct() {
      axios.post("/api/v1/products", { title: this.title }).then((response) => {
        this.products.unshift(response.data);
        this.title = "";
      }).catch(() => {
        alert("エラー");
      });
    },
    //checkボックスで発火する済んだかどうかのやつ
    doneChange(index, donechange_id, done_flg) {
      axios.put(`/api/v1/products/${donechange_id}`, { done: done_flg }).then((response) => {
      }).catch(() => {
        alert("エラー");
      });
    },
    //Product削除
    deleteProduct(index, delete_id) {
      axios.delete(`/api/v1/products/${delete_id}`).then((response) => {
        this.products.splice(index, 1);
      }).catch(() => {
        alert("エラー");
      });
    }
  }
}
</script>

<style lang="scss" scoped>
  // ul {
  //   list-style: none;
  //   li {
  //     span.done {
  //       //チェックボックスで発火する取り消し線
  //       text-decoration: line-through;
  //     }
  //   }
  // }
</style>