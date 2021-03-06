// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

require('@client-side-validations/client-side-validations');
require('jquery')
global.Toastify = require("toastify-js")
Rails.start()
Turbolinks.start()
ActiveStorage.start()


import "stylesheets/application"


import $ from 'jquery'
window.jQuery = $;
window.$ = $;

import cash from "cash-dom";
import helper from "./helper";

// Set plugins globally
window.cash = cash;
window.helper = helper;