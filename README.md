# template-precompile-scope

This repo shows a bug in `precompileTemplate` scope. `precompileTemplate` expects that the scope is a function that returns an object with a few properties where keys and values are equal as in the following example.

```js
import Select from '../select';

precompileTemplate(`
    <RootSelect/>
    <Select/>
    <button {{on "click" this.toogleClicked}}>
      {{#if this.isClicked}}
        Clicked
      {{else}}
        Not clicked
      {{/if}}
    </button>
  `, {
  strictMode: true,
  scope: () => ({
    Select,
    on
  });
```

But when the project is built with the rollup, imports can be renamed. For example, `Select` can be renamed to `Select$1`. It is shown in the following example.

```js
import Select$1 from '../select';

precompileTemplate(`
    <RootSelect/>
    <Select/>
    <button {{on "click" this.toogleClicked}}>
      {{#if this.isClicked}}
        Clicked
      {{else}}
        Not clicked
      {{/if}}
    </button>
  `, {
  strictMode: true,
  scope: () => ({
    Select: Select$1,
    on
  });
```

From a javascript point of view, everything is correct and both examples are equivalent. But the second example will fail with the following error:

[Scope objects for `precompileTemplate` may only contain direct references to in-scope values](https://github.com/candunaj/template-precompile-scope/actions/runs/4478830537/jobs/7872086147#step:7:62)
