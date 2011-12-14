require 'rubygems'
require 'bacon'

ROOT = ::File.dirname(__FILE__)+'/..'
$:.unshift ROOT+'/lib'
require 'fragment'

describe "Fragment" do

  def fragment &block
    Fragment.please(&block)
  end

  it "simple tag" do
    fragment{ br }.should == '<br />'
    fragment{ p }.should == '<p />'
  end

  it "open close tags" do
    fragment{ p{} }.should == '<p></p>'
    fragment{ div{} }.should == '<div></div>'
  end

  it "nested tags" do
    fragment{ p{ br } }.should == '<p><br /></p>'
  end

  it "deep nested tags" do
    fragment do
      p do
        div do
          ol do
            li
          end
        end
      end
    end.should == '<p><div><ol><li /></ol></div></p>'
  end

  it "deep nested tags with repetition" do
    fragment do 
      p do
        div do
          ol do
            li
            li
          end
          ol do
            li
            li
          end
        end
      end
    end.should == '<p><div><ol><li /><li /></ol><ol><li /><li /></ol></div></p>'
  end

  it "deep nested tags with strings" do
    fragment do
      p do
        div {'Hello, World'} 
      end
    end.should == '<p><div>Hello, World</div></p>'
  end
  
  it "allows to write directly if needed" do
    fragment do
      write "<!DOCTYPE html>"
    end.should == '<!DOCTYPE html>'
  end

  it "some simple example" do
    fragment do
      doctype
      html do
        head do
          title {"Hello World"}
        end
        body do
          h1 {"Hello World"}
        end
      end
    end.should == "<!DOCTYPE html>\n<html><head><title>Hello World</title></head><body><h1>Hello World</h1></body></html>"
  end

  it "some ruby inside" do
    fragment do
      table do
        tr do
          %w[one two three].each do |s|
            td{s}
          end
        end
      end
    end.should == '<table><tr><td>one</td><td>two</td><td>three</td></tr></table>'
  end

  it "escapeable attributes" do
    fragment {
      a(:href => "http://example.org/?a=one&b=two") {
        "Click here"
      }
    }.should == "<a href='http://example.org/?a=one&amp;b=two'>Click here</a>"
  end
  
  it "should accept attributes in a string" do
    fragment{ input("type='text'") }.should == "<input type='text' />"
  end

  it 'should accept symbols as attributes' do
    input = fragment{ input(:type => :text, :value => :one) }

    input.should =~ /type='text'/
    input.should =~ /value='one'/
  end

  it 'tags with prefix' do
    fragment{ tag "prefix:local" }.should == '<prefix:local />'
  end

  it 'tags with a variety of characters' do
    # with "-"
    fragment{ tag "hello-world" }.should == '<hello-world />'
    # with Hiragana
    fragment{ tag "あいうえお" }.should == '<あいうえお />'
  end
  
  it "has a practicle way to add attributes like 'selected' based on boolean" do
    @selected = false
    fragment do
      option({:name => 'opt', :selected => @selected})
      option(:name => 'opt', :selected => !@selected)
      option(:name => 'opt', :selected => @i_am_nil)
    end.should == "<option name='opt' /><option name='opt' selected='true' /><option name='opt' />"
  end
  
  it "Pass the Readme example" do
    
    default = 'HTML'
    
    html = Fragment.please do
      doctype
      html(:lang=>'en') do
        head { title { "My Choice" } }
        body do
          comment "Here starts the body"
          select(:name => 'language') do
            ['JS', 'HTML', 'CSS'].each do |l|
              option(:value => l, :selected => l==default) { l }
            end
          end
          write "\n<!-- This allows to write HTML directly when using a snippet -->\n"
          write "\n<!-- like Google Analytics or including another fragment -->\n"
        end
      end
    end
    
    html.should == "<!DOCTYPE html>\n<html lang='en'><head><title>My Choice</title></head><body>\n<!-- Here starts the body -->\n<select name='language'><option value='JS'>JS</option><option value='HTML' selected='true'>HTML</option><option value='CSS'>CSS</option></select>\n<!-- This allows to write HTML directly when using a snippet -->\n\n<!-- like Google Analytics or including another fragment -->\n</body></html>"
    
  end
end