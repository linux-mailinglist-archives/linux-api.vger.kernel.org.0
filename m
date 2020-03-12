Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1538C183A86
	for <lists+linux-api@lfdr.de>; Thu, 12 Mar 2020 21:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgCLUXn (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 12 Mar 2020 16:23:43 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:36402 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgCLUXm (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 12 Mar 2020 16:23:42 -0400
Received: by mail-pj1-f65.google.com with SMTP id l41so3121197pjb.1;
        Thu, 12 Mar 2020 13:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E48tDkZx/8j+Ju5P8a7Hgys5ARHNcg71wMnlvvHjODQ=;
        b=uHQkP5ZYmW2TWq+I/J0FK+bJgD+cfoL9CWjoXUTPJWUbEFmEn0h6lO4cHmDaf1qhOo
         2PI0epZ4LwmiF2rffZXulhUT4LkIHxSSYzhhNWUc+hpluTp/nZ7hXMV3+hRv0clx24+Q
         QplHZeHr/unYjngauEgMJ5xqSoSCudiNDBcOsacdYIptVpwaww7rXA6jXldbWLKnfEJh
         weR/DI+v7Rq9dJ9ESGWe0vjLLCZhsjXS4eq2odTI4NB+1PFBClj/5JOOIlyx37WuZHWD
         WdZG6jUmlH6j1GW5PdaeoElUo1oZEL15dkV6psfnXPjCGCHGFY+sQJ8fVwacyem2dzMY
         zLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=E48tDkZx/8j+Ju5P8a7Hgys5ARHNcg71wMnlvvHjODQ=;
        b=hwkPtYwDh0nEcPM0RjuSY8K564O8JhwK9+Udarxb7RuIhcrwrAn9UU/1eynQXKq7wH
         740W6KGwZDxakTByYeVTnKM/vsZWArtZQPBjqnbgiE3e//391EfMkHWVieeWsjGP7AEL
         /nh1qlgjlBcxU7/SEg2B9x3EsNx81rAxa1NnabDJREnSthwisvkRZ8gSrJwHVID3jxzm
         55PG1cijpI7uKF7amkW44xDAy74wWMdukcCvaSUCitVOieYMjOHlz24Q48dPC1I4YeHt
         Da7dg7QYqlrudBFBGKPLdvFdN2m/l6kXx4z7oieKCyKVkTAf33IL5YH6OV/LtqkbnQuT
         Bacg==
X-Gm-Message-State: ANhLgQ0KVg53CrIKXVyHkeqOn36pRFtdIMK9arToHPV/hsGFkoTezFbO
        qqQqWKLsGc4NI9f7p9dz+WSB1WNm
X-Google-Smtp-Source: ADFU+vtfHouS/icEFZlgwFly1nG+Y9MAhxq009zIbS2uW0Cb2Uz9i1mtCzAK4DHsvIMnFvMmjPeKhg==
X-Received: by 2002:a17:902:bc4c:: with SMTP id t12mr9032471plz.54.1584044621809;
        Thu, 12 Mar 2020 13:23:41 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id z17sm7602271pff.12.2020.03.12.13.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 13:23:40 -0700 (PDT)
Date:   Thu, 12 Mar 2020 13:23:39 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        oleksandr@redhat.com, Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>,
        alexander.h.duyck@linux.intel.com, sj38.park@gmail.com
Subject: Re: [PATCH v7 2/7] mm: introduce external memory hinting API
Message-ID: <20200312202339.GB68817@google.com>
References: <20200302193630.68771-1-minchan@kernel.org>
 <20200302193630.68771-3-minchan@kernel.org>
 <bc3f6bd5-f032-bcf5-a09f-556ab785c587@suse.cz>
 <20200310222008.GB72963@google.com>
 <07109fb3-dcf3-0252-4515-7e476fadc259@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07109fb3-dcf3-0252-4515-7e476fadc259@suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Mar 12, 2020 at 01:40:26PM +0100, Vlastimil Babka wrote:
> On 3/10/20 11:20 PM, Minchan Kim wrote:
> > On Thu, Mar 05, 2020 at 07:15:10PM +0100, Vlastimil Babka wrote:
> >> On 3/2/20 8:36 PM, Minchan Kim wrote:
> >> > There is usecase that System Management Software(SMS) want to give
> >> > a memory hint like MADV_[COLD|PAGEEOUT] to other processes and
> >> > in the case of Android, it is the ActivityManagerService.
> >> > 
> >> > It's similar in spirit to madvise(MADV_WONTNEED), but the information
> >> 
> >> You mean MADV_DONTNEED?
> > 
> > Mean to DONT_NEED's future version.
> 
> What's that exactly?

For zapping timing point of view, dontneed acts immediately so it's very
strong hint. However, MADV_COLD and MADV_PAGEOUT does lazily depending
on the future. For example, the page never discarded if it's touched
before the tail of LRU. If other process which shared the page has
touched the page, never paging out.

> 
> >> 
> >> > required to make the reclaim decision is not known to the app.
> >> 
> >> This seems to be mixing up the differences between MADV_DONTNEED and
> >> COLD/PAGEOUT and self-imposed vs external memory hints?
> > 
> > Sorry, I don't understand what you want here.
> 
> You say that process_madvise(MADV_[COLD|PAGEEOUT]) is similar to
> madvise(MADV_WONTNEED) but the difference is that the information
> required to make the reclaim decision is not known to the app.
> 
> I see two differences. One is madvise vs process_madvise, which is explained by
> "reclaim decision is not known to the app."
> The other is MADV_WONTNEED vs MADV_[COLD|PAGEEOUT], which is... I'm not sure
> until you say what's "DONT_NEED's future version" :D
> 
> Anyway I assume this part is from the versions where the new COLD and PAGEOUT
> flags were introduced together with external memory hinting API?

Exactly. Maybe it would be better to remove the part once we merged the
COLD and PAGEOUT now.

Thanks for the review, Vlastimil!
