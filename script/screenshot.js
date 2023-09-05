const print = (value) => console.log(value)
const [directory, ...pathList] = process.argv.slice(2)

const puppeteer = require('puppeteer')

;(async (dir) => {
    console.log("setting up")
    const browser = await puppeteer.launch({headless: true});
    console.log("browser up")

    console.log("start capturing")
    //FIXME: Promise.allしたいがエラー出るのでfor ofにしている
    for (const path of pathList) { 
        console.log(`capture ${path}`)

        const page = await browser.newPage();
        await page.goto(`http://localhost:8000/${path}`)
        await page.screenshot({path: `${dir}/${path}.png`})
        await page.close()
    }
    
    await browser.close();
})(directory);