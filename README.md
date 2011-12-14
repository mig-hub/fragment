FRAGMENT
========

Fragment is an HTML builder heavily based on Gestalt from the Ramaze framework. 
Its main purpose is to create fragments of HTML (hence the name), 
but is perfectly suited for building full pages.

In essence, Fragment works more or less like any builder except that the code 
is reduce to the minimum. Instead of trying to be universal, I would rather keep the 
code as simple as possible and concentrate on small problems I have everyday when trying to
write HTML via Ruby.

First, how to install:

    sudo gem install fragment

Them you can require Fragment and use it that way:

    require 'fragment'
     
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

If you try this example, you might notice a couple of things:

First of all, you have a `doctype` helper which only creates an HTML5 doctype.
If you want something else, you can use the `write` function which lets you write directly in place:

    write "<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.01//EN'"
    write "  'http://www.w3.org/TR/html4/strict.dtd'>"

The major difference with Gestalt (if you used it) is that it does not accept content
in the arguments. This simplifies the code a lot for a very small sacrifice.
So the argument is either a Hash that represents the attributes, or a string like
you would write in the HTML code.

One problem I had when creating fragments of HTML from code with a Hash for attributes
is for attributes like 'selected' or 'checked' which are a bit annoying because they do
not have a negative value (not that I know of), so you cannot write things like:

    selected='not_selected'

I find this slightly irritating.
So what I did is that in the Hash, when a value is false, its key is removed.
This is what I did on the long example above for marking the default option.

Nothing fancy but quite good to be aware of.

Do not hesitate to fork the project if you want to help me improve it.

Thanx  
Mig