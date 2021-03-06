local UiView = require 'UIKit.UIView'
local CgAffineTransform = require "CoreGraphics.CGAffineTransform"
local NsString = require "Foundation.NSString"

local NSRange = struct.NSRange
local CGRect = struct.CGRect

local ViewController = class.extendClass (objc.ViewController)

function ViewController:viewDidLoad ()
    self[ViewController.superclass]:viewDidLoad()
    self:createTextSystem()
end

function ViewController:promoteAsLuaObject()
    if self.isViewLoaded then
        self:createTextSystem()
    end
end

function ViewController:createTextSystem ()

    -- create the text storage
    local textFileUrl = objc.NSBundle.mainBundle:URLForResource_withExtension ("ConspirationMilliardaires", "rtf")
    local textStorage = objc.NSTextStorage:new()
    textStorage.attributedString = objc.NSAttributedString:newWithFileURL_options_documentAttributes_error(textFileUrl, {}, nil, nil)
    self.textStorage = textStorage
    
    -- create the layout manager
    local layoutManager = objc.NSLayoutManager:new()
    textStorage:addLayoutManager(layoutManager)
    self.layoutManager = layoutManager
    
    -- create the text container and view for the first column
    self:updateTextSystem()
    
    self:addMessageHandler ("system.did_load_module", "refresh")
end

function ViewController:updateTextSystem ()
    
    if self.textViewColumn1 == nil then
        local column1Bounds = self.column1View.bounds
        local textContainer = objc.NSTextContainer:newWithSize (column1Bounds.size)
        self.layoutManager:addTextContainer(textContainer)
        
        local column1TextView = objc.UITextView:newWithFrame_textContainer(column1Bounds, textContainer)
        column1TextView.backgroundColor = objc.UIColor.whiteColor
        column1TextView.autoresizingMask = UiView.Autoresizing.FlexibleWidth + UiView.Autoresizing.FlexibleHeight
        column1TextView.translatesAutoresizingMaskIntoConstraints = true
        
        self.column1View:addSubview(column1TextView)
        self.textViewColumn1 = column1TextView
    end
    
    self.textViewColumn1.scrollEnabled = false
    
    if self.textViewColumn2 == nil then
        local column2Bounds = self.column2View.bounds
        local textContainer = objc.NSTextContainer:newWithSize (column2Bounds.size)
        self.layoutManager:addTextContainer(textContainer)
        
        local column2TextView = objc.UITextView:newWithFrame_textContainer(column2Bounds, textContainer)
        column2TextView.backgroundColor = objc.UIColor.whiteColor
        column2TextView.autoresizingMask = UiView.Autoresizing.FlexibleWidth + UiView.Autoresizing.FlexibleHeight
        column2TextView.translatesAutoresizingMaskIntoConstraints = true
        
        self.column2View:addSubview(column2TextView)
        self.textViewColumn2 = column2TextView
    end
    
    self.textViewColumn2.scrollEnabled = false
    
    -- Create a shape view used as exclusion path
    if self.panImageView == nil then
        local PathImageView = objc.PathImageView --[[@inherits UIView]]
        
        local viewBounds = self.view.bounds
        local panImageSize = struct.CGSize(300, 400)
        local panImageFrame = CGRect(viewBounds:getMidX() - panImageSize.width / 2, viewBounds:getMidY() - panImageSize.height / 2,
                                     panImageSize.width, panImageSize.height)
        local panImagePath = objc.UIBezierPath:bezierPathWithOvalInRect(CGRect(0, 0, panImageSize.width, panImageSize.height))
        local panImage = objc.UIImage:imageNamed "Chrysler_Building.jpg"
        
        self.panImageView = PathImageView:newWithFrame_shape_image(panImageFrame, panImagePath)
        self.view:addSubview(self.panImageView)
        self.panImageView:addGestureRecognizer(objc.UIPanGestureRecognizer:newWithTarget_action(self, 'panShapeImage'))
    end
    
    if self.textAttachement == nil then
        -- create the attachement
        local textAttachement = objc.NSTextAttachment:new()
        textAttachement.image = objc.UIImage:imageNamed "Rockefeller.png"
        textAttachement.bounds = { x = 0, y = 0, width = 120, height = 150}
        
        self.textAttachement = textAttachement
        self.attachementString = objc.NSAttributedString:attributedStringWithAttachment(textAttachement)
        
        -- calculate the insert location (after 5th paragraph)
        local paragraphIndex = 0
        local insertLocation = -1
        self.textStorage.string:enumerateSubstringsInRange_options_usingBlock(NSRange(0, self.textStorage.length),
                                                                              NsString.Enumeration.ByParagraphs,
                                                                              function (substring, range, enclosingRange)
                                                                                  paragraphIndex = paragraphIndex + 1
                                                                                  if paragraphIndex == 5 then
                                                                                      insertLocation = enclosingRange:maxLocation()
                                                                                      return true
                                                                                  end
                                                                              end)
        
        if insertLocation ~= -1 then
            self.textStorage:insertAttributedString_atIndex(self.attachementString, insertLocation)
        end
    end
    
    -- Try to uncomment the lines below and see how the shape changes
    -- self.panImageView.viewShape = objc.UIBezierPath:bezierPathWithOvalInRect(CGRect(0, 0, 300, 500))
    -- self.panImageView.viewShape = objc.UIBezierPath:bezierPathWithRoundedRect_cornerRadius(CGRect(0, 0, 320, 500), 100.0)
    
    getResource("Chrysler_Building", "public.image", self.panImageView, "viewImage")
    
    self.textAttachement.bounds = CGRect(0, 0, 95, 105)
    
    self:updateExclusionPaths()
end

function ViewController:setExclusionPathForPathImageViewInTextView (pathImageView, textView)
    -- Translate the path of pathImageView into the text view coordinate system
    local exclusionPath = pathImageView.viewShape:copy()
    local pathOrigin = textView:convertPoint_fromView (pathImageView.bounds.origin, pathImageView)
    local textContainerEdgeInset = textView.textContainerInset
    
    exclusionPath:applyTransform (CgAffineTransform.MakeTranslation (pathOrigin.x - textContainerEdgeInset.left, 
                                                                     pathOrigin.y - textContainerEdgeInset.top))
    textView.textContainer.exclusionPaths = { exclusionPath }
end

function ViewController:updateExclusionPaths ()
    self:setExclusionPathForPathImageViewInTextView (self.panImageView, self.textViewColumn1)
    self:setExclusionPathForPathImageViewInTextView (self.panImageView, self.textViewColumn2)
end

function ViewController:refresh()
    self:updateTextSystem()
end

return ViewController
