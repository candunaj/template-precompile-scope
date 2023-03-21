import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';
import Select from './internal/select';
import RootSelect from './select';

export default class MyButton extends Component {
  @tracked isClicked = false;

  @action
  toogleClicked() {
    this.isClicked = !this.isClicked;
  }

  <template>
    <RootSelect/>
    <Select/>
    <button {{on "click" this.toogleClicked}}>
      {{#if this.isClicked}}
        Clicked
      {{else}}
        Not clicked
      {{/if}}
    </button>
  </template>
}
