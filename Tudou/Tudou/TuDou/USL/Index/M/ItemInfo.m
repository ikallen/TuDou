//
//  ItemInfo.m
//  TuDou
//
//  Created by Kallen on 13-5-21.
//  Copyright (c) 2013年 Kallen. All rights reserved.
//

#import "ItemInfo.h"

@implementation ItemInfo

@synthesize kID=_kID;
@synthesize itemId = _itemId;
@synthesize itemCode =_itemCode;
@synthesize vcode = _vcode;
@synthesize title = _title;
@synthesize tags = _tags;
@synthesize Description = _Description;
@synthesize picUrl = _picUrl;
@synthesize picChoiceUrl = _picChoiceUrl;
@synthesize totalTime = _totalTime;
@synthesize pubDate = _pubDate;
@synthesize ownerId = _ownerId;
@synthesize ownerName = _ownerName;
@synthesize ownerNickname = _ownerNickname;
@synthesize ownerPic = _ownerPic;
@synthesize ownerURL = _ownerURL;
@synthesize channelId=_channelId;
@synthesize outerPlayerUrl = _outerPlayerUrl;
@synthesize itemUrl = _itemUrl;
@synthesize mediaType = _mediaType;
@synthesize secret = _secret;
@synthesize definition = _definition;
@synthesize hdType = _hdType;
@synthesize playTimes = _playTimes;
@synthesize commentCount = _commentCount;
@synthesize bigPicUrl = _bigPicUrl;
@synthesize addPlaylistTime = _addPlaylistTime;
@synthesize alias = _alias;
@synthesize downEnable = _downEnable;
@synthesize favorall = _favorall;
@synthesize location = _location;
@synthesize html5Url = _html5Url;



-(void)dealloc
{
    [_kID release];
    [_itemId release];
    [_itemCode release];
    [_vcode release];
    [_title release];
    [_tags release];
    [_Description release];
    [_picUrl release];
    [_picChoiceUrl release];
    [_totalTime release];
    [_pubDate release];
    [_ownerId release];
    [_ownerName release];
    [_ownerNickname release];
    [_ownerPic release];
    [_ownerURL release];
    [_channelId release];
    [_outerPlayerUrl release];
    [_itemUrl release];
    [_mediaType release];
    [_secret release];
    [_definition release];
    [_hdType release];
    [_playTimes release];
    [_commentCount release];
    [_bigPicUrl release];
    [_addPlaylistTime release];
    [_alias release];
    [_downEnable release];
    [_favorall release];
    [_location release];
    [_html5Url release];
    
    [super dealloc];
}

@end
