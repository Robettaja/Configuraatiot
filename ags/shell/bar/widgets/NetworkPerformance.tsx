import { createBinding } from "ags";
import { NetworkPerformanceService } from "../../../lib/service/NetworkPerformanceService";

const networkPerformanceService = new NetworkPerformanceService();

export default function NetworkPerformance() {
    return (
        <box>
            <label
                label={createBinding(
                    networkPerformanceService,
                    "packetLoss"
                ).as((ploss) => ploss.toString())}
            ></label>
        </box>
    );
}
