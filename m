Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3769B14D106
	for <lists+linux-api@lfdr.de>; Wed, 29 Jan 2020 20:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbgA2TLK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 29 Jan 2020 14:11:10 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34973 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgA2TLK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 29 Jan 2020 14:11:10 -0500
Received: by mail-wr1-f66.google.com with SMTP id g17so838772wro.2;
        Wed, 29 Jan 2020 11:11:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SIceE1wI3YF4e1poItQ4Q7P/TSmlkSI5vcj8MyFkpaU=;
        b=b3WgRog17qa4kipVgIQLPjDbcquayHRfSTNfbeZKJCB8otYdfA2G8v0CB7p9+RLVrz
         UbiyWJxMD6tHhSw84AKg1Tc4lJIqBTB8zJmjXZfI8WVJL1R4k9bKrXRrTuROtcYeZ38g
         GNhq1F57sUFajs9hccAtpJP3fqOxlT+SzMCjosqkHjYPNlnJC24Ft8x29ZMW7IRNlWAH
         QlTjrWVQOn/8m+Tv26Tj8kOQdmzHSBfv4ToHgf9oXeYvNpEBGam0zl/V4o/Ywdjg8IXf
         uy80TmmMMs6Pvp24fc8q5qCf1Sbvcpb2LecP2qSDVMGn5vkZeeSSRTcx92GOXNnaAGkR
         ex8w==
X-Gm-Message-State: APjAAAXiO9KKX66DjmMfXcA+yBRNSUDqj/oX+OAJwdamD10kgS9tKi+8
        f67WJOASXnDVl2n3Vanj/jA=
X-Google-Smtp-Source: APXvYqy97iIBhkWlXIbBgOCQgTV5ITJ1SJOSPHmwFOOc/feGNmfKEj40R8RLUM6K2oZlWyuUrXs57Q==
X-Received: by 2002:adf:f411:: with SMTP id g17mr291305wro.89.1580325067778;
        Wed, 29 Jan 2020 11:11:07 -0800 (PST)
Received: from localhost (ip-37-188-238-177.eurotel.cz. [37.188.238.177])
        by smtp.gmail.com with ESMTPSA id x17sm3886869wrt.74.2020.01.29.11.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 11:11:07 -0800 (PST)
Date:   Wed, 29 Jan 2020 20:11:05 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mtk.manpages@gmail.com, akpm@linux-foundation.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] move_pages.2: Returning positive value is a new error
 case
Message-ID: <20200129191105.GQ24244@dhcp22.suse.cz>
References: <1580322632-93332-1-git-send-email-yang.shi@linux.alibaba.com>
 <20200129185842.GP24244@dhcp22.suse.cz>
 <0db6a002-d067-8acd-65ee-8c87a32ff769@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0db6a002-d067-8acd-65ee-8c87a32ff769@linux.alibaba.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed 29-01-20 11:05:11, Yang Shi wrote:
> 
> 
> On 1/29/20 10:58 AM, Michal Hocko wrote:
> > On Thu 30-01-20 02:30:32, Yang Shi wrote:
> > > Since commit a49bd4d71637 ("mm, numa: rework do_pages_move"),
> > > the semantic of move_pages() has changed to return the number of
> > > non-migrated pages if they were result of a non-fatal reasons (usually a
> > > busy page).  This was an unintentional change that hasn't been noticed
> > > except for LTP tests which checked for the documented behavior.
> > > 
> > > There are two ways to go around this change.  We can even get back to the
> > > original behavior and return -EAGAIN whenever migrate_pages is not able
> > > to migrate pages due to non-fatal reasons.  Another option would be to
> > > simply continue with the changed semantic and extend move_pages
> > > documentation to clarify that -errno is returned on an invalid input or
> > > when migration simply cannot succeed (e.g. -ENOMEM, -EBUSY) or the
> > > number of pages that couldn't have been migrated due to ephemeral
> > > reasons (e.g. page is pinned or locked for other reasons).
> > > 
> > > We decided to keep the second option in kernel because this behavior is in
> > > place for some time without anybody complaining and possibly new users
> > > depending on it.  Also it allows to have a slightly easier error handling
> > > as the caller knows that it is worth to retry when err > 0.
> > > 
> > > Update man pages to reflect the new semantic.
> > Thanks a lot! Looks good to me. I would just add a note that it is
> > generally recommended to pre-initialize status array by -1 to have a
> > reliable way to check which pages have been migrated. The man page says
> > "The array contains valid values only if move_pages() did not return an
> > error."
> > 
> > I would just add. "Pre initialization of the array to -1 or similar
> > value which cannot represent a real numa node could help to identify
> > pages that have been migrated".
> 
> Sure. Adding this note right after the explanation of positive value error
> seems fine?

I would just follow up on the existing note about valid values.

-- 
Michal Hocko
SUSE Labs
