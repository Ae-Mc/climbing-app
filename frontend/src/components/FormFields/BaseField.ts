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
    fieldName: String,
    label: {
      type: String,
      default: ""
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
  render(h) {
    return h('span', ['test']);
  }
})