import Vue from "vue";
import { ValidationProvider } from "vee-validate";

export default Vue.extend({
  name: "BaseField",
  components: {
    ValidationProvider
  },
  inheritAttrs: false,
  data() {
    return {
      internalValue: this.value
    };
  },
  model: {
    prop: "value",
    event: "input"
  },
  props: {
    value: {
      type: String,
      default: ""
    },
    rules: {
      type: String,
      default: ""
    },
    fieldName: {
      type: String,
      default: function () {
        return this.label === null ? "Поле" : this.label;
      },
    },
    label: {
      type: String,
      default: null
    },
    icon: String,
    hideDetails: {
      type: [String, Boolean],
      default: "auto"
    }
  },
  watch: {
    value(val: string) {
      this.internalValue = val;
    }
  },
  computed: {
    inputValue: {
      get(): string {
        return this.internalValue;
      },
      set(value: string): void {
        this.internalValue = value;
        this.$emit("input", value);
      }
    },
    listeners(): Record<string, unknown> {
      return Object.assign({}, this.$listeners);
    }
  },
})