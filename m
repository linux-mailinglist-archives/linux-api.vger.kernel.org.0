Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632022B54E8
	for <lists+linux-api@lfdr.de>; Tue, 17 Nov 2020 00:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbgKPXYk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 16 Nov 2020 18:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727098AbgKPXYk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 16 Nov 2020 18:24:40 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3C3C0613CF;
        Mon, 16 Nov 2020 15:24:40 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id q10so15670976pfn.0;
        Mon, 16 Nov 2020 15:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9gHW/b2b9IVZCe8TQB/5bFXeA9E/gEGYf6Ex+dE1xsM=;
        b=Du7zG1zkT8cXy4aIUBIS0820a1I4oY4AepXtnqY9BwQROuLpFqc2G0WXju9pYjEd5o
         8yLw2EBPiw2bvTHtnEwbiM2asA+S1zbJtbxIRvvSMp3/iHyQfnCFtmRMhcspPTLNF4Iq
         RN2iFkXw8qfTzsfNCdKjOsHi4ZlCX+Iu2bJEO9BrIaxIbhm6mRPBcva4tamRkKThO+xX
         ui0VT56lAA/6z3DRpGr6wFOMnzKEUSHdSVWnYQwctuHP9M79dtfavDkO+gXk8r0E5Onb
         U3l0QD+H/Mgt/6t36gOX5RipWIj5E6CiguISxim27EchNuFD/qDlzP0SRv9KgrHXTk4J
         l2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=9gHW/b2b9IVZCe8TQB/5bFXeA9E/gEGYf6Ex+dE1xsM=;
        b=AZi6Bfie2AZXJNyiWyZvfirknnQ3EiZLlo27WMyoAuQK47xNyUc/ny4jOY/YcyWu1w
         zyePAJR3d8ZgVd4eaZiso8IJtnHJio5/BNgEoTTHpCJZwAnElawV6DFlHgyzkmsYXvYU
         DRTlRy4UIkMJSKVT0AbGiOeg1CsxHu/Lq4nl2iB079ua04j7v8RgK3rdlU2/kcDv0P1W
         hioh3/27G+RPwhwbNKq3vkBaSte89EhzCuFi677k5vMS6d/ro+7Kpb/2zaL+kUC58cz2
         /JF541NDf6btx4oqvnqzTm6wqAMmzjWsqXAt5d0ZQiL1q97rtsU9x52Ar8Pjo2J2KtYo
         wXTw==
X-Gm-Message-State: AOAM532Np14ZZd3keKAZmDPc2j7SnSHDIewXsgAZXTuUv9wyxPa3Ziwa
        kFc/SrCQTgFdoRsZDYWr0+0=
X-Google-Smtp-Source: ABdhPJw+CCN+2GPNi3R5/WE8CzIWOQd5JBJwok6cN7cwCTZI+Jyj+dy07C+eYUEo56lj67iDBxXo0w==
X-Received: by 2002:a17:90a:d495:: with SMTP id s21mr1413055pju.30.1605569079574;
        Mon, 16 Nov 2020 15:24:39 -0800 (PST)
Received: from google.com ([2620:15c:211:201:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id mt2sm556195pjb.7.2020.11.16.15.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 15:24:38 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 16 Nov 2020 15:24:36 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Murray <timmurray@google.com>, linux-api@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Subject: Re: [PATCH 1/1] RFC: add pidfd_send_signal flag to reclaim mm while
 killing a process
Message-ID: <20201116232436.GA3943731@google.com>
References: <20201113173448.1863419-1-surenb@google.com>
 <20201113155539.64e0af5b60ad3145b018ab0d@linux-foundation.org>
 <CAJuCfpGJkEUqUWmo_7ms66ZqwHfy+OGsEhzgph+a4QfOWQ32Yw@mail.gmail.com>
 <20201113170032.7aa56ea273c900f97e6ccbdc@linux-foundation.org>
 <CAJuCfpHS3hZi-E=JCp257u0AG+RoMAG4kLa3NQydONGfp9oXQQ@mail.gmail.com>
 <20201113171810.bebf66608b145cced85bf54c@linux-foundation.org>
 <CAJuCfpH-Qjm5uqfaUcfk0QV2zC76uL96FQjd88bZGBvCuXE_aA@mail.gmail.com>
 <20201113181632.6d98489465430a987c96568d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113181632.6d98489465430a987c96568d@linux-foundation.org>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Nov 13, 2020 at 06:16:32PM -0800, Andrew Morton wrote:
> On Fri, 13 Nov 2020 17:57:02 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
> 
> > On Fri, Nov 13, 2020 at 5:18 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > On Fri, 13 Nov 2020 17:09:37 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > > > > > Seems to me that the ability to reap another process's memory is a
> > > > > > > generally useful one, and that it should not be tied to delivering a
> > > > > > > signal in this fashion.
> > > > > > >
> > > > > > > And we do have the new process_madvise(MADV_PAGEOUT).  It may need a
> > > > > > > few changes and tweaks, but can't that be used to solve this problem?
> > > > > >
> > > > > > Thank you for the feedback, Andrew. process_madvise(MADV_DONTNEED) was
> > > > > > one of the options recently discussed in
> > > > > > https://lore.kernel.org/linux-api/CAJuCfpGz1kPM3G1gZH+09Z7aoWKg05QSAMMisJ7H5MdmRrRhNQ@mail.gmail.com
> > > > > > . The thread describes some of the issues with that approach but if we
> > > > > > limit it to processes with pending SIGKILL only then I think that
> > > > > > would be doable.
> > > > >
> > > > > Why would it be necessary to read /proc/pid/maps?  I'd have thought
> > > > > that a starting effort would be
> > > > >
> > > > >         madvise((void *)0, (void *)-1, MADV_PAGEOUT)
> > > > >
> > > > > (after translation into process_madvise() speak).  Which is equivalent
> > > > > to the proposed process_madvise(MADV_DONTNEED_MM)?
> > > >
> > > > Yep, this is very similar to option #3 in
> > > > https://lore.kernel.org/linux-api/CAJuCfpGz1kPM3G1gZH+09Z7aoWKg05QSAMMisJ7H5MdmRrRhNQ@mail.gmail.com
> > > > and I actually have a tested prototype for that.
> > >
> > > Why is the `vector=NULL' needed?  Can't `vector' point at a single iovec
> > > which spans the whole address range?
> > 
> > That would be the option #4 from the same discussion and the issues
> > noted there are "process_madvise return value can't handle such a
> > large number of bytes and there is MAX_RW_COUNT limit on max number of
> > bytes one process_madvise call can handle". In my prototype I have a
> > special handling for such "bulk operation" to work around the
> > MAX_RW_COUNT limitation.
> 
> Ah, OK, return value.  Maybe process_madvise() shouldn't have done that
> and should have simply returned 0 on success, like madvise().
> 
> I guess a special "nuke whole address space" command is OK.  But, again
> in the search for generality, the ability to nuke very large amounts of
> address space (but not the entire address space) would be better. 
> 
> The process_madvise() return value issue could be addressed by adding a
> process_madvise() mode which return 0 on success.
> 
> And I guess the MAX_RW_COUNT issue is solvable by adding an
> import_iovec() arg to say "don't check that".  Along those lines.
> 
> It's all sounding a bit painful (but not *too* painful).  But to
> reiterate, I do think that adding the ability for a process to shoot
> down a large amount of another process's memory is a lot more generally
> useful than tying it to SIGKILL, agree?

I agree the direction but I think it's the general problem for every
APIs have supported iovec and not sure process_madvise is special to
chage it.
IOW, it wouldn't be a problem to support *entire address space* special
mode but not sure to support *large amount of address space* at the cost
of breaking existing iovec scheme.
