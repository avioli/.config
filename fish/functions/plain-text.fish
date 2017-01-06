function plain-text
	pbpaste | textutil -convert txt -stdin -stdout -encoding 30 | pbcopy
end
