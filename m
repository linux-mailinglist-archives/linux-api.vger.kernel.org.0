Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 415D62C531
	for <lists+linux-api@lfdr.de>; Tue, 28 May 2019 13:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfE1LMQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 May 2019 07:12:16 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39760 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfE1LMQ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 28 May 2019 07:12:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id z26so11282085pfg.6;
        Tue, 28 May 2019 04:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yjDDJ/2zUpUMynGNYx1IGW1H0lSoDeccz7vZj839ckk=;
        b=BAMyLVStI/JfGQ5nZP1Aq6dmfML42NpXtmeu9rpv5EXDkgpwcdBMCj5BoUHY9SnjOr
         yXxPTGVcm1Hx0gzDRbOROR6xHoNkDjn+8YH4KGdIS5yqGcjJ8cvw63QBO+FYInAAUo4o
         0KURztiHWmmscsTig7NfQWSmzr3GNbCUKlczYANC0/1T5VGmOQ8Qg4G7aSkj3aFyLYsQ
         zZpqol/Gx09xwV9+VHJCNn0Sz6/inKLr1Szw9JTeIx3fNDBJbilrdXcSAmKL/pXV54WA
         RgyON09Us9klUuI1rvB0RNRW2Y1gYFDUh3tFWPkmUrUKehaLpn3Z2tI4BxK1tpq2Owne
         yOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=yjDDJ/2zUpUMynGNYx1IGW1H0lSoDeccz7vZj839ckk=;
        b=SM9G96JSW+cuqjPo7Gr9DOLsi0/mNTUJxGOe4ZP2DLum0P2AXpofEC0u/cNl2fVIIT
         oPxGNn4Ft43w9sTzOmCqoAPrO1kzSocGmibbYwd5Q0I07dcnkFD85fHNi41ttGD0FsE0
         xciGQ9MLl13a1JvUvvyu8pme/OncnKcY8Uac+IvCmgvmVcSZmatDMuEw4/RfmNYvWBRA
         YW0exttmC8UcO9q2n8zB6E2oKyCbtoyEN8huCA2hAHD2htUD8WMkCGZOM8+KwWiA4l4I
         bcV4RKMElnsCgNy0P53rkgSlOENohYytR2B6X4lLASyJFBQ6JqwD70GP23g+wolJHXpl
         sn+A==
X-Gm-Message-State: APjAAAWDqoLFrDLLO81hhd/5N/cdXaL6Fqs7TvsLFMYErXYvJR7dne2Z
        wTfy2cJZr6diJBrNv4Z2Hgs=
X-Google-Smtp-Source: APXvYqxNxlP/WY14NSuqDMVHVvQZEWNgz/oPlh3HFqtK2YOKKCKnz4314RbUCguqjl5JrhkAUkvk6g==
X-Received: by 2002:a05:6a00:43:: with SMTP id i3mr64202949pfk.113.1559041935394;
        Tue, 28 May 2019 04:12:15 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id f16sm6699086pja.18.2019.05.28.04.12.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 28 May 2019 04:12:14 -0700 (PDT)
Date:   Tue, 28 May 2019 20:12:08 +0900
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
Message-ID: <20190528111208.GA30365@google.com>
References: <20190527075811.GC6879@google.com>
 <20190527124411.GC1658@dhcp22.suse.cz>
 <20190528032632.GF6879@google.com>
 <20190528062947.GL1658@dhcp22.suse.cz>
 <20190528081351.GA159710@google.com>
 <CAKOZuesnS6kBFX-PKJ3gvpkv8i-ysDOT2HE2Z12=vnnHQv0FDA@mail.gmail.com>
 <20190528084927.GB159710@google.com>
 <20190528090821.GU1658@dhcp22.suse.cz>
 <20190528103256.GA9199@google.com>
 <20190528104117.GW1658@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528104117.GW1658@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, May 28, 2019 at 12:41:17PM +0200, Michal Hocko wrote:
> On Tue 28-05-19 19:32:56, Minchan Kim wrote:
> > On Tue, May 28, 2019 at 11:08:21AM +0200, Michal Hocko wrote:
> > > On Tue 28-05-19 17:49:27, Minchan Kim wrote:
> > > > On Tue, May 28, 2019 at 01:31:13AM -0700, Daniel Colascione wrote:
> > > > > On Tue, May 28, 2019 at 1:14 AM Minchan Kim <minchan@kernel.org> wrote:
> > > > > > if we went with the per vma fd approach then you would get this
> > > > > > > feature automatically because map_files would refer to file backed
> > > > > > > mappings while map_anon could refer only to anonymous mappings.
> > > > > >
> > > > > > The reason to add such filter option is to avoid the parsing overhead
> > > > > > so map_anon wouldn't be helpful.
> > > > > 
> > > > > Without chiming on whether the filter option is a good idea, I'd like
> > > > > to suggest that providing an efficient binary interfaces for pulling
> > > > > memory map information out of processes.  Some single-system-call
> > > > > method for retrieving a binary snapshot of a process's address space
> > > > > complete with attributes (selectable, like statx?) for each VMA would
> > > > > reduce complexity and increase performance in a variety of areas,
> > > > > e.g., Android memory map debugging commands.
> > > > 
> > > > I agree it's the best we can get *generally*.
> > > > Michal, any opinion?
> > > 
> > > I am not really sure this is directly related. I think the primary
> > > question that we have to sort out first is whether we want to have
> > > the remote madvise call process or vma fd based. This is an important
> > > distinction wrt. usability. I have only seen pid vs. pidfd discussions
> > > so far unfortunately.
> > 
> > With current usecase, it's per-process API with distinguishable anon/file
> > but thought it could be easily extended later for each address range
> > operation as userspace getting smarter with more information.
> 
> Never design user API based on a single usecase, please. The "easily
> extended" part is by far not clear to me TBH. As I've already mentioned
> several times, the synchronization model has to be thought through
> carefuly before a remote process address range operation can be
> implemented.

I agree with you that we shouldn't design API on single usecase but what
you are concerning is actually not our usecase because we are resilient
with the race since MADV_COLD|PAGEOUT is not destruptive.
Actually, many hints are already racy in that the upcoming pattern would
be different with the behavior you thought at the moment.

If you are still concerning of address range synchronization, how about
moving such hints to per-process level like prctl?
Does it make sense to you?
