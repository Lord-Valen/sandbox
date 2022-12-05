import { injectable } from "inversify";
import { IApp } from "./interfaces.js";

@injectable()
export class App extends IApp {
    public async run(): Promise<void> {
        const message: string = "Hello, World!";

        console.log(message);
    }
}
