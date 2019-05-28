Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 148FD2C564
	for <lists+linux-api@lfdr.de>; Tue, 28 May 2019 13:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfE1L3L (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 May 2019 07:29:11 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:45076 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfE1L3L (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 28 May 2019 07:29:11 -0400
Received: by mail-ua1-f67.google.com with SMTP id n7so7674232uap.12
        for <linux-api@vger.kernel.org>; Tue, 28 May 2019 04:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ErCw9IwjYB4Bm/ESOgoCUc6lJbwqN2Dix2Mj1yQzd4s=;
        b=R0/dA5gVTuqKyN68OazVy0ZK/+lBLi08VEkT1epXWUFRyykQYWIf6MEAWFHbayO86S
         njYzeCF1jHKPHahHZtbkHQgKUobmXAr6hK08h0gux6hRvtgvzasb/EU/Crlc9ZmAaUR9
         IC6CqTSYqeTJfZ7C+3OoBAI97kWygVy/CRI3jdeuMlJvs7E5IVxIBAlqoo12x+8f9/Id
         /LA+fxpVzsOpjCoibwz3lOot3VeJhXNlOk6X1Dqdv4m3Lf5YRydGXeBKwG5Qew6olh6C
         //0qUcW9M+gAwQPZqMWLLNlmgI4ixud4Go4mBZjfuHLzCGiJq7JOCCCD3gY20WUQYNAW
         LyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ErCw9IwjYB4Bm/ESOgoCUc6lJbwqN2Dix2Mj1yQzd4s=;
        b=TSDPFpu3ZCCSldgT3DylHTsMs3muKt2DMllNAmYL4hZiy7IqpvwQd8hMWHRSDvjDWR
         JTYlWOIsBvNknPcfTf7Kr2PWU0KTWiAQnbhQxYlFLHiJJZFRVNi5G8LKsIENvNlNJcpW
         JVtlDpv6bJAwDEH3qtbdKJzBqJ6AogK5gAaDhnEdXBsfTWk6XNgbvAHuvjX8CjDd2JF9
         a5H63Upwy2d+K5FzDM0zzX5LdrmGD4zYUja/0JGYgRTLCCTOzQhCvg24b2xs2H4D8Lgo
         JtQ69ycPnUJKhNXFQI/EcRqzkXO+Wc3D7l6yknNm+uJsKEvNeHQ7sulN1Lf6gzWqWNkJ
         52bw==
X-Gm-Message-State: APjAAAWG2kSagggI5g8K32617/sO8wAdUs88GaZSRFgIt942Lc5BL3Se
        y393czFMvovw+ovYCG4kuwyE5PyA1Qv1HJ/sWGJaoA==
X-Google-Smtp-Source: APXvYqzvCr8BFUAHqTS6Ysg8FvWrlyc0IxBbY5jsKNEqaA4c8t6D2O1A/O2hdxM9gRvzOoACI+VZLI1/FgNDQvxi+p4=
X-Received: by 2002:ab0:60d0:: with SMTP id g16mr47460086uam.85.1559042950097;
 Tue, 28 May 2019 04:29:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190521062628.GE32329@dhcp22.suse.cz> <20190527075811.GC6879@google.com>
 <20190527124411.GC1658@dhcp22.suse.cz> <20190528032632.GF6879@google.com>
 <20190528062947.GL1658@dhcp22.suse.cz> <20190528081351.GA159710@google.com>
 <CAKOZuesnS6kBFX-PKJ3gvpkv8i-ysDOT2HE2Z12=vnnHQv0FDA@mail.gmail.com>
 <20190528084927.GB159710@google.com> <20190528090821.GU1658@dhcp22.suse.cz>
 <20190528103256.GA9199@google.com> <20190528104117.GW1658@dhcp22.suse.cz>
In-Reply-To: <20190528104117.GW1658@dhcp22.suse.cz>
From:   Daniel Colascione <dancol@google.com>
Date:   Tue, 28 May 2019 04:28:58 -0700
Message-ID: <CAKOZuevBtH8Sz9s+kRqrXo4HDq0GBMVDfDFRAgGOU9pguVhCWQ@mail.gmail.com>
Subject: Re: [RFC 7/7] mm: madvise support MADV_ANONYMOUS_FILTER and MADV_FILE_FILTER
To:     Michal Hocko <mhocko@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, May 28, 2019 at 3:41 AM Michal Hocko <mhocko@kernel.org> wrote:
>
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

I don't think anyone is overfitting for a specific use case. When some
process A wants to manipulate process B's memory, it's fair for A to
want to know what memory it's manipulating. That's a general concern
that applies to a large family of cross-process memory operations.
It's less important for non-destructive hints than for some kind of
destructive operation, but the same idea applies. If there's a simple
way to solve this A-B information problem in a general way, it seems
to be that we should apply that general solution. Likewise, an API to
get an efficiently-collected snapshot of a process's address space
would be immediately useful in several very different use cases,
including debuggers, Android memory use reporting tools, and various
kinds of metric collection. Because we're talking about mechanisms
that solve several independent problems at the same time and in a
general way, it doesn't sound to me like overfitting for a particular
use case.
