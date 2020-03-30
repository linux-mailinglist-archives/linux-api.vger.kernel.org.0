Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 671CF198270
	for <lists+linux-api@lfdr.de>; Mon, 30 Mar 2020 19:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgC3Req (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 30 Mar 2020 13:34:46 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40682 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgC3Req (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 30 Mar 2020 13:34:46 -0400
Received: by mail-ed1-f66.google.com with SMTP id w26so21734456edu.7
        for <linux-api@vger.kernel.org>; Mon, 30 Mar 2020 10:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=muZ7cPZFQ8cxw9nf/MmRBFJ/dzmezYL1BINaJ/MaYNA=;
        b=fEdNo5qKKvxYhCP9NHWm118eInVbYHUVNwSOC4xHDnWpu70fOgff1QB89wCE21CvbD
         a1EWOOJ5rriEIzg5k5GQTAr7ElZZyZAgGckmHIicOJbVOP/DW8h+TCXUA/zxWmrAulJT
         TzTFtnXZlldBAUGz7xmSjI8pIsaQ9NfyHgnDEfjeqSfkOlz3ml1gJkgmvdP7hktfBzBj
         ZfQVEfu0EYd4CN9mXOISk6OHvwhXY1+OF09B0du7yHvMCUXFy4ZBIq2Rxy8iNWop8yq8
         A2BVHvbVmNGDlbZrJmtZFTUFPjFT+K4vVZyCePI1oAzysXL9fNLqJB9h8lzP0o6aY+Mg
         M+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=muZ7cPZFQ8cxw9nf/MmRBFJ/dzmezYL1BINaJ/MaYNA=;
        b=fgxynDIGM7hpKaXlyxvqfJzKVnP9zYy7qFU2+q6RHKeK4FW/e3uFM31ZGZZp90ZLQ5
         DLsuFjdynLP4C6008zDhg3TA4UJ4t/6FbK8k4BBqG2b3mAR3GKYtlYCe5RjcIrBd5Hto
         fdpKPsA0u/xvoyM55g7alDnrshmTI5mPQ1RpfiPN+PH0z3T6ukrrMmUTbk1Wk0tpg8gr
         INXSkhGyC6v/4UChe4NWv8FRpdNtBEonmdyPLyGOVmrE09OtedsO4PwNdG2fbAUkEx4D
         S/oiZvT+qJJVpQj6HpBp78RUIqPKXRm8wUOlTPdzuSKsODG2J3guQGBWQ6V25Ow7r41X
         Ktsg==
X-Gm-Message-State: ANhLgQ2efRul3YHPFKrHOhvRmxX1nEGIEHZelgrPG0ivhq4wBeQYuTQG
        3+u0WTTu/wGzqfqsrgD3uGmMZMym6p1+4r26Ehsy
X-Google-Smtp-Source: ADFU+vvWyjeXZ/PdtyejMszVe/JujDQQm9Ki7W49J7AC09qvQDYWrj9ZRWQy/F0568BEILF1bzcMRDDUMW+YuKujdOI=
X-Received: by 2002:aa7:db56:: with SMTP id n22mr12348353edt.269.1585589683740;
 Mon, 30 Mar 2020 10:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200318212630.mw2geg4ykhnbtr3k@madcap2.tricolour.ca>
 <CAHC9VhRYvGAru3aOMwWKCCWDktS+2pGr+=vV4SjHW_0yewD98A@mail.gmail.com>
 <20200318215550.es4stkjwnefrfen2@madcap2.tricolour.ca> <CAHC9VhSdDDP7Ec-w61NhGxZG5ZiekmrBCAg=Y=VJvEZcgQh46g@mail.gmail.com>
 <20200319220249.jyr6xmwvflya5mks@madcap2.tricolour.ca> <CAHC9VhR84aN72yNB_j61zZgrQV1y6yvrBLNY7jp7BqQiEDL+cw@mail.gmail.com>
 <20200324210152.5uydf3zqi3dwshfu@madcap2.tricolour.ca> <CAHC9VhTQUnVhoN3JXTAQ7ti+nNLfGNVXhT6D-GYJRSpJHCwDRg@mail.gmail.com>
 <20200330134705.jlrkoiqpgjh3rvoh@madcap2.tricolour.ca> <CAHC9VhQTsEMcYAF1CSHrrVn07DR450W9j6sFVfKAQZ0VpheOfw@mail.gmail.com>
 <20200330162156.mzh2tsnovngudlx2@madcap2.tricolour.ca>
In-Reply-To: <20200330162156.mzh2tsnovngudlx2@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 30 Mar 2020 13:34:34 -0400
Message-ID: <CAHC9VhTRzZXJ6yUFL+xZWHNWZFTyiizBK12ntrcSwmgmySbkWw@mail.gmail.com>
Subject: Re: [PATCH ghak90 V8 07/16] audit: add contid support for signalling
 the audit daemon
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     nhorman@tuxdriver.com, linux-api@vger.kernel.org,
        containers@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, dhowells@redhat.com,
        linux-audit@redhat.com, netfilter-devel@vger.kernel.org,
        ebiederm@xmission.com, simo@redhat.com, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        mpatel@redhat.com, Serge Hallyn <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Mar 30, 2020 at 12:22 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2020-03-30 10:26, Paul Moore wrote:
> > On Mon, Mar 30, 2020 at 9:47 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > On 2020-03-28 23:11, Paul Moore wrote:
> > > > On Tue, Mar 24, 2020 at 5:02 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > > On 2020-03-23 20:16, Paul Moore wrote:
> > > > > > On Thu, Mar 19, 2020 at 6:03 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > > > > On 2020-03-18 18:06, Paul Moore wrote:
> > > > > >
> > > > > > ...
> > > > > >
> > > > > > > > I hope we can do better than string manipulations in the kernel.  I'd
> > > > > > > > much rather defer generating the ACID list (if possible), than
> > > > > > > > generating a list only to keep copying and editing it as the record is
> > > > > > > > sent.
> > > > > > >
> > > > > > > At the moment we are stuck with a string-only format.
> > > > > >
> > > > > > Yes, we are.  That is another topic, and another set of changes I've
> > > > > > been deferring so as to not disrupt the audit container ID work.
> > > > > >
> > > > > > I was thinking of what we do inside the kernel between when the record
> > > > > > triggering event happens and when we actually emit the record to
> > > > > > userspace.  Perhaps we collect the ACID information while the event is
> > > > > > occurring, but we defer generating the record until later when we have
> > > > > > a better understanding of what should be included in the ACID list.
> > > > > > It is somewhat similar (but obviously different) to what we do for
> > > > > > PATH records (we collect the pathname info when the path is being
> > > > > > resolved).
> > > > >
> > > > > Ok, now I understand your concern.
> > > > >
> > > > > In the case of NETFILTER_PKT records, the CONTAINER_ID record is the
> > > > > only other possible record and they are generated at the same time with
> > > > > a local context.
> > > > >
> > > > > In the case of any event involving a syscall, that CONTAINER_ID record
> > > > > is generated at the time of the rest of the event record generation at
> > > > > syscall exit.
> > > > >
> > > > > The others are only generated when needed, such as the sig2 reply.
> > > > >
> > > > > We generally just store the contobj pointer until we actually generate
> > > > > the CONTAINER_ID (or CONTAINER_OP) record.
> > > >
> > > > Perhaps I'm remembering your latest spin of these patches incorrectly,
> > > > but there is still a big gap between when the record is generated and
> > > > when it is sent up to the audit daemon.  Most importantly in that gap
> > > > is the whole big queue/multicast/unicast mess.
> > >
> > > So you suggest generating that record on the fly once it reaches the end
> > > of the audit_queue just before being sent?  That sounds...  disruptive.
> > > Each audit daemon is going to have its own queues, so by the time it
> > > ends up in a particular queue, we'll already know its scope and would
> > > have the right list of contids to print in that record.
> >
> > I'm not suggesting any particular solution, I'm just pointing out a
> > potential problem.  It isn't clear to me that you've thought about how
> > we generate a multiple records, each with the correct ACID list
> > intended for a specific audit daemon, based on a single audit event.
> > Explain to me how you intend that to work and we are good.  Be
> > specific because I'm not convinced we are talking on the same plane
> > here.
>
> Well, every time a record gets generated, *any* record gets generated,
> we'll need to check for which audit daemons this record is in scope and
> generate a different one for each depending on the content and whether
> or not the content is influenced by the scope.

That's the problem right there - we don't want to have to generate a
unique record for *each* auditd on *every* record.  That is a recipe
for disaster.

Solving this for all of the known audit records is not something we
need to worry about in depth at the moment (although giving it some
casual thought is not a bad thing), but solving this for the audit
container ID information *is* something we need to worry about right
now.

-- 
paul moore
www.paul-moore.com
