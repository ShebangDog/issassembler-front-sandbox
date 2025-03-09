// lib
const print = (value) => console.log(value);

// read config
const port_env_name = "APP_WEB_PORT"
const port = process.env[port_env_name]

if (!port) {
    print(`Error: ${port_env_name} is not set`);
    process.exit(1);
}

// procedure
const [directory, ...pathList] = process.argv.slice(2);

const { chromium } = require('playwright');

(async ({directory: dir, port}) => {
    print("setting up");
    const browser = await chromium.launch({ headless: true });
    print("browser up");

    print("start capturing");
    
    // PlaywrightではPromise.allを使っても問題ありません
    // ただし、同時並行処理数を制限するため、バッチ処理を実装しています
    const batchSize = 5; // 同時に処理するページ数
    
    for (let i = 0; i < pathList.length; i += batchSize) {
        const batch = pathList.slice(i, i + batchSize);
        
        await Promise.all(batch.map(async (path) => {
            print(`capture ${path}`);
            
            const page = await browser.newPage();
            try {
                await page.goto(`http://localhost:${port}/${path}`, {
                    waitUntil: 'networkidle', // ネットワークが安定するまで待機
                    timeout: 5000
                });
                
                // スクリーンショットを撮影する前に少し待機（必要に応じて）
                await page.waitForTimeout(500);
                
                // スクリーンショットを撮影
                await page.screenshot({
                    path: `${dir}/${path}.png`,
                    fullPage: true // ページ全体をキャプチャ
                });
            } catch (error) {
                print(`Error capturing ${path}: ${error.message}`);
            } finally {
                await page.close();
            }
        }));
    }
    
    await browser.close();
})({directory, port});