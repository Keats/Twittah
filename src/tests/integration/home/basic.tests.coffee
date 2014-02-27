# Copied from protractor tests for demo purposes
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
    ptor.sleep(2000)
    browser.findElements(By.css('.tweet')).then (result) ->
      expect(result.length).to.be.equal 2

  it 'should load more when clicking the load more button', ->
    ptor.sleep(2000)
    browser.findElements(By.css('.tweet')).then (result) ->
      expect(result.length).to.be.equal 2

    loadMore = element(By.css('.loadButton'))
    loadMore.click()
    ptor.sleep(2000)
    loadMore.click()
    ptor.sleep(2000)

    browser.findElements(By.css('.tweet')).then (result) ->
      expect(result.length).to.be.above 2
