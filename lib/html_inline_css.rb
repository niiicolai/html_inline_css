require "html_inline_css/version"
require "nokogiri"

module InlineCssString
  class CSS

    def self.get_all_class_and_ids
      @html_tags.each do |tag|
        @doc_to.css("#{tag}").each do |y|
          unless y.nil? 
            if @classes.empty?
              @classes << y["class"].to_s;
            else
              @classes.each do |css_class|; unless css_class == y["class"] || y["class"].nil?; @classes << y["class"].to_s; break; end; end;
            end
            if @ids.empty?
              @ids << y["id"].to_s;
            else
              @ids.each do |css_id|; unless css_id == y["id"] || y["id"].nil?; @ids << y["id"].to_s; break; end; end;
            end
          end
        end
      end
    end

    def self.add_style_tag_to_html(html)
      @html_tags.each do |tag|
        html.css("#{tag}").each do |x| 
          unless x.nil? 
            unless x.to_s.match(/<#{Regexp.escape(tag)}\s(.*?)style=('|")(.*?)('|")(.*?)>/)
              x['style'] = ''
            end
          end
        end
      end
    end

    def self.add_style(tag, arr)
      unless arr.nil?; 
      	no_newline_arr = arr.gsub(/\n|\r|\t/,"")
        @doc_to.css("#{tag}").each do |y|
          unless y.nil? 
            y.to_s.scan(/style="([^"]*)"|style='([^"]*)'/).flatten.select{ |i| !i.nil?; unless i.nil?; y['style'] = "#{no_newline_arr}#{i}" end }				
          end
        end
      end
    end

    def self.add_style_by_id_or_class(id_or_class_name, arr, id_or_class)
      unless arr.nil?; 
      	no_newline_arr = arr.gsub(/\n|\r|\t/,"")
        if id_or_class == "class"
          @html_tags.each do |tag|
            @doc_to.xpath("#{tag}[@class = '#{id_or_class_name}']").each do |y|
              unless y.nil? 
                y.to_s.scan(/style="([^"]*)"|style='([^"]*)'/).flatten.select{ |i| !i.nil?; unless i.nil?; y['style'] = "#{no_newline_arr}#{i}" end }				
              end
            end
          end
        else
          @html_tags.each do |tag|
            @doc_to.xpath("#{tag}[@class = '#{id_or_class_name}']").each do |y|
              unless y.nil? 
                y.to_s.scan(/style="([^"]*)"|style='([^"]*)'/).flatten.select{ |i| !i.nil?; unless i.nil?; y['style'] = "#{arr}#{i}" end }				
               end
            end
          end
        end
      end
    end

    def self.add_style_by_id_or_class_to_child(id_or_class_name, arr, id_or_class)
      unless arr.nil?; 
      	no_newline_arr = arr.gsub(/\n|\r|\t/,"")
        if id_or_class == "class"
          @html_tags.each do |tag|
            @doc_to.xpath("#{tag}[@class = '#{id_or_class_name}']").each do |y|
              unless y.nil? 
                y.xpath("#{tag}").each do |c|
                  c.to_s.scan(/style="([^"]*)"|style='([^"]*)'/).flatten.select{ |i| !i.nil?; unless i.nil?; c['style'] = "#{no_newline_arr}#{i}" end }				
                end
              end
            end
          end
        else
          @html_tags.each do |tag|
            @doc_to.xpath("#{tag}[@id = '#{id_or_class_name}']").each do |y|
              unless y.nil? 
                y.xpath("#{tag}").each do |c|
                  c.to_s.scan(/style="([^"]*)"|style='([^"]*)'/).flatten.select{ |i| !i.nil?; unless i.nil?; c['style'] = "#{arr}#{i}" end }				
                end
              end
            end
          end
        end
      end
    end

    def self.inline_css_with_class_and_html(html)
      style_tags = html.search('style').map { |n| n.inner_text }
      style_tags.each do |tag|
        # CLASS
        @classes.each do |css_class|
          @html_tags.each do |tags|
            regex = /\.#{Regexp.escape(css_class)}\s#{Regexp.escape(tags)}\s{(.*?)}|\.#{Regexp.escape(css_class)}\s#{Regexp.escape(tags)}{(.*?)}/m
            tag.scan(regex).flatten.select{ |x| !x.nil?; add_style_by_id_or_class_to_child(css_class, x, 'class'); }
            new_html = @doc.to_s; @doc = Nokogiri::HTML::DocumentFragment.parse(new_html.gsub(regex,""))
          end
        end
        # ID
        @ids.each do |css_id|
          @html_tags.each do |tag|
            regex = /\##{Regexp.escape(css_id)}\s#{Regexp.escape(tag)}\s{(.*?)}|\##{Regexp.escape(css_id)}\s#{Regexp.escape(tag)}{(.*?)}/m
            tag.scan(regex).flatten.select{ |x| !x.nil?; add_style_by_id_or_class_to_child(css_id, x, 'id'); x.gsub("",""); }
            new_html = @doc.to_s; @doc = Nokogiri::HTML::DocumentFragment.parse(new_html.gsub(regex,""))
          end
        end
      end
    end

    def self.inline_css_from_style_tag(html)	
      style_tags = html.search('style').map { |n| n.inner_text }
      style_tags.each do |tag|
        @html_tags.each do |html_tag|
          unless html_tag == "a" || html_tag == "b" || html_tag == "i" || html_tag == "u" || html_tag == "s" || html_tag == "q" || html_tag == "p"
            tag.scan(/#{Regexp.escape(html_tag)}(.*?){(.*?)}/m).flatten.select{ |x| !x.nil?; add_style("#{html_tag}", x) }
          else
            tag.scan(/#{Regexp.escape(html_tag)}{(.*?)}|u\s{(.*?)}/m).flatten.select{ |x| !x.nil?; add_style("#{html_tag}", x) }
          end	      
        end
        # CLASS
        @classes.each do |css_class|
          regex = /\.#{Regexp.escape(css_class)}\s{(.*?)}|\.#{Regexp.escape(css_class)}{(.*?)}/m
          tag.scan(regex).flatten.select{ |x| !x.nil?; add_style_by_id_or_class(css_class, x, 'class'); }
        end
        # ID
        @ids.each do |css_id|
          regex = /\##{Regexp.escape(css_id)}\s{(.*?)}|\##{Regexp.escape(css_id)}{(.*?)}/m
          tag.scan(regex).flatten.select{ |x| !x.nil?; add_style_by_id_or_class(css_id, x, 'id') }
        end
      end
    end

    def self.inline_css(html)
      @html_tags = ["div","span","b","a","i","abbr","acronym","address","applet","area","article","aside","bdi","big","blockquote","caption","center","cite","code","col","colgroup","datalist","dd","del","details","dfn","dialog","dir","dl","dt","em","footer","form","frame","frameset","h1","h2","h3","h4","h5","h6","hr","iframe","img","input","ins","kbd","keygen","label","legend","li","link","main","map","mark","menu","menuitem","meter","nav","object","ol","optgroup","option","output","p","param","pre","progress","q","rp","rt","ruby","s","samp","section","select","small","source","strike","strong","sub","summary","sup","table","tbody","td","textarea","tfoot","th","thead","time","tr","track","tt","u","ul","var","wbr"]
      @classes = Array.new
      @ids = Array.new
      @html_without_skeleton = html.gsub(/<style>(.*?)\n\t\t<\/style>|<style>(.*?)<\/style>|<html>|<\/html>|<head>|<\/head>|<body>|<\/body>|<script>|<\/script>/m,"")
      @doc = Nokogiri::HTML::DocumentFragment.parse(html)
      @doc_to = Nokogiri::HTML::DocumentFragment.parse(@html_without_skeleton)
      self.get_all_class_and_ids
      self.add_style_tag_to_html(@doc_to)
      #self.inline_css_with_class_and_html(@doc)
      self.inline_css_from_style_tag(@doc)
      return @doc_to.to_html
    end
    
  end
end