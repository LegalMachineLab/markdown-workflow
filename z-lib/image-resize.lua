function Image(el)
  -- set dimensions and caption (if empty)
  local width = el.attributes.width:gsub("in", "")
  if tonumber(width) > 4 then
      el.attributes.width = "75%"
  end
  el.attributes.height = nil
  print(el.caption)
  print(el.title)
  if not el.caption or #el.caption == 0 then
    el.caption = { pandoc.Str("&#8203;") }
  end
  return el
end