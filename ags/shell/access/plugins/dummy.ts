import { Plugin, SearchResult } from "./index"

export class DummyPlugin extends Plugin {
    constructor() {
        super("Dummy", "👍️", true, "");
    }
    async results(search: string): Promise<SearchResult[]> {
        return [this.makeResult("First"), this.makeResult("Second")]
    }
}
