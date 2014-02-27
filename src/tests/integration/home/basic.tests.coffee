
chai = require("chai")
chaiAsPromised = require('chai-as-promised')
chai.use(chaiAsPromised)
expect = chai.expect

describe 'Integration: Home page', ->
  url = 'http://localhost:8001'
  ptor = protractor.getInstance()

  beforeEach ->
    browser.get(url)

  it 'should have 3 buttons on the page', ->
    browser.findElements(By.css('button')).then (result) ->
      expect(result.length).to.be.equal 3

  it 'should load tweets initially', ->
    ptor.sleep(1000)
    browser.findElements(By.css('.tweet')).then (result) ->
      expect(result.length).to.be.equal 2

  it 'should load more when clicking the load more button', ->
    ptor.sleep(1000)
    browser.findElements(By.css('.tweet')).then (result) ->
      expect(result.length).to.be.equal 2

    # Hopefully the api won't fail 3 times in a row
    loadMore = element(By.css('.loadButton'))
    loadMore.click()
    ptor.sleep(1000)
    loadMore.click()
    ptor.sleep(1000)
    loadMore.click()
    ptor.sleep(1000)

    browser.findElements(By.css('.tweet')).then (result) ->
      expect(result.length).to.be.above 2

  it 'should reorder by sentiment', ->
    ptor.sleep(1000)
    loadMore = element(By.css('.loadButton'))
    loadMore.click()
    ptor.sleep(1000)
    loadMore.click()
    ptor.sleep(1000)
    loadMore.click()
    ptor.sleep(1000)
    orderButton = element(By.css('.orderBySentiment'))
    orderButton.click()

    browser.findElements(By.css('.sentiment')).then (result) ->
      result[0].getText().then (firstTweetSentiment) ->
        result[result.length - 1].getText().then (lastTweetSentiment) ->
          expect(parseFloat(firstTweetSentiment)).to.be.below parseFloat(lastTweetSentiment)

    # and we can reverse it by reclicking on it !
    orderButton.click()

    browser.findElements(By.css('.sentiment')).then (result) ->
      result[0].getText().then (firstTweetSentiment) ->
        result[result.length - 1].getText().then (lastTweetSentiment) ->
          expect(parseFloat(firstTweetSentiment)).to.be.above parseFloat(lastTweetSentiment)

  it 'should reorder by date', ->
    ptor.sleep(1000)
    loadMore = element(By.css('.loadButton'))
    loadMore.click()
    ptor.sleep(1000)
    loadMore.click()
    ptor.sleep(1000)
    loadMore.click()
    ptor.sleep(1000)
    orderButton = element(By.css('.orderByDate'))
    orderButton.click()

    browser.findElements(By.css('.updated-at')).then (result) ->
      result[0].getText().then (firstTweetDate) ->
        result[result.length - 1].getText().then (lastTweetDate) ->
          expect(firstTweetDate).to.be.below lastTweetDate

    # and we can reverse it by reclicking on it !
    orderButton.click()

    browser.findElements(By.css('.updated-at')).then (result) ->
      result[0].getText().then (firstTweetDate) ->
        result[result.length - 1].getText().then (lastTweetDate) ->
          expect(firstTweetDate).to.be.above lastTweetDate
