export function truncate(text: string) {
    if (text.length > 50) {
        return text.substring(0, 50) + "...";
    }
    return text;
}
export function range(n: number, start: number = 0): Array<number> {
    return Array.from({ length: n }, (_, i) => i + start);
}
