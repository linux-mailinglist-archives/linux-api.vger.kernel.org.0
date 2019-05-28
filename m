Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87D7E2C449
	for <lists+linux-api@lfdr.de>; Tue, 28 May 2019 12:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfE1KdE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 May 2019 06:33:04 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32787 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfE1KdE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 28 May 2019 06:33:04 -0400
Received: by mail-pf1-f196.google.com with SMTP id z28so11224446pfk.0;
        Tue, 28 May 2019 03:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=krgMSnEVy69yoxUL6+FT3pw/Wcuo2yl9vll0sSUGOww=;
        b=fvqIxpSuquyR4BpSeT5rFWP7ErwjkwJUnGWEyfvDGxz5/uVzNBZyAiZUKtfnK9WSVm
         H92bdTd0JQq+meoxC/A7cAvM+LRpEpouDQA/Ac2uSJKJPNOzcy4CzGpjewrZGPEG8LHo
         QASLekxEG4UQqoj3JFCRy87xxphDAuDtN6Oti3uuco3K8+nygGPwAroVtyo+eM4hURtU
         7CKlX+ZoGV4ttxIBpBpa2Bh1pNKOMsk2eIWVef+vUVuyz6yF4SY+KQkJXIyCcdZc0eFm
         hCLhXnKVp4N6ZqzWkdxWMrxBHfFRe0MCOaSf3xL6YVgnU31InTxQImkkGN5E4ypIlJXY
         YTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=krgMSnEVy69yoxUL6+FT3pw/Wcuo2yl9vll0sSUGOww=;
        b=j0TkbW6r7Wjap+iM8ApUgWr7NdH3eBffSj8/WSZGSou7MJtsMKNNDKjQx1KKmNSR8F
         hUBPTCAErCttntXaeIE7fUxzKkKpx0ov0p4MmxsLFxaGYvxezGhjibFcK0SyaXegka8k
         3VGFgWg1jZqZsvG4YIHSxPAtVPrrLEHRXCz+pc0NvPvuDaKr66mzJtE43DofzZaxBp3r
         GvhnnpHNviaW13YOl87xtXHQ/veEKGbm76Vcss3FPIiqBZHZO5qvWmwTMfu+K3VUBm/V
         qOLygQz8vqIEBKc6jpXu/J9blEXQZgxNTK/PRrJVZ9+53YSOdv02sI1sHUnL7JaMKkrU
         F1sA==
X-Gm-Message-State: APjAAAV0XSewLXRyiMGcwjEAuboD6pa/wZKblJO/RVtuR2VHHi/EdO6I
        tIEUPPhKcIH6010YIkbod2Y=
X-Google-Smtp-Source: APXvYqxc+D0LEa1va91F68TbeYEmhMPMKJQZ9LgkOR5KNw+jdrb9GAAsS0CDZJbmp0XQkrYEFbL5rA==
X-Received: by 2002:a62:2c17:: with SMTP id s23mr112033131pfs.51.1559039583555;
        Tue, 28 May 2019 03:33:03 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id m7sm8226184pff.44.2019.05.28.03.32.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 28 May 2019 03:33:02 -0700 (PDT)
Date:   Tue, 28 May 2019 19:32:56 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Daniel Colascione <dancol@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [RFC 7/7] mm: madvise support MADV_ANONYMOUS_FILTER and
 MADV_FILE_FILTER
Message-ID: <20190528103256.GA9199@google.com>
References: <20190521025533.GH10039@google.com>
 <20190521062628.GE32329@dhcp22.suse.cz>
 <20190527075811.GC6879@google.com>
 <20190527124411.GC1658@dhcp22.suse.cz>
 <20190528032632.GF6879@google.com>
 <20190528062947.GL1658@dhcp22.suse.cz>
 <20190528081351.GA159710@google.com>
 <CAKOZuesnS6kBFX-PKJ3gvpkv8i-ysDOT2HE2Z12=vnnHQv0FDA@mail.gmail.com>
 <20190528084927.GB159710@google.com>
 <20190528090821.GU1658@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528090821.GU1658@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, May 28, 2019 at 11:08:21AM +0200, Michal Hocko wrote:
> On Tue 28-05-19 17:49:27, Minchan Kim wrote:
> > On Tue, May 28, 2019 at 01:31:13AM -0700, Daniel Colascione wrote:
> > > On Tue, May 28, 2019 at 1:14 AM Minchan Kim <minchan@kernel.org> wrote:
> > > > if we went with the per vma fd approach then you would get this
> > > > > feature automatically because map_files would refer to file backed
> > > > > mappings while map_anon could refer only to anonymous mappings.
> > > >
> > > > The reason to add such filter option is to avoid the parsing overhead
> > > > so map_anon wouldn't be helpful.
> > > 
> > > Without chiming on whether the filter option is a good idea, I'd like
> > > to suggest that providing an efficient binary interfaces for pulling
> > > memory map information out of processes.  Some single-system-call
> > > method for retrieving a binary snapshot of a process's address space
> > > complete with attributes (selectable, like statx?) for each VMA would
> > > reduce complexity and increase performance in a variety of areas,
> > > e.g., Android memory map debugging commands.
> > 
> > I agree it's the best we can get *generally*.
> > Michal, any opinion?
> 
> I am not really sure this is directly related. I think the primary
> question that we have to sort out first is whether we want to have
> the remote madvise call process or vma fd based. This is an important
> distinction wrt. usability. I have only seen pid vs. pidfd discussions
> so far unfortunately.

With current usecase, it's per-process API with distinguishable anon/file
but thought it could be easily extended later for each address range
operation as userspace getting smarter with more information.
