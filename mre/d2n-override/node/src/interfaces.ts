import { injectable } from "inversify";

@injectable()
export abstract class IApp {
    async run(): Promise<void> {}
}
