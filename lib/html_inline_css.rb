require "html_inline_css/version"
require "nokogiri"

module InlineCssString
	class CSS

		def get_all_class_and_ids
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

		def add_style_tag_to_html(html)
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

		def add_style(tag, arr)
			unless arr.nil?; 
				@doc_to.css("#{tag}").each do |y|
					unless y.nil? 
						y.to_s.scan(/style="([^"]*)"|style='([^"]*)'/).flatten.select{ |i| !i.nil?; unless i.nil?; y['style'] = "#{arr}#{i}" end }				
					end
				end
			end
		end

		def add_style_by_id_or_class(id_or_class_name, arr, id_or_class)
			unless arr.nil?; 
				if id_or_class == "class"
					@html_tags.each do |tag|
						@doc_to.xpath("#{tag}[@class = '#{id_or_class_name}']").each do |y|
							unless y.nil? 
								y.to_s.scan(/style="([^"]*)"|style='([^"]*)'/).flatten.select{ |i| !i.nil?; unless i.nil?; y['style'] = "#{arr}#{i}" end }				
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

		def inline_css_from_style_tag(html)
			
			style_tags = html.search('style').map { |n| n.inner_text }

			style_tags.each do |tag|

				# DIV
				tag.scan(/div(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("div", x) }

				# PARAGRAPH
				tag.scan(/p\s{(.*?)}|p{(.*?)}/).flatten.select{ |x| !x.nil?; add_style("p", x) }

				# BOLD
				tag.scan(/b\s{(.*?)}|b{(.*?)}/).flatten.select{ |x| !x.nil?; add_style("b", x) }

				# ITALIC
				tag.scan(/i{(.*?)}|i\s{(.*?)}/).flatten.select{ |x| !x.nil?; add_style("i", x) }

				# SPAN
				tag.scan(/span(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("span", x) }

				# H1
				tag.scan(/h1(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("h1", x) }

				# H2
				tag.scan(/h2(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("h2", x) }

				# H3
				tag.scan(/h3(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("h3", x) }

				# H4
				tag.scan(/h4(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("h4", x) }

				# H5
				tag.scan(/h5(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("h5", x) }

				# H6
				tag.scan(/h6(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("h6", x) }

				# A
				tag.scan(/a(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("a", x) }

				# ABBR
				tag.scan(/abbr(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("abbr", x) }

				# ACRONYM
				tag.scan(/acronym(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("acronym", x) }

				# ADDRESS
				tag.scan(/address(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("address", x) }

				# APPLET
				tag.scan(/applet(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("applet", x) }

				# AREA
				tag.scan(/area(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("area", x) }

				# ARTICLE
				tag.scan(/article(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("article", x) }

				# ASIDE
				tag.scan(/aside(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("aside", x) }

				# BDI
				tag.scan(/bdi(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("bdi", x) }

				# BIG
				tag.scan(/big(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("big", x) }

				# BLOCKQUOTE
				tag.scan(/blockquote(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("blockquote", x) }

				# CAPTION
				tag.scan(/caption(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("caption", x) }

				# CENTER
				tag.scan(/center(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("center", x) }

				# CITE
				tag.scan(/cite(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("cite", x) }

				# CODE
				tag.scan(/code(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("code", x) }

				# COL
				tag.scan(/col(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("col", x) }

				# COLGROUP
				tag.scan(/colgroup(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("colgroup", x) }

				# DATALIST
				tag.scan(/datalist(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("datalist", x) }

				# DD
				tag.scan(/dd(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("dd", x) }

				# DEL
				tag.scan(/del(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("del", x) }

				# details
				tag.scan(/details(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("details", x) }

				# DFN
				tag.scan(/dfn(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("dfn", x) }

				# DIALOG
				tag.scan(/dialog(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("dialog", x) }

				# DIR
				tag.scan(/dir(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("dir", x) }

				# DL
				tag.scan(/dl(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("dl", x) }

				# DT
				tag.scan(/dt(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("dt", x) }

				# EM
				tag.scan(/em(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("em", x) }

				# FOOTER
				tag.scan(/footer(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("footer", x) }

				# FORM
				tag.scan(/form(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("form", x) }

				# FRAME
				tag.scan(/frame(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("frame", x) }

				# FRAMESET
				tag.scan(/frameset(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("frameset", x) }

				# HR
				tag.scan(/hr(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("hr", x) }

				# IFRAME
				tag.scan(/iframe(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("iframe", x) }

				# IMG
				tag.scan(/img(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("img", x) }

				# INPUT
				tag.scan(/input(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("input", x) }

				# INS
				tag.scan(/ins(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("ins", x) }

				# KBD
				tag.scan(/kbd(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("kbd", x) }

				# KEYGEN
				tag.scan(/keygen(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("keygen", x) }

				# LABEL
				tag.scan(/label(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("label", x) }

				# LEGEND
				tag.scan(/legend(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("legend", x) }

				# LI
				tag.scan(/li(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("li", x) }

				# LINK
				tag.scan(/link(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("link", x) }

				# MAIN
				tag.scan(/main(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("main", x) }

				# MAP
				tag.scan(/map(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("map", x) }

				# MARK
				tag.scan(/mark(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("mark", x) }

				# MENU
				tag.scan(/menu(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("menu", x) }

				# MENUITEM
				tag.scan(/menuitem(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("menuitem", x) }

				# METER
				tag.scan(/meter(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("meter", x) }

				# NAV
				tag.scan(/nav(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("nav", x) }

				# OBJECT
				tag.scan(/object(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("object", x) }

				# OL
				tag.scan(/ol(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("ol", x) }

				# OPTGROUP
				tag.scan(/optgroup(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("optgroup", x) }

				# OPTION
				tag.scan(/option(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("option", x) }

				# OUTPUT
				tag.scan(/output(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("output", x) }

				# PARAM
				tag.scan(/param(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("param", x) }

				# PRE
				tag.scan(/pre(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("pre", x) }

				# PROGRESS
				tag.scan(/progress(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("progress", x) }

				# Q
				tag.scan(/q{(.*?)}|q\s{(.*?)}/).flatten.select{ |x| !x.nil?; add_style("q", x) }

				# RP
				tag.scan(/rp(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("rp", x) }

				# RT
				tag.scan(/rt(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("rt", x) }

				# RUBY
				tag.scan(/ruby(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("ruby", x) }

				# S
				tag.scan(/s{(.*?)}|s\s{(.*?)}/).flatten.select{ |x| !x.nil?; add_style("ruby", x) }

				# SAMP
				tag.scan(/samp(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("samp", x) }

				# SECTION
				tag.scan(/section(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("section", x) }

				# SELECT
				tag.scan(/select(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("select", x) }

				# SMALL
				tag.scan(/small(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("small", x) }

				# SOURCE
				tag.scan(/source(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("source", x) }

				# STRIKE
				tag.scan(/strike(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("strike", x) }

				# STRONG
				tag.scan(/strong(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("strong", x) }

				# SUB
				tag.scan(/sub(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("sub", x) }

				# SUMMARY
				tag.scan(/summary(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("summary", x) }

				# SUP
				tag.scan(/sup(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("sup", x) }

				# TABLE
				tag.scan(/table(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("table", x) }

				# TBODY
				tag.scan(/tbody(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("tbody", x) }

				# TD
				tag.scan(/td(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("td", x) }

				# TEXTAREA
				tag.scan(/textarea(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("textarea", x) }

				# TFOOT
				tag.scan(/tfoot(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("tfoot", x) }

				# TH
				tag.scan(/th(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("th", x) }

				# THEAD
				tag.scan(/thead(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("thead", x) }

				# TIME
				tag.scan(/time(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("time", x) }

				# TR
				tag.scan(/tr(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("tr", x) }

				# TRACK
				tag.scan(/track(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("track", x) }

				# TT
				tag.scan(/tt(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("tt", x) }

				# U
				tag.scan(/u{(.*?)}|u\s{(.*?)}/).flatten.select{ |x| !x.nil?; add_style("u", x) }

				# UL
				tag.scan(/ul(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("ul", x) }

				# VAR
				tag.scan(/var(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("var", x) }

				# WBR
				tag.scan(/wbr(.*?){(.*?)}/).flatten.select{ |x| !x.nil?; add_style("wbr", x) }

				# CLASS
				@classes.each do |css_class|
					regex = /\.#{Regexp.escape(css_class)}\s{(.*?)}|\.#{Regexp.escape(css_class)}{(.*?)}/
					tag.scan(regex).flatten.select{ |x| !x.nil?; add_style_by_id_or_class(css_class, x, 'class'); }
				end

				# ID
				@ids.each do |css_id|
					regex = /\##{Regexp.escape(css_id)}\s{(.*?)}|\##{Regexp.escape(css_id)}{(.*?)}/
					tag.scan(regex).flatten.select{ |x| !x.nil?; add_style_by_id_or_class(css_id, x, 'id') }
				end

			end
		end

		def self.inline_css(html)
			@html_tags 				= ["div","span","b","a","i","abbr","acronym","address","applet","area","article","aside","bdi","big","blockquote","caption","center","cite","code","col","colgroup","datalist","dd","del","details","dfn","dialog","dir","dl","dt","em","footer","form","frame","frameset","h1","h2","h3","h4","h5","h6","hr","iframe","img","input","ins","kbd","keygen","label","legend","li","link","main","map","mark","menu","menuitem","meter","nav","object","ol","optgroup","option","output","p","param","pre","progress","q","rp","rt","ruby","s","samp","section","select","small","source","strike","strong","sub","summary","sup","table","tbody","td","textarea","tfoot","th","thead","time","tr","track","tt","u","ul","var","wbr"]
			@classes 				= Array.new
			@ids 					= Array.new
			@html_without_skeleton 	= html.gsub(/<style>(.*?)\n\t\t<\/style>|<style>(.*?)<\/style>|<html>|<\/html>|<head>|<\/head>|<body>|<\/body>|<script>|<\/script>/,"")
			@doc 					= Nokogiri::HTML::DocumentFragment.parse(html)
			@doc_to 				= Nokogiri::HTML::DocumentFragment.parse(@html_without_skeleton)
			self.get_all_class_and_ids
			self.add_style_tag_to_html(@doc_to)
			self.inline_css_from_style_tag(@doc)
			return @doc_to.to_html
		end

	end
end