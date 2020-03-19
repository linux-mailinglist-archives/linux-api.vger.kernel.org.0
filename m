Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF6C418C2B3
	for <lists+linux-api@lfdr.de>; Thu, 19 Mar 2020 23:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbgCSWDU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 19 Mar 2020 18:03:20 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:51744 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726867AbgCSWDS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Mar 2020 18:03:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584655396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/mdxk2khEaDoWIwtVFmt93rKTZk2xKfiNva34Q7ynLE=;
        b=X5UIMxMtQPRa+jb20jtL+71wesqkkLISuomHPSOjRnbNceamlxKzBPaCIntGYSdmhkEYrV
        ep6S+PnUbUNF0TpEDUFZuW2kuxakQaTV+pQeCTv/iV8aK+bnmyF5clEb0XTcf/Ny80cBTS
        6eEjZx30yCzD384wlWcyOiR4TcBIG6k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-arOU1dVhPROw7mgYVI1lzA-1; Thu, 19 Mar 2020 18:03:14 -0400
X-MC-Unique: arOU1dVhPROw7mgYVI1lzA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 988B5107ACC9;
        Thu, 19 Mar 2020 22:03:12 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.36.110.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A1BF5BBBEB;
        Thu, 19 Mar 2020 22:02:53 +0000 (UTC)
Date:   Thu, 19 Mar 2020 18:02:49 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Steve Grubb <sgrubb@redhat.com>, linux-audit@redhat.com,
        nhorman@tuxdriver.com, linux-api@vger.kernel.org,
        containers@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, dhowells@redhat.com,
        netfilter-devel@vger.kernel.org, ebiederm@xmission.com,
        simo@redhat.com, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        mpatel@redhat.com, Serge Hallyn <serge@hallyn.com>
Subject: Re: [PATCH ghak90 V8 07/16] audit: add contid support for signalling
 the audit daemon
Message-ID: <20200319220249.jyr6xmwvflya5mks@madcap2.tricolour.ca>
References: <CAHC9VhTiCHQbp2SwK0Xb1QgpUZxOQ26JKKPsVGT0ZvMqx28oPQ@mail.gmail.com>
 <CAHC9VhS09b_fM19tn7pHZzxfyxcHnK+PJx80Z9Z1hn8-==4oLA@mail.gmail.com>
 <20200312193037.2tb5f53yeisfq4ta@madcap2.tricolour.ca>
 <CAHC9VhQoVOzy_b9W6h+kmizKr1rPkC4cy5aYoKT2i0ZgsceNDg@mail.gmail.com>
 <20200313185900.y44yvrfm4zxa5lfk@madcap2.tricolour.ca>
 <CAHC9VhR2zCCE5bjH75rSwfLC7TJGFj4RBnrtcOoUiqVp9q5TaA@mail.gmail.com>
 <20200318212630.mw2geg4ykhnbtr3k@madcap2.tricolour.ca>
 <CAHC9VhRYvGAru3aOMwWKCCWDktS+2pGr+=vV4SjHW_0yewD98A@mail.gmail.com>
 <20200318215550.es4stkjwnefrfen2@madcap2.tricolour.ca>
 <CAHC9VhSdDDP7Ec-w61NhGxZG5ZiekmrBCAg=Y=VJvEZcgQh46g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhSdDDP7Ec-w61NhGxZG5ZiekmrBCAg=Y=VJvEZcgQh46g@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 2020-03-18 18:06, Paul Moore wrote:
> On Wed, Mar 18, 2020 at 5:56 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > On 2020-03-18 17:42, Paul Moore wrote:
> > > On Wed, Mar 18, 2020 at 5:27 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > On 2020-03-18 16:56, Paul Moore wrote:
> > > > > On Fri, Mar 13, 2020 at 2:59 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > > > On 2020-03-13 12:29, Paul Moore wrote:
> > > > > > > On Thu, Mar 12, 2020 at 3:30 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > > > > > On 2020-02-13 16:44, Paul Moore wrote:
> > > > > > > > > This is a bit of a thread-hijack, and for that I apologize, but
> > > > > > > > > another thought crossed my mind while thinking about this issue
> > > > > > > > > further ... Once we support multiple auditd instances, including the
> > > > > > > > > necessary record routing and duplication/multiple-sends (the host
> > > > > > > > > always sees *everything*), we will likely need to find a way to "trim"
> > > > > > > > > the audit container ID (ACID) lists we send in the records.  The
> > > > > > > > > auditd instance running on the host/initns will always see everything,
> > > > > > > > > so it will want the full container ACID list; however an auditd
> > > > > > > > > instance running inside a container really should only see the ACIDs
> > > > > > > > > of any child containers.
> > > > > > > >
> > > > > > > > Agreed.  This should be easy to check and limit, preventing an auditd
> > > > > > > > from seeing any contid that is a parent of its own contid.
> > > > > > > >
> > > > > > > > > For example, imagine a system where the host has containers 1 and 2,
> > > > > > > > > each running an auditd instance.  Inside container 1 there are
> > > > > > > > > containers A and B.  Inside container 2 there are containers Y and Z.
> > > > > > > > > If an audit event is generated in container Z, I would expect the
> > > > > > > > > host's auditd to see a ACID list of "1,Z" but container 1's auditd
> > > > > > > > > should only see an ACID list of "Z".  The auditd running in container
> > > > > > > > > 2 should not see the record at all (that will be relatively
> > > > > > > > > straightforward).  Does that make sense?  Do we have the record
> > > > > > > > > formats properly designed to handle this without too much problem (I'm
> > > > > > > > > not entirely sure we do)?
> > > > > > > >
> > > > > > > > I completely agree and I believe we have record formats that are able to
> > > > > > > > handle this already.
> > > > > > >
> > > > > > > I'm not convinced we do.  What about the cases where we have a field
> > > > > > > with a list of audit container IDs?  How do we handle that?
> > > > > >
> > > > > > I don't understand the problem.  (I think you crossed your 1/2 vs
> > > > > > A/B/Y/Z in your example.) ...
> > > > >
> > > > > It looks like I did, sorry about that.
> > > > >
> > > > > > ... Clarifying the example above, if as you
> > > > > > suggest an event happens in container Z, the hosts's auditd would report
> > > > > >         Z,^2
> > > > > > and the auditd in container 2 would report
> > > > > >         Z,^2
> > > > > > but if there were another auditd running in container Z it would report
> > > > > >         Z
> > > > > > while the auditd in container 1 or A/B would see nothing.
> > > > >
> > > > > Yes.  My concern is how do we handle this to minimize duplicating and
> > > > > rewriting the records?  It isn't so much about the format, although
> > > > > the format is a side effect.
> > > >
> > > > Are you talking about caching, or about divulging more information than
> > > > necessary or even information leaks?  Or even noticing that records that
> > > > need to be generated to two audit daemons share the same contid field
> > > > values and should be generated at the same time or information shared
> > > > between them?  I'd see any of these as optimizations that don't affect
> > > > the api.
> > >
> > > Imagine a record is generated in a container which has more than one
> > > auditd in it's ancestry that should receive this record, how do we
> > > handle that without completely killing performance?  That's my
> > > concern.  If you've already thought up a plan for this - excellent,
> > > please share :)
> >
> > No, I haven't given that much thought other than the correctness and
> > security issues of making sure that each audit daemon is sufficiently
> > isolated to do its job but not jeopardize another audit domain.  Audit
> > already kills performance, according to some...
> >
> > We currently won't have that problem since there can only be one so far.
> > Fixing and optimizing this is part of the next phase of the challenge of
> > adding a second audit daemon.
> >
> > Let's work on correctness and reasonable efficiency for this phase and
> > not focus on a problem we don't yet have.  I wouldn't consider this
> > incurring technical debt at this point.
> 
> I agree, one stage at a time, but the choice we make here is going to
> have a significant impact on what we can do later.  We need to get
> this as "right" as possible; this isn't something we should dismiss
> with a hand-wave as a problem for the next stage.  We don't need an
> implementation, but I would like to see a rough design of how we would
> address this problem.
> 
> > I could see cacheing a contid string from one starting point, but it may
> > be more work to search that cached string to truncate it or add to it
> > when another audit daemon requests a copy of a similar string.  I
> > suppose every full contid string could be generated the first time it is
> > used and parts of it used (start/finish) as needed but that
> > search/indexing may not be worth it.
> 
> I hope we can do better than string manipulations in the kernel.  I'd
> much rather defer generating the ACID list (if possible), than
> generating a list only to keep copying and editing it as the record is
> sent.

At the moment we are stuck with a string-only format.  The contid list
only exists in the kernel.  When do you suggest generating the contid
list?  It sounds like you are hinting at userspace generating that list
from multiple records over the span of audit logs since boot of the
machine.

Even if we had a binary format, the current design would require
generating that list at the time of record generation since it could be
any contiguous subset of a full nested contid list.

> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

