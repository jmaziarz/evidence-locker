# Additional lambdas for the Paperclip interpolation hash

## Local

Paperclip::Attachment.interpolations[:identifier] = lambda do |attachment, style|
  "#{attachment.instance.identifier}"
end

## Transformation

Paperclip::Attachment.interpolations[:item_identifier] = lambda do |attachment, style|
  "#{attachment.instance.item.identifier}"
end

Paperclip::Attachment.interpolations[:index] = lambda do |attachment, style|
  "#{attachment.instance.item.transformations.size}"
end

Paperclip::Attachment.interpolations[:item_id] = lambda do |attachment, style|
  "#{attachment.instance.item.id}"
end

