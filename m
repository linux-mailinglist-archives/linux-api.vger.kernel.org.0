Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E54618A683
	for <lists+linux-api@lfdr.de>; Wed, 18 Mar 2020 22:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgCRVIq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 18 Mar 2020 17:08:46 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42748 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbgCRVIp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 18 Mar 2020 17:08:45 -0400
Received: by mail-ed1-f68.google.com with SMTP id b21so22311174edy.9
        for <linux-api@vger.kernel.org>; Wed, 18 Mar 2020 14:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WatAKLuqZtZlRLQCbRzYpTXRz9maWKDE4hUEG0f7NDw=;
        b=KblwfDmtszqt/poiiBnkGj80+eqtrRyKNLWAFKJyI2lM8X5PpTIHIUIc65zJhoEnEF
         WjcKc+bfilJdpRhIjI1m71RTPdnfUYwaMNgrlZfogSYuI3TKBJzAzVhAyAtHoPrdVKGp
         DLDa+hQ2FiF/ZRAW6YOkmNlRuau5tixJsAn5jRDu0LNFpGvf4mGlYW9x2j+4ybOULNy7
         eW1S/z/G2JKD/YF0c0IywP5jL7tjCmAMSfYHwjw2Mgd+8lo0HY2apy//ZlP3q1BuFweg
         kxv1DBMAmhdBV9qGqhU7t4qHJxKuYe+4PrnuMPBj6LktzBpmvLYwxL6iqDAV7QAmJ5iL
         I9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WatAKLuqZtZlRLQCbRzYpTXRz9maWKDE4hUEG0f7NDw=;
        b=YBP7wjFBsgkH0lT5zKOj+I64tZ7kwJPzpbTLjcPlBzNJCghGp53PAFIHyV3PYBNgjy
         SMeH/tgS8Xh4OB4g1PJ5PUyIPVxhocK+OGGpQ5kurMBvHtdBZEH9pY+9eUgEhEQHVcjW
         A4ujsMcAPu8F4qxNksJqmFr4vZrJRpr0kLdByM1/+iqgyIHoWPtcIY94adRZ6Ug6kcID
         MuYh8t0IZPWm/pm4vbwFZKYYFoCL/jKC9HzpOHSvZCPY3pBh3LhVzh5s+lYUqqxPZPgL
         rF7fczmGQo6M6HKme8zjuf5gAYTeX91PYMMtIWkldM182gPeCIiXR5Gx+vxr1S4zAtOy
         y0fA==
X-Gm-Message-State: ANhLgQ05/r8DgVp3LoNf4y7KJwSpTIrYu9q6VVDtznaS8IJD0FPaM+MS
        y0W84Uk3XdrNv8QyvxOhK3zQrpI50vBJRuufdLFy
X-Google-Smtp-Source: ADFU+vvbYGHqEIZHFDpAJYIn0BKyhX1aU7rGbDTvr2tbcPYmEgbd2Lwck7tUApGNIqLuzMQYQdyQBqa6eqOf1oPvVLM=
X-Received: by 2002:aa7:d051:: with SMTP id n17mr5727973edo.196.1584565722903;
 Wed, 18 Mar 2020 14:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1577736799.git.rgb@redhat.com> <6452955c1e038227a5cd169f689f3fd3db27513f.1577736799.git.rgb@redhat.com>
 <CAHC9VhRkH=YEjAY6dJJHSp934grHnf=O4RiqLu3U8DzdVQOZkg@mail.gmail.com>
 <20200130192753.n7jjrshbhrczjzoe@madcap2.tricolour.ca> <CAHC9VhSVN3mNb5enhLR1hY+ekiAyiYWbehrwd_zN7kz13dF=1w@mail.gmail.com>
 <20200205235056.e5365xtgz7rbese2@madcap2.tricolour.ca> <CAHC9VhTM6MDHLcBfwJ_9DCroG0VA-meO770ihjn1sVy6=0JrHw@mail.gmail.com>
 <20200312205147.plxs4czjeuu4davj@madcap2.tricolour.ca> <CAHC9VhTqWdXMsbSbsWJzRRvVbSaaFBmnFFsVutM7XSx5NT_FJA@mail.gmail.com>
 <20200314224203.ncyx3rgwwe6zet4e@madcap2.tricolour.ca>
In-Reply-To: <20200314224203.ncyx3rgwwe6zet4e@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 18 Mar 2020 17:08:31 -0400
Message-ID: <CAHC9VhTy2ou-vadeMjgTaw-T9mW+nBjbqapA7RSW3EFNJ44JLw@mail.gmail.com>
Subject: Re: [PATCH ghak90 V8 13/16] audit: track container nesting
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     nhorman@tuxdriver.com, linux-api@vger.kernel.org,
        containers@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, dhowells@redhat.com,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        netfilter-devel@vger.kernel.org, ebiederm@xmission.com,
        simo@redhat.com, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        mpatel@redhat.com, Serge Hallyn <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Mar 14, 2020 at 6:42 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2020-03-13 12:47, Paul Moore wrote:

...

> > It has been a while since I last looked at the patchset, but my
> > concern over the prefered use of the ACID number vs the ACID object is
> > that the number offers no reuse protection where the object does.  I
> > really would like us to use the object everywhere it is possible.
>
> Ok, so I take it from this that I go ahead with the dual format since
> the wrapper funciton to convert from object to ID strips away object
> information negating any benefit of favouring the object pointer.  I'll
> look at the remaining calls that use a contid (rather than contobj) and
> convert all that I can over to storing an object using the dual counters
> that track process exits versus signal2 and trace references.

Well, as I said in the other thread, I'm not sure we need a full two
counters; I think one counter and a simple flag should suffice.
Otherwise that sounds good for the next iteration.

-- 
paul moore
www.paul-moore.com
