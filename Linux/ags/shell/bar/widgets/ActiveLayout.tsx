import { LayoutService } from "../../../lib/service/LayoutService";
import { createBinding } from "ags";

const layoutService = new LayoutService();

export default function ActiveLayout() {
    return (
        <box>
            <label label={createBinding(layoutService, "layout")} />
        </box>
    );
}
