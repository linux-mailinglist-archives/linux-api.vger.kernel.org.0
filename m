Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E609711A08C
	for <lists+linux-api@lfdr.de>; Wed, 11 Dec 2019 02:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfLKBfI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 10 Dec 2019 20:35:08 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37630 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfLKBfI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 10 Dec 2019 20:35:08 -0500
Received: by mail-pg1-f193.google.com with SMTP id q127so9919849pga.4;
        Tue, 10 Dec 2019 17:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nlpVsvSziMS3fJYT4hfZDu09k+DIOzs8q7E2mV4QBMM=;
        b=NZ2e7jQCO0XsxakoDSNlRS7AaNAmbyiX3s5WJ40a1LAVqE5SND78+yIGfSgRF+1r69
         JCVloXc80IJMn4iRUVSea15czBfXyV20oIcoyoCL3gTWtpsoxyNpHJkCM48fix5mPo1a
         z7tED3IWm6VXN1dlEGZS2MBXUpHkDus3l2NPss/ayDe6vrMyRiQ91LXW/KjnBDx3OkZy
         EhrB2lYQs/8yNp+G+b1kqlYN1trh0Y2N1sf+e4FSyqtQv5AAR3VRaq0mOqbmqND4tzXp
         8lF3Tcp4wSBrrIl2kcOW2Aj5wfDPcHh0O2ZcHUxfYUumTUfEW3+qotevs9UYYTqOc3as
         SdNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=nlpVsvSziMS3fJYT4hfZDu09k+DIOzs8q7E2mV4QBMM=;
        b=TuwIbOtsImC4+OXg8yIvR9pDaFXoqOFWtVKtAfE4YZh364qnabvdfW9pbFj1I7wnu/
         tLv6Efs5ydAOUMQoA2h+7o0tdxHoe0lqwGmcQySSk1+oJhElPZRPmiZvHt7B5hGzttIu
         2z86RLUxILnQD446C1iiYK5pyWeUKuFpyFGh40Y9J36ZD0U/I7t5vDmQL83pQV0aK7XY
         PYR0smeAqJU55RIEPiw/m5eQy8B3pQCe6AmaxRveIRAzofw5KQ6YytZ2D6nTZo09q8sM
         fnRIW0O8OPp6Cd1ShFaLawH4XvLK5D3Omzx+gXg6toMAcJBD8jM2CKzyDbIKTDgWGtfz
         Oa9Q==
X-Gm-Message-State: APjAAAXEf3gD5O9XGcTJO1xl3bLjNowrYZ/Ohy5pXxMbL2y43viml9MI
        Vrxp8cBVQDHsSuOcGWdxzi5UQFBS
X-Google-Smtp-Source: APXvYqxl1SD/KNXFXo4mnS2r4hl5LczS1cUtUXkz/1uWGAoK8RJYFaUqsy3vxsCeZu73IPqU0JxyOQ==
X-Received: by 2002:a63:2ac2:: with SMTP id q185mr1222079pgq.417.1576028106879;
        Tue, 10 Dec 2019 17:35:06 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id v16sm297845pfn.77.2019.12.10.17.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 17:35:05 -0800 (PST)
Date:   Tue, 10 Dec 2019 17:35:03 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH NOTFORMERGE 0/5] Extend remote madvise API to KSM hints
Message-ID: <20191211013503.GA134194@google.com>
References: <20190616085835.953-1-oleksandr@redhat.com>
 <20191210104939.jauw5hnv3smhtvtr@butterfly.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210104939.jauw5hnv3smhtvtr@butterfly.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Oleksandr,

On Tue, Dec 10, 2019 at 11:49:39AM +0100, Oleksandr Natalenko wrote:
> Hello, Minchan.
> 
> On Sun, Jun 16, 2019 at 10:58:30AM +0200, Oleksandr Natalenko wrote:
> > This is a set of commits based on our discussion on your submission [1].
> > 
> > First 2 implement minor suggestions just for you to not forget to take
> > them into account.
> > 
> > uio.h inclusion was needed for me to be able to compile your series
> > successfully. Also please note I had to enable "Transparent Hugepage
> > Support" as well as "Enable idle page tracking" options, otherwise the
> > build failed. I guess this can be addressed by you better since the
> > errors are introduced with MADV_COLD introduction.
> > 
> > Last 2 commits are the actual KSM hints enablement. The first one
> > implements additional check for the case where the mmap_sem is taken for
> > write, and the second one just allows KSM hints to be used by the remote
> > interface.
> > 
> > I'm not Cc'ing else anyone except two mailing lists to not distract
> > people unnecessarily. If you are fine with this addition, please use it
> > for your next iteration of process_madvise(), and then you'll Cc all the
> > people needed.
> > 
> > Thanks.
> > 
> > [1] https://lore.kernel.org/lkml/20190531064313.193437-1-minchan@kernel.org/
> > 
> > Oleksandr Natalenko (5):
> >   mm: rename madvise_core to madvise_common
> >   mm: revert madvise_inject_error line split
> >   mm: include uio.h to madvise.c
> >   mm/madvise: employ mmget_still_valid for write lock
> >   mm/madvise: allow KSM hints for remote API
> > 
> >  mm/madvise.c | 23 ++++++++++++++---------
> >  1 file changed, 14 insertions(+), 9 deletions(-)
> > 
> > -- 
> > 2.22.0
> > 
> 
> This is a gentle ping. Are you still planning to submit process_madvise() solution?

I'm really sorry for being slow progress.
I am stuck with internal stuff of company.
I will do best effort to send it within one or two weeks.

Thanks.
