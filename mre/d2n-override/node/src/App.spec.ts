import "reflect-metadata";

import { jest } from "@jest/globals";
import { Container } from "inversify";
import { bindings } from "./bindings.js";
import { IApp } from "./interfaces.js";

describe("Hello", () => {
    let container: Container;
    let sut: IApp;

    beforeAll(() => {
        container = new Container();
        container.loadAsync(bindings);
        sut = container.get(IApp);
    });

    beforeEach(() => {
        container.snapshot();
    });

    afterEach(() => {
        container.restore();
    });

    test("is defined", () => {
        expect(sut).toBeDefined();
    });

    test("says hello", () => {
        const consoleSpy = jest.spyOn(console, "log");

        sut.run();

        expect(consoleSpy).toHaveBeenCalledWith("Hello, World!");
    });
});
