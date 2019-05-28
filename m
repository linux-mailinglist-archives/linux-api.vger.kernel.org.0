Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F57A2C68E
	for <lists+linux-api@lfdr.de>; Tue, 28 May 2019 14:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfE1McL (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 May 2019 08:32:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:35846 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726592AbfE1McL (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 28 May 2019 08:32:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 30483B016;
        Tue, 28 May 2019 12:32:09 +0000 (UTC)
Date:   Tue, 28 May 2019 14:32:08 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Daniel Colascione <dancol@google.com>
Cc:     Minchan Kim <minchan@kernel.org>,
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
Message-ID: <20190528123208.GC1658@dhcp22.suse.cz>
References: <20190528062947.GL1658@dhcp22.suse.cz>
 <20190528081351.GA159710@google.com>
 <CAKOZuesnS6kBFX-PKJ3gvpkv8i-ysDOT2HE2Z12=vnnHQv0FDA@mail.gmail.com>
 <20190528084927.GB159710@google.com>
 <20190528090821.GU1658@dhcp22.suse.cz>
 <CAKOZueux3T4_dMOUK6R=ZHhCFaSSstOCPh_KSwSMCW_yp=jdSg@mail.gmail.com>
 <20190528103312.GV1658@dhcp22.suse.cz>
 <CAKOZueuRAtps+YZ1g2SOevBrDwE6tWsTuONJu1NLgvW7cpA-ug@mail.gmail.com>
 <20190528114923.GZ1658@dhcp22.suse.cz>
 <CAKOZueuerHTCPbQqowSxi-_sRsqxYQQqgyi1UOh7EkZcS3DCnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZueuerHTCPbQqowSxi-_sRsqxYQQqgyi1UOh7EkZcS3DCnA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue 28-05-19 05:11:16, Daniel Colascione wrote:
> On Tue, May 28, 2019 at 4:49 AM Michal Hocko <mhocko@kernel.org> wrote:
[...]
> > > We have various system calls that provide hints for open files, but
> > > the memory operations are distinct. Modeling anonymous memory as a
> > > kind of file-backed memory for purposes of VMA manipulation would also
> > > be a departure from existing practice. Can you help me understand why
> > > you seem to favor the FD-per-VMA approach so heavily? I don't see any
> > > arguments *for* an FD-per-VMA model for remove memory manipulation and
> > > I see a lot of arguments against it. Is there some compelling
> > > advantage I'm missing?
> >
> > First and foremost it provides an easy cookie to the userspace to
> > guarantee time-to-check-time-to-use consistency.
> 
> But only for one VMA at a time.

Which is the unit we operate on, right?

> > It also naturally
> > extend an existing fadvise interface that achieves madvise semantic on
> > files.
> 
> There are lots of things that madvise can do that fadvise can't and
> that don't even really make sense for fadvise, e.g., MADV_FREE. It
> seems odd to me to duplicate much of the madvise interface into
> fadvise so that we can use file APIs to give madvise hints. It seems
> simpler to me to just provide a mechanism to put the madvise hints
> where they're needed.

I do not see why we would duplicate. I confess I haven't tried to
implement this so I might be overlooking something but it seems to me
that we could simply reuse the same functionality from both APIs.

> > I am not really pushing hard for this particular API but I really
> > do care about a programming model that would be sane.
> 
> You've used "sane" twice so far in this message. Can you specify more
> precisely what you mean by that word?

Well, I would consider a model which would prevent from unintended side
effects (e.g. working on a completely different object) without a tricky
synchronization sane.

> I agree that there needs to be
> some defense against TOCTOU races when doing remote memory management,
> but I don't think providing this robustness via a file descriptor is
> any more sane than alternative approaches. A file descriptor comes
> with a lot of other features --- e.g., SCM_RIGHTS, fstat, and a
> concept of owning a resource --- that aren't needed to achieve
> robustness.
> 
> Normally, a file descriptor refers to some resource that the kernel
> holds as long as the file descriptor (well, the open file description
> or struct file) lives -- things like graphics buffers, files, and
> sockets. If we're using an FD *just* as a cookie and not a resource,
> I'd rather just expose the cookie directly.

You are absolutely right. But doesn't that apply to any other
revalidation method that would be tracking VMA status as well. As I've
said I am not married to this approach as long as there are better
alternatives. So far we are in a discussion what should be the actual
semantic of the operation and how much do we want to tolerate races. And
it seems that we are diving into implementation details rather than
landing with a firm decision that the current proposed API is suitable
or not.

> > If we have a
> > different means to achieve the same then all fine by me but so far I
> > haven't heard any sound arguments to invent something completely new
> > when we have established APIs to use.
> 
> Doesn't the next sentence describe something profoundly new? :-)
> 
> > Exporting anonymous mappings via
> > proc the same way we do for file mappings doesn't seem to be stepping
> > outside of the current practice way too much.
> 
> It seems like a radical departure from existing practice to provide
> filesystem interfaces to anonymous memory regions, e.g., anon_vma.
> You've never been able to refer to those memory regions with file
> descriptors.
> 
> All I'm suggesting is that we take the existing madvise mechanism,
> make it work cross-process, and make it robust against TOCTOU
> problems, all one step at a time. Maybe my sense of API "size" is
> miscalibrated, but adding a new type of FD to refer to anonymous VMA
> regions feels like a bigger departure and so requires stronger
> justification, especially if the result of the FD approach is probably
> something less efficient than a cookie-based one.

Feel free to propose the way to achieve that in the respective email
thread.
 
> > and we should focus on discussing whether this is a
> > sane model. And I think it would be much better to discuss that under
> > the respective patch which introduces that API rather than here.
> 
> I think it's important to discuss what that API should look like. :-)

It will be fun to follow this discussion and make some sense of
different parallel threads.

-- 
Michal Hocko
SUSE Labs
