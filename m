Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1407285497
	for <lists+linux-api@lfdr.de>; Wed,  7 Aug 2019 22:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388359AbfHGUox (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 7 Aug 2019 16:44:53 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38332 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730097AbfHGUox (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 7 Aug 2019 16:44:53 -0400
Received: by mail-pl1-f196.google.com with SMTP id m12so3906815plt.5
        for <linux-api@vger.kernel.org>; Wed, 07 Aug 2019 13:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=itaaHUuDhcUmWvWTJL4zW8mOnytMPij6pAOeeM3m1Hg=;
        b=cvR0USsq4TrVGI/7AHhxTvBLliSSP311yfq2eMIv0HZPy5zvZSgUkA9hOQuqwUwOmK
         tW59Vs41S3Z4cN2lbD7CBiabk1kuZyNcNbwelUz8x6sT4Q/qw4los5KJ1TsmL/bCkQ6a
         NbDSeg5PosKj8KNSTPFRKtihsP13TwsNRRQSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=itaaHUuDhcUmWvWTJL4zW8mOnytMPij6pAOeeM3m1Hg=;
        b=hFKV/ZM4ADxOmOqif6yg/KugriBN5olKCLLfY58littd+JTYBbDfVJ+PJvoA5PVooC
         C/P6lgtdG4+9UUeZUtmpUqu3867+vJiJxTeRVbu/fSnL6SZj1yRfCB47TuLXGJ0poXV+
         IHe9wxq/FCfjxbzWQ8xBzVrBpBo/CNeMxsxdacihpMjhZCZUgPvEikzS2hVsmeHPpnH5
         lk6XJJmY3Ehy+ByP+SyJm4AhpDTesx2QPjj9kTRueP3EEcvrZW81UvIrvujIILmL0aOe
         xnJWm/sGcITUx4W/rfHxaWS9LtsIGcaZSxIDqL0A5X9HdscL3ffrbgNarDVhTv+hgviK
         1Zyg==
X-Gm-Message-State: APjAAAUjwV949LoGpsR/aJxbUOX/S0q+7G+x1GxwjckqcGhuQV29C945
        6yQ6S041POWNr7BrXxHiq4kxew==
X-Google-Smtp-Source: APXvYqzxGRsJN8tg0/I87Pfq2FlyH6V5p4w6lM9eq6TQXsCKYWlpRWdYAkMSEIlSnT6YRM40KG3l1w==
X-Received: by 2002:a17:90a:bb8a:: with SMTP id v10mr319911pjr.78.1565210692050;
        Wed, 07 Aug 2019 13:44:52 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id j1sm126143263pgl.12.2019.08.07.13.44.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 13:44:51 -0700 (PDT)
Date:   Wed, 7 Aug 2019 16:44:49 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Brendan Gregg <bgregg@netflix.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Hansen <chansen3@cisco.com>, dancol@google.com,
        fmayer@google.com, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>, minchan@kernel.org,
        namhyung@google.com, paulmck@linux.ibm.com,
        Robin Murphy <robin.murphy@arm.com>,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, surenb@google.com,
        Thomas Gleixner <tglx@linutronix.de>, tkjos@google.com,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Re: [PATCH v4 1/5] mm/page_idle: Add per-pid idle page tracking
 using virtual indexing
Message-ID: <20190807204449.GA90900@google.com>
References: <20190805170451.26009-1-joel@joelfernandes.org>
 <20190806151921.edec128271caccb5214fc1bd@linux-foundation.org>
 <20190807100013.GC169551@google.com>
 <20190807130122.f148548c05ec07e7b716457e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807130122.f148548c05ec07e7b716457e@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Aug 07, 2019 at 01:01:22PM -0700, Andrew Morton wrote:
> On Wed, 7 Aug 2019 06:00:13 -0400 Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > > > 8 files changed, 376 insertions(+), 45 deletions(-)
> > > 
> > > Quite a lot of new code unconditionally added to major architectures. 
> > > Are we confident that everyone will want this feature?
> > 
> > I did not follow, could you clarify more? All of this diff stat is not to
> > architecture code:
> 
> 
> My point is that the patchset adds a lot of new code with no way in
> which users can opt out.  Almost everyone gets a fatter kernel - how
> many of those users will actually benefit from it?
> 
> If "not many" then shouldn't we be making it Kconfigurable?

Almost all of this code is already configurable with
CONFIG_IDLE_PAGE_TRACKING. If you disable it, then all of this code gets
disabled.

Or are you referring to something else that needs to be made configurable?

> Are there userspace tools which present this info to users or which
> provide monitoring of some form?  Do major distros ship those tools? 
> Do people use them?  etcetera.
> 

Android's heapprofd is what I was working on which is already using it (patch
is not yet upstreamed). There is working set tracking which Sandeep (also
from Android) said he wants to use. Minchan plans to use this in combination
with ZRAM-based idle tracking. Mike Rappoport also showed some interest, but
I am not sure where/how he is using it. These are just some of the usecases I
am aware off. I am pretty sure more will come as well.

thanks,

 - Joel

