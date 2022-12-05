import { AsyncContainerModule, interfaces } from "inversify";
import { App } from "./App.js";
import { IApp } from "./interfaces.js";

export const bindings = new AsyncContainerModule(async (bind: interfaces.Bind) => {
    bind(IApp).to(App);
});
