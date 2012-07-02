require 'nokogiri'

module CustomHtmlMatchers
  class TagAttrMatcher
    def initialize(expected_attr)
      @expected_attr = expected_attr
    end
    def matches?(response)
      @given_body= response.body
      xpath_attr_search = @expected_attr.map {|attr, value| "@#{attr}='#{value}'"}
      xpath_attr_search = xpath_attr_search.join(" and ")
      html = Nokogiri::HTML(@given_body)
      results = html.xpath("//*[#{xpath_attr_search}]")
      return results.length > 0
    end
    def failure_message
      "expected the following to have attributes #{@expected_attr.to_s}:\n\n#{@given_body.to_s}"
    end
    def negative_failure_message
      "expected the following not to have attributes #{@expected_attr.to_s}:\n\n#{@given_body.to_s}"
    end
  end
  
  def have_tag_with_attr(tag_attr_hash)
    TagAttrMatcher.new(tag_attr_hash)
  end
end