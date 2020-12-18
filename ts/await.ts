function delay(milliseconds: number, count: number): Promise<number> {
    return new Promise<number>(resolve => {
            setTimeout(() => {
                resolve(count);
            }, milliseconds);
        });
}

// async関数は常にPromiseを返します
async function dramaticWelcome(): Promise<void> {
    console.log("Hello");

    for (let i = 0; i < 5; i++) {
        // awaitは、Promise<number>をnumberに変換します
        const count:number = await delay(500, i);
        console.log(count);
    }

    console.log("World!");
}

dramaticWelcome();